import os
import re
import subprocess
import json
from pathlib import Path
from typing import Any
 
import yaml
from mcp.server.fastmcp import FastMCP
 

mcp = FastMCP("cleanbev")
 
 
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
 
 
if __name__ == "__main__":
    mcp.run()