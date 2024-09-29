class CompletionModel {
  final String message;

  CompletionModel({
    required this.message,
  });

  factory CompletionModel.fromJson(String message) {
    return CompletionModel(message: message);
  }
}
