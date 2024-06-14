class PhoneNumberModel {
  final int id;
  final int phone;

  PhoneNumberModel({
    required this.id,
    required this.phone,
  });

  factory PhoneNumberModel.fromJson(Map<String, dynamic> json) {
    return PhoneNumberModel(
      id: json["id"],
      phone: json["phone"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
      };
}
