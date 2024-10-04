class EnvService {
  static const String OpenAI_Key =
      String.fromEnvironment("OPENAI_API", defaultValue: '');
  static const String BaseURL = "https://api.openai.com/v1";
}
