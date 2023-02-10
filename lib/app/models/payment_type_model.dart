import 'dart:convert';

class PaymentTypeModel {
  factory PaymentTypeModel.fromJson(String source) =>
      PaymentTypeModel.fromMap(json.decode(source));

  factory PaymentTypeModel.fromMap(Map<String, dynamic> map) =>
      PaymentTypeModel(
        id: map['id']?.toInt() ?? 0,
        name: map['name'] ?? '',
        acronym: map['acronym'] ?? '',
        enabled: map['enabled'] ?? false,
      );

  const PaymentTypeModel({
    required this.id,
    required this.name,
    required this.acronym,
    required this.enabled,
  });

  final int id;
  final String name;
  final String acronym;
  final bool enabled;

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'acronym': acronym,
        'enabled': enabled,
      };

  String toJson() => json.encode(toMap());
}
