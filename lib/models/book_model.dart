class BookModel {
  final String name;
  final String author;
  final String type;
  final String desc;
  final String file;
  final String image;
  final String downloaded;
  final String id;

  BookModel({
    required this.name,
    required this.author,
    required this.type,
    required this.desc,
    required this.file,
    required this.image,
    required this.downloaded,
    required this.id,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      name: json["name"],
      author: json["author"],
      type: json["type"],
      desc: json["desc"],
      file: json["file"],
      image: json["image"],
      downloaded: json["downloaded"],
      id: json["id"],
    );
  }
}
