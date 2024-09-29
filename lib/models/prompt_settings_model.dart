class PromptSettingsModel {
  final String systemPrompt;
  final String userPrompt;
  final Object returnFormat;

  PromptSettingsModel({
    required this.systemPrompt,
    required this.userPrompt,
    required this.returnFormat,
  });
}
