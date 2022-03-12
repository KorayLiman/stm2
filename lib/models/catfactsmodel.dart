import 'dart:convert';

class CatFactsModel {
  final String fact;
  final int length;
  CatFactsModel({
    required this.fact,
    required this.length,
  });

  CatFactsModel copyWith({
    String? fact,
    int? length,
  }) {
    return CatFactsModel(
      fact: fact ?? this.fact,
      length: length ?? this.length,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fact': fact,
      'length': length,
    };
  }

  factory CatFactsModel.fromMap(Map<String, dynamic> map) {
    return CatFactsModel(
      fact: map['fact'] ?? '',
      length: map['length']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CatFactsModel.fromJson(String source) => CatFactsModel.fromMap(json.decode(source));

  @override
  String toString() => 'CatFactsModel(fact: $fact, length: $length)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CatFactsModel &&
      other.fact == fact &&
      other.length == length;
  }

  @override
  int get hashCode => fact.hashCode ^ length.hashCode;
}
