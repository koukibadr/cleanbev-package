import 'package:cleanbev/cleanbev.dart';

void main(List<String> arguments) {
  final CleanbevArgResults config = CleanbevArgTransform().parse(arguments);
  final AssetsListParser parser = AssetsListParser(
    assetsPath: config.assetsPath,
  );
  parser.parse();
}
