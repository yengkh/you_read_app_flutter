class CaroModel {
  final String id;
  final String image;

  CaroModel({
    required this.id,
    required this.image,
  });

  factory CaroModel.fromJson(Map<String, dynamic> json) {
    return CaroModel(
      id: json["id"],
      image: json["image"],
    );
  }
}