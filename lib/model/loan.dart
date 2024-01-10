// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoanModel {
  final int id;
  final String name;
  LoanModel({
    required this.id,
    required this.name,
  });

  LoanModel copyWith({
    int? id,
    String? name,
  }) {
    return LoanModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory LoanModel.fromMap(Map<String, dynamic> map) {
    return LoanModel(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoanModel.fromJson(String source) =>
      LoanModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LoanModel(id: $id, name: $name)';

  @override
  bool operator ==(covariant LoanModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
