import 'package:cleanbev/cleanbev.dart';

void main(List<String> arguments) {
  final CleanbevArgResults config = CleanbevArgTransform().parse(arguments);
  if (config.showHelp) {
    print(CleanbevArgTransform().usage);
    return;
  }
  final AssetsListParser parser = AssetsListParser(
    config: config,
  );
  parser.parse();
}
