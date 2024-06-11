
import 'dart:typed_data';

class DownloadModel {
  final int? id;
  final String name;
  final String author;
  final String type;
  final String file;
  final Uint8List image;

  DownloadModel({
    this.id,
    required this.name,
    required this.author,
    required this.type,
    required this.file,
    required this.image,
  });

  factory DownloadModel.fromJson(Map<String, dynamic> json) {
    return DownloadModel(
      id: json["id"],
      name: json["name"],
      author: json["author"],
      type: json["type"],
      file: json["file"],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "author": author,
        "type": type,
        "file": file,
        "image": image,
      };
}
