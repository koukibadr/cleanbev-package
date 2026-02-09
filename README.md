# Cleanbev

A powerful command-line tool for Dart and Flutter projects that automatically detects unused assets and helps keep your project clean. Cleanbev scans your project for asset references, identifies unused files, and prompts you for confirmation before removing them.

## Features

- 🔍 **Automatic Asset Detection**: Scans your project to find all asset files and their usage
- ⚠️ **Unused Asset Identification**: Identifies assets that are defined but never referenced in code
- ✅ **Safe Deletion**: Asks for confirmation before removing any files
- 🚀 **Easy to Use**: Simple command-line interface with clear feedback
- 📊 **Detailed Reports**: Shows exactly which assets are unused and where used assets are referenced

## Installation

### As a Command-Line Tool

Add to your `pubspec.yaml` as a dev dependency:

```yaml
dev_dependencies:
  cleanbev: ^1.0.0
```

Then activate it globally:

```bash
dart pub global activate cleanbev
```

Or run it directly from your project:

```bash
dart pub global run cleanbev
```

## Usage

### Basic Usage

Run cleanbev in your project root:

```bash
cleanbev
```

By default, it scans the `assets/` directory defined in your project.

### Custom Asset Path

Specify a custom assets directory:

```bash
cleanbev --assets-path assets/images
```

The default assets directory is `assets`.

## How It Works

1. **Scanning**: Cleanbev reads your `pubspec.yaml` to find all declared assets
2. **Analysis**: It searches your Dart/Flutter code for references to each asset
3. **Reporting**: Displays a list of unused assets found
4. **Confirmation**: Asks for your approval before deleting any files
5. **Cleanup**: Removes only the assets you confirm

## Example Output

```
$ dart pub global run cleanbev --assets-path assets/images

Checking assets in dart files...

✓ Asset assets/images/logo_white_bg.png is not used in the project. Do you want to delete it? · no
Asset assets/images/logo_white_bg.png has not been deleted.

✓ Asset assets/images/download_image-car.jpeg is not used in the project. Do you want to delete it? · yes
Asset assets/images/download_image-car.jpeg has been deleted.

✓ Asset assets/images/home_banner_image.jpg is not used in the project. Do you want to delete it? · no
Asset assets/images/home_banner_image.jpg has not been deleted.

✓ Asset assets/images/onboarding_events.jpg is not used in the project. Do you want to delete it? · no
Asset assets/images/onboarding_events.jpg has not been deleted.
```

## Requirements

- Dart SDK >= 3.11.0

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
