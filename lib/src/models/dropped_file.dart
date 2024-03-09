class DroppedFile {
  final String url;
  final String photoName;
  final String mime;
  final int bytes;

  const DroppedFile({
    required this.url,
    required this.photoName,
    required this.mime,
    required this.bytes,
  });

  // Show file size in KB or MB
  String get size {
    final kb = bytes / 1024;
    final mb = kb / 1024;

    return mb > 1
      ? '${mb.toStringAsFixed(2)} MB'
      : '${kb.toStringAsFixed(2)} KB';
  }
}