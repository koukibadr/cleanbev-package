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
