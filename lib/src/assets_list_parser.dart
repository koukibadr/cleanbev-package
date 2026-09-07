import 'dart:io';

import 'package:cleanbev/cleanbev.dart';
import 'package:cleanbev/common/extensions.dart';
import 'package:cleanbev/common/print_logger.dart';
import 'package:cleanbev/src/output_formatter.dart';
import 'package:file/local.dart';
import 'package:interact_cli/interact_cli.dart';

class AssetsListParser {

  final CleanbevArgResults config;

  AssetsListParser({required this.config});

  final fileSystem = LocalFileSystem();

  /// Parses the assets directory and checks if the assets are used in the project.
  /// Throws an exception if the assets directory is not found or if any asset is not found.
  Future<void> parse() async {
    final assetDirectory = fileSystem.directory(config.assetsPath);
    if (!assetDirectory.existsSync()) {
      logError('Assets directory not found: ${config.assetsPath}');
      exit(1);
    }

    final assetList =
        fileSystem.directory(config.assetsPath).listSync(recursive: true);
    final assetFiles = assetList.whereType<File>().toList();
    final imageList = assetFiles.where((file) => file.isImage()).toList();

    final ignoreList = await parseCleanbevIgnore();
    final filteredImageList = imageList
        .where((file) => !ignoreList.any((ignoreFile) {
              if (ignoreFile.isImage()) {
                return file.path == ignoreFile.path;
              } else {
                return file.absolute.path
                    .substring(0, file.absolute.path.lastIndexOf('/') + 1)
                    .contains("${ignoreFile.path}/");
              }
            }))
        .toList();

    if (filteredImageList.isEmpty) {
      logSuccess('No assets found in the directory ${config.assetsPath}.');
      return;
    }

    await checkAssetsPath(filteredImageList);
  }

  Future<List<File>> parseCleanbevIgnore() async {
    final ignoreFile = fileSystem.file('.cleanbevignore');
    if (!ignoreFile.existsSync()) {
      return [];
    }

    final ignoreList = ignoreFile.readAsLinesSync();
    List<File> ignoreListResult = [];
    for (final path in ignoreList) {
      if (path.trim().isEmpty || path.trim().startsWith('#')) {
        continue;
      }
      log('  $path');
      if (path.startsWith('/')) {
        ignoreListResult.add(File(path.substring(1)));
      } else if (path.endsWith('/')) {
        ignoreListResult.add(File(path.substring(0, path.length - 1)));
      } else {
        ignoreListResult.add(File(path));
      }
    }
    return ignoreListResult;
  }

  /// Checks if the assets are used in the project. Prints a warning if an asset is not used.
  /// Throws an exception if any asset is not found.
  /// This method uses the `grep` command to search for the asset path in the project files. It is case-insensitive.
  Future<void> checkAssetsPath(List<File> assetList) async {
    final genFile = checkOnGenDirectory();

    final List<File> unusedAssets = [];
    OutputFormatter outputFormatter = OutputFormatter(config.outputFormat);

    for (final asset in assetList) {
      if (!asset.existsSync()) {
        throw Exception('Asset not found: ${asset.path}');
      }
      bool isUsed = checkAssetUsageInLib(asset.path);
      if (!isUsed) {
        if (genFile.existsSync()) {
          final assetName = getAssetNameInGen(asset);
          isUsed = checkAssetUsageInLib(assetName);
          if (!isUsed) {
            final deleted = promptDeletionConfirmation(asset);
            if (deleted) {
              unusedAssets.add(asset);
            }
          }
        } else {
          final deleted = promptDeletionConfirmation(asset);
          if (deleted) {
            unusedAssets.add(asset);
          }
        }
      }
    }
    outputFormatter.formatOutput(unusedAssets);
  }

  /// Checks if the asset is used in the lib directory.
  /// Returns true if the asset is used, false otherwise.
  /// Skips the generated files (.gen.dart).
  bool checkAssetUsageInLib(String assetName) {
    final listOfFiles = fileSystem.directory('lib').listSync(recursive: true);
    for (var file in listOfFiles) {
      if (file.path.endsWith('.gen.dart')) {
        continue;
      }
      var result = Process.runSync('grep', ['-i', assetName, file.path]);
      if (result.stdout.toString().isNotEmpty) {
        return true;
      }
    }
    return false;
  }

  File checkOnGenDirectory() {
    return fileSystem.file('lib/gen/assets.gen.dart');
  }

  /// Transforms asset file name to the format used in the generated file.
  String getAssetNameInGen(File asset) {
    final assetName = asset.path.split('/').last.split('.').first;
    final assetNameParts = assetName.split('_');
    final upperCaseParts = assetNameParts
        .skip(1)
        .map((part) => part[0].toUpperCase() + part.substring(1))
        .toList()
        .join("");
    final assetGenName = assetNameParts.first + upperCaseParts;
    final name = transformAssetName(assetGenName);
    return name;
  }

  /// Transforms asset name by converting hyphenated parts to camel case.
  String transformAssetName(String assetName) {
    final assetNameParts = assetName.split('-');
    final upperCaseParts = assetNameParts
        .skip(1)
        .map((part) => part[0].toUpperCase() + part.substring(1))
        .toList()
        .join("");
    final assetGenName = assetNameParts.first + upperCaseParts;
    return assetGenName;
  }

  bool promptDeletionConfirmation(File asset) {
    if (config.dryRun) {
      return true;
    }
    if (config.acceptAll) {
      asset.deleteSync();
      return true;
    }
    final answer = Confirm(
      prompt:
          'Asset ${asset.path} is not used in the project. Do you want to delete it?',
      defaultValue: false,
    ).interact();
    if (answer) {
      asset.deleteSync();
      return true;
    } else {
      return false;
    }
  }
}
