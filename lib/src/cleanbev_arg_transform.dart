import 'package:args/args.dart';

class CleanbevArgResults {
  final String assetsPath;

  CleanbevArgResults({required this.assetsPath});
}

/// Transforms command-line arguments into a [CleanbevArgResults] instance.
class CleanbevArgTransform {
  static const _assetPathKey = 'assets-path';

  final _parser = ArgParser()
    ..addOption(
      _assetPathKey,
      help: 'The path to the assets directory.',
      mandatory: false,
      defaultsTo: 'assets',
    );

  CleanbevArgResults parse(List<String> args) {
    final rawResults = _parser.parse(args);
    if (rawResults[_assetPathKey] == null) {
      throw FormatException('The --assets-path option is required.');
    }
    return CleanbevArgResults(assetsPath: rawResults[_assetPathKey] as String);
  }
}
