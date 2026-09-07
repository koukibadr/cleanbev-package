import 'dart:io';

extension FileExtensions on File {
  bool isImage() {
    final imageExtensions = ['.png', '.jpg', '.jpeg', '.gif', '.bmp', '.webp', '.svg'];
    return imageExtensions.any((ext) => path.toLowerCase().endsWith(ext));
  }
}
