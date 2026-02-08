import 'dart:io';

import 'package:file/local.dart';

class AssetsListParser {
  final String assetsPath;
  const AssetsListParser({required this.assetsPath});

  List<String> parse() {
    final fileSystem = LocalFileSystem();
    fileSystem.directory(assetsPath).listSync(recursive: true).forEach((file) {
      if (file is! File) return;
      final relativePath = file.path.replaceFirst(assetsPath, '');
      print(relativePath);
    });
    return [];
  }
}
