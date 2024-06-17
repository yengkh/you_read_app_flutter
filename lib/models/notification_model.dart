class NotificationModel {
  final int? id;
  final String file;
  final String name;
  final String type;
  final String author;

  NotificationModel({
    this.id,
    required this.file,
    required this.name,
    required this.author,
    required this.type,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json["id"],
      file: json["file"],
      name: json["name"],
      author: json["author"],
      type: json["type"]
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "file": file,
        "name": name,
        "author" : author,
        "type" : type,
      };
}
