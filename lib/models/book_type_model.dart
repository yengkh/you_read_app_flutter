class BookTypeModel {
  final String name;
  final String image;

  BookTypeModel({required this.name, required this.image});

  factory BookTypeModel.fronJson(Map<String, dynamic> json) {
    return BookTypeModel(
      name: json["name"],
      image: json["image"],
    );
  }
}
