import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(allowOptionalFields: true)
abstract class Env {
  @EnviedField(varName: 'OPENAI_KEY', obfuscate: true)
  // ignore: constant_identifier_names
  static final String OPENAI_KEY = _Env.OPENAI_KEY;

  @EnviedField(varName: 'BASEURL', obfuscate: true)
  // ignore: constant_identifier_names
  static final String BASEURL = _Env.BASEURL;
}
