import 'dart:io';

import 'package:file/local.dart';

class AssetsListParser {
  final String assetsPath;
  AssetsListParser({required this.assetsPath});

  final fileSystem = LocalFileSystem();

  void parse() {
    final assetList = fileSystem
        .directory(assetsPath)
        .listSync(recursive: true);
    final assetFiles = assetList.whereType<File>().toList();
    checkAssetsPath(assetFiles);
  }

  void checkAssetsPath(List<File> assetList) async {
    final listOfFiles = fileSystem.directory('lib').listSync(recursive: true);
    for (final asset in assetList) {
      if (!asset.existsSync()) {
        throw Exception('Asset not found: ${asset.path}');
      }
      listOfFiles.forEach((file) async {
        var result = await Process.run('grep', ['-i', asset.path, file.path]);
        stdout.write(result.stdout);
      });
    }
  }
}
