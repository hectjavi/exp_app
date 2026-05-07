import 'package:flutter_application_1/core/environment/env.dart';
import 'package:flutter_application_1/main.dart';

void main (List<String> args) {
  Env.environment = Environment.development;
  runProject();
}