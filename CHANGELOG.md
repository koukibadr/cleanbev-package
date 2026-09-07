## 1.1.0

### Features

- Added `--version/-v` to display the current package version.
- Added `--output-format/-o` with text and JSON output options.
- Added formatted reporting for deleted and unused assets.
- Added support for excluding image files and image directories listed in .cleanbevignore from asset checks.
- Added support for recognizing additional image formats, including GIF, BMP, and WebP files.
- Added a message and early exit when no eligible images remain after filtering.

### Bug Fixes

- Improved messaging when the assets directory is unavailable.

## 1.0.3

### Features

- Implement MCP Layer to enable package support with LLM integration for enhanced asset analysis and management on VSCode, Cursor, GitHub Copilot, Claude Desktop, Warp.
- Added support for `--dry-run` flag to simulate asset deletion without actually removing files.
- Added flag `--accept-all` (`-a`) to allow users to delete all unused assets without confirmation prompts.
- Added flag `--help` (`-h`) to display usage information and available options.

## 1.0.2

### Bug Fixes

- Fixed package to executable mapping issue that caused "Executable not found" error when running `dart pub global run cleanbev` after global activation.

## 1.0.1 - File Filter Improvements

### Features

- Improved file filtering to focus on common image formats (png, jpg, jpeg, svg) when checking for unused assets

## 1.0.0 - Initial Release

### Features

- **Asset Detection**: Automatically scans and identifies all asset files in a specified directory
- **Usage Analysis**: Searches Dart source files to determine which assets are referenced in code
- **Interactive Deletion**: Prompts users for confirmation before deleting each unused asset
- **Custom Asset Path**: Support for `--assets-path` flag to specify custom asset directories
- **Clear Feedback**: Displays whether each asset was successfully deleted or kept

### Initial Release

- Functional command-line interface for detecting unused assets
- Integration with Dart projects using standard `pubspec.yaml` asset configuration
- Safe deletion workflow with user confirmation prompts
