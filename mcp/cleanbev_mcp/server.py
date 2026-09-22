import os
import re
import subprocess
import json
from pathlib import Path
from typing import Any
 
import yaml
from mcp.server.mcpserver import MCPServer
 

mcp = MCPServer("cleanbev")
 
 
@mcp.tool()
def verify_flutter_project(project_path: str) -> str:
    """
    Verify whether a given directory is a valid Flutter project.
 
    Checks performed:
    1. Directory exists
    2. pubspec.yaml is present
    3. pubspec.yaml contains a valid 'flutter' SDK dependency
    4. lib/ directory exists
    5. A main entry point exists (lib/main.dart or bin/*.dart)
 
    Args:
        project_path: Absolute path to the project root directory.
 
    Returns:
        JSON with is_flutter (bool), checks (dict of each test), and a summary message.
    """
    root = Path(project_path).expanduser().resolve()
    checks = {}
 
    # 1. Directory exists
    checks["directory_exists"] = root.is_dir()
    if not checks["directory_exists"]:
        return json.dumps({
            "is_flutter": False,
            "checks": checks,
            "message": f"Directory not found: {root}",
        }, indent=2)
 
    # 2. pubspec.yaml exists
    pubspec_path = root / "pubspec.yaml"
    checks["pubspec_yaml_exists"] = pubspec_path.is_file()
 
    # 3. pubspec.yaml has flutter SDK dep
    checks["has_flutter_sdk"] = False
    checks["pubspec_readable"] = False
    project_name = None
    if checks["pubspec_yaml_exists"]:
        try:
            with open(pubspec_path) as f:
                pubspec = yaml.safe_load(f)
            checks["pubspec_readable"] = True
            project_name = pubspec.get("name")
            env = pubspec.get("environment", {}) or {}
            deps = pubspec.get("dependencies", {}) or {}
            checks["has_flutter_sdk"] = (
                "flutter" in env or "flutter" in deps
            )
        except Exception:
            checks["pubspec_readable"] = False
 
    # 4. lib/ directory exists
    checks["lib_dir_exists"] = (root / "lib").is_dir()
 
    # 5. Entry point exists
    has_main = (root / "lib" / "main.dart").is_file()
    has_bin = any((root / "bin").glob("*.dart")) if (root / "bin").is_dir() else False
    checks["entry_point_exists"] = has_main or has_bin
 
    # Verdict
    is_flutter = (
        checks["pubspec_yaml_exists"]
        and checks["has_flutter_sdk"]
    )
 
    passed = sum(checks.values())
    total = len(checks)
 
    if is_flutter:
        name_str = f" ({project_name})" if project_name else ""
        message = f"✅ Valid Flutter project{name_str}. {passed}/{total} checks passed."
    else:
        failed = [k for k, v in checks.items() if not v]
        message = f"❌ Not a Flutter project. Failed checks: {', '.join(failed)}"
 
    return json.dumps({
        "is_flutter": is_flutter,
        "project_name": project_name,
        "project_root": str(root),
        "checks": checks,
        "message": message,
    }, indent=2)
 

 @mcp.tool()
 def scan(project_path: str) -> str :
    """
    List all unused assets in a Flutter project WITHOUT deleting anything.
    Always call this first and show the results to the user before cleaning.

    Args:
        project_path: Absolute path to the Flutter project root.

    Returns:
        JSON with the list of unused assets found.
    """
    verification_raw = verify_flutter_project(project_path)
    verification = json.loads(verification_raw)

    if not verification.get("is_flutter"):
        return json.dumps({
            "success": False,
            "message": f"Aborted: {verification.get('message')}",
        }, indent=2)

    try:
        result = subprocess.run(
            ["dart", "pub", "global", "run", "cleanbev", "--dry-run"],
            capture_output=True,
            text=True,
            cwd=project_path,
        )
        return json.dumps({
            "success": result.returncode == 0,
            "unused_assets": result.stdout.strip(),
            "message": "⚠️ Review the list above, then call clean_assets() with confirmed=True to delete.",
        }, indent=2)

    except FileNotFoundError:
        return json.dumps({
            "success": False,
            "message": "❌ 'dart' not found on PATH.",
        }, indent=2)
 

 
@mcp.tool()
def clean_assets(project_path: str, confirmed: bool = False) -> str:
    """
    Delete unused assets ONLY after the user has reviewed the scan results
    and explicitly confirmed. Requires confirmed=True — this is the safety gate.

    IMPORTANT: Always call scan_assets() first and present results to the user.
    Only call this tool after the user says 'yes', 'confirm', 'go ahead', etc.

    Args:
        project_path: Absolute path to the Flutter project root.
        confirmed: Must be True — set only after explicit user approval.

    Returns:
        JSON with deletion results or rejection message.
    """
    if not confirmed:
        return json.dumps({
            "success": False,
            "message": "🚫 User confirmation required. Call scan_assets() first, "
                       "show the results, and only set confirmed=True after the user approves.",
        }, indent=2)

    verification_raw = verify_flutter_project(project_path)
    verification = json.loads(verification_raw)

    if not verification.get("is_flutter"):
        return json.dumps({
            "success": False,
            "message": f"Aborted: {verification.get('message')}",
        }, indent=2)

    try:
        result = subprocess.run(
            ["dart", "pub", "global", "run", "cleanbev", "-a"],
            capture_output=True,
            text=True,
            cwd=project_path,
        )
        return json.dumps({
            "success": result.returncode == 0,
            "stdout": result.stdout.strip(),
            "stderr": result.stderr.strip(),
            "message": "✅ Done." if result.returncode == 0 else f"❌ Exited with code {result.returncode}.",
        }, indent=2)

    except FileNotFoundError:
        return json.dumps({
            "success": False,
            "message": "❌ 'dart' not found on PATH.",
        }, indent=2)

def main():
    mcp.run()

if __name__ == "__main__":
    mcp.run()