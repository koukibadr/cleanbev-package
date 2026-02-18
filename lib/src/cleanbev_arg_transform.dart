import 'package:args/args.dart';

class CleanbevArgResults {
  final String assetsPath;
  final bool acceptAll;
  final bool showHelp;

  CleanbevArgResults({
    required this.assetsPath,
    required this.acceptAll,
    required this.showHelp,
  });
}

/// Transforms command-line arguments into a [CleanbevArgResults] instance.
class CleanbevArgTransform {
  static const _assetPathKey = 'assets-path';

  static const _acceptAllKey = 'accept-all';

  static const _helpKey = 'help';

  final _parser = ArgParser()
    ..addFlag(
      _helpKey,
      abbr: 'h',
      help: 'Print this usage information.',
      negatable: false,
    )
    ..addFlag(
      _acceptAllKey,
      abbr: 'a',
      help:
          'Accept all assets without confirmation, including those that are not used in the project. Use with caution.',
      defaultsTo: false,
    )
    ..addOption(
      _assetPathKey,
      help:
          'The path to the assets directory. Defaults to "assets". If the directory does not exist, an exception will be thrown.',
      mandatory: false,
      defaultsTo: 'assets',
    );

  String get usage => _parser.usage;

  CleanbevArgResults parse(List<String> args) {
    final rawResults = _parser.parse(args);
    // Check help flag first before validating other arguments
    if (rawResults[_helpKey] as bool) {
      return CleanbevArgResults(
        assetsPath: '',
        acceptAll: false,
        showHelp: true,
      );
    }
    if (rawResults[_assetPathKey] == null) {
      throw FormatException('The --assets-path argument is required.');
    }
    return CleanbevArgResults(
      assetsPath: rawResults[_assetPathKey] as String,
      acceptAll: rawResults[_acceptAllKey] as bool,
      showHelp: false,
    );
  }
}
