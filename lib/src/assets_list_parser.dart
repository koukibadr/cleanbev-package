import 'dart:io';

import 'package:file/local.dart';

class AssetsListParser {
  final String assetsPath;
  AssetsListParser({required this.assetsPath});

  final fileSystem = LocalFileSystem();

  /// Parses the assets directory and checks if the assets are used in the project.
  /// Throws an exception if the assets directory is not found or if any asset is not found.
  void parse() {
    final assetList = fileSystem
        .directory(assetsPath)
        .listSync(recursive: true);
    final assetFiles = assetList.whereType<File>().toList();
    checkAssetsPath(assetFiles);
  }

  /// Checks if the assets are used in the project. Prints a warning if an asset is not used.
  /// Throws an exception if any asset is not found.
  /// This method uses the `grep` command to search for the asset path in the project files. It is case-insensitive.
  void checkAssetsPath(List<File> assetList) async {
    final listOfFiles = fileSystem.directory('lib').listSync(recursive: true);
    for (final asset in assetList) {
      if (!asset.existsSync()) {
        throw Exception('Asset not found: ${asset.path}');
      }
      bool isUsed = false;
      for (var file in listOfFiles) {
        var result = await Process.run('grep', ['-i', asset.path, file.path]);
        if (result.exitCode == 0) {
          isUsed = true;
          break;
        }
      }
      if (!isUsed) {
        print('Asset ${asset.path} is not used in the project.');
      }
    }
  }
}
