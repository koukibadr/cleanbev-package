import 'package:cleanbev/cleanbev.dart';

const String version = '0.0.1';

void main(List<String> arguments) {
  final CleanbevArgResults config = CleanbevArgTransform().parse(arguments);
  final AssetsListParser parser = AssetsListParser(
    assetsPath: config.assetsPath,
  );
  parser.parse();
}
