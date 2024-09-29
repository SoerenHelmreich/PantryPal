class ModelsModel {
  ModelsModel({
    required this.id,
    required this.root,
    required this.created,
  });

  final String id;
  final int created;
  final String root;

  factory ModelsModel.fromJson(Map<String, dynamic> json) =>
      ModelsModel(id: json['id'], root: json['root'], created: json['created']);

  static List<ModelsModel> modelsFromSnapshot(List modelSnapshot) {
    return modelSnapshot.map((data) => ModelsModel.fromJson(data)).toList();
  }
}
