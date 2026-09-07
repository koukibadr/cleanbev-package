import 'package:cleanbev/common/print_colors.dart';

void log(String message) {
  print(message);
}

void logError(String message) {
  print('${PrintColors.red}Error: $message${PrintColors.reset}');
}

void logWarning(String message) {
  print('${PrintColors.yellow}Warning: $message${PrintColors.reset}');
}

void logSuccess(String message) {
  print('${PrintColors.green}$message${PrintColors.reset}');
}
