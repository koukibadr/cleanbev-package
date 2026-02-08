import 'package:args/args.dart';

class CleanbevArgResults {
  final String assetsPath;

  CleanbevArgResults({required this.assetsPath});
}

class CleanbevArgTransform {
  static const _assetPathKey = 'assetsPath';

  final _parser = ArgParser()
    ..addOption(
      _assetPathKey,
      help: 'The path to the assets directory.',
      mandatory: true,
    );

  CleanbevArgResults parse(List<String> args) {
    final rawResults = _parser.parse(args);
    if(rawResults[_assetPathKey] == null) {
      throw FormatException('The --assetsPath option is required.');
    }
    return CleanbevArgResults(assetsPath: rawResults[_assetPathKey] as String);
  }
}
