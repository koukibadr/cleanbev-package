import 'package:cleanbev/cleanbev.dart';
import 'package:cleanbev/common/constants.dart';

Future<void> main(List<String> arguments) async {
  final CleanbevArgResults config = CleanbevArgTransform().parse(arguments);
  if (config.showHelp) {
    print(CleanbevArgTransform().usage);
    return;
  } else if (config.showVersion) {
    print('cleanbev: $version');
    return;
  }
  final AssetsListParser parser = AssetsListParser(
    config: config,
  );
  parser.parse();
}
