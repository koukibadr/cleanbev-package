import 'dart:convert';
import 'dart:io';

import 'package:cleanbev/common/print_logger.dart';

class OutputFormatter {
  final String format;

  OutputFormatter(this.format);

  void formatOutput(List<File> deletedAssets) {
    switch (format) {
      case 'json':
        logSuccess(jsonEncode(formatOutputAsMap(deletedAssets)));
        break;
      case 'text':
      default:
        logSuccess(formatOutputAsText(deletedAssets));
    }
  }

  Map<String, dynamic> formatOutputAsMap(List<File> deletedAssets) {
    return {
      'deleted_assets': deletedAssets.map((file) => {
        "name": file.path.split('/').last,
        "path": file.path,
        "type": file.path.split('.').last,
      }).toList(),
      'total_deleted': deletedAssets.length,
    };
  }

  String formatOutputAsText(List<File> deletedAssets) {
    final buffer = StringBuffer();
    buffer.writeln('Deleted Assets:');
    for (var file in deletedAssets) {
      buffer.writeln('- ${file.path}');
    }
    buffer.writeln('Total Deleted: ${deletedAssets.length}');
    return buffer.toString();
  }
}
