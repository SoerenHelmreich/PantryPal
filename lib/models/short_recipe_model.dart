class ShortRecipeModel {
  final String title;
  final String description;
  final String duration;

  ShortRecipeModel({
    required this.title,
    required this.description,
    required this.duration,
  });

  factory ShortRecipeModel.fromJson(Map<String, dynamic> json) {
    return ShortRecipeModel(
      title: json['title'],
      description: json['description'],
      duration: json['duration'],
    );
  }
}
