// lib/env/env.dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'OPENAIAPIKEY')
  static String OpenAIKey = _Env.OpenAIKey;

  @EnviedField(varName: 'BASEURL')
  static String BaseURL = _Env.BaseURL;
}

class EnvService {
  static const String OpenAI_Key =
      String.fromEnvironment("OPENAI_API", defaultValue: '');
}