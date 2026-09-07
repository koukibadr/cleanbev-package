import 'package:args/args.dart';

class CleanbevArgResults {
  final String assetsPath;
  final bool acceptAll;
  final bool dryRun;
  final bool showHelp;
  final bool showVersion;
  final String outputFormat;

  CleanbevArgResults({
    required this.assetsPath,
    required this.acceptAll,
    required this.dryRun,
    required this.showHelp,
    required this.showVersion,
    required this.outputFormat,
  });
}

/// Transforms command-line arguments into a [CleanbevArgResults] instance.
class CleanbevArgTransform {
  static const _assetPathKey = 'assets-path';

  static const _acceptAllKey = 'accept-all';

  static const _helpKey = 'help';

  static const _dryRunKey = 'dry-run';

  static const _outputFormatKey = 'output-format';

  static const _versionKey = 'version';



  final _parser = ArgParser()
    ..addFlag(
      _helpKey,
      abbr: 'h',
      help: 'Print this usage information.',
      negatable: false,
    )
    ..addFlag(
      _versionKey,
      abbr: 'v',
      help: 'Print the version information.',
      negatable: false,
    )
    ..addFlag(
      _acceptAllKey,
      abbr: 'a',
      help:
          'Accept all assets without confirmation, including those that are not used in the project. Use with caution.',
      defaultsTo: false,
    )
    ..addFlag(
      _dryRunKey,
      help:
          'Perform a dry run without making any changes to the file system and print the assets that would be deleted.',
      defaultsTo: false,
    )
    ..addOption(
      _assetPathKey,
      help:
          'The path to the assets directory. Defaults to "assets". If the directory does not exist, an exception will be thrown.',
      mandatory: false,
      defaultsTo: 'assets',
    )
    ..addOption(
      _outputFormatKey,
      abbr: 'o',
      help:
          'Specify the output format for the results. Can be used multiple times to specify multiple formats. Supported formats: json, yaml, text. Defaults to text.',
      allowed: ['json', 'text'],
      defaultsTo: 'text',
    );
    

  String get usage => _parser.usage;

  CleanbevArgResults parse(List<String> args) {
    final rawResults = _parser.parse(args);
    // Check help flag first before validating other arguments
    if (rawResults[_helpKey] as bool) {
      return CleanbevArgResults(
        assetsPath: '',
        acceptAll: false,
        dryRun: false,
        showHelp: true,
        outputFormat: 'text',
        showVersion: false
      );
    } else if (rawResults[_versionKey] as bool) {
      return CleanbevArgResults(
        assetsPath: '',
        acceptAll: false,
        dryRun: false,
        showHelp: false,
        outputFormat: 'text',
        showVersion: true
      );
    }
    if (rawResults[_assetPathKey] == null) {
      throw FormatException('The --assets-path argument is required.');
    }
    return CleanbevArgResults(
      assetsPath: rawResults[_assetPathKey] as String,
      acceptAll: rawResults[_acceptAllKey] as bool,
      dryRun: rawResults[_dryRunKey] as bool,
      showHelp: false,
      outputFormat: rawResults[_outputFormatKey] as String,
      showVersion: false
    );
  }
}
