// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Store {
  int id;
  String store;
  Store({
    required this.id,
    required this.store,
  });

  Store copyWith({
    int? id,
    String? store,
  }) {
    return Store(
      id: id ?? this.id,
      store: store ?? this.store,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'body': store,
    };
  }

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
      id: map['id'] as int,
      store: map['body'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Store.fromJson(String source) =>
      Store.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Store(id: $id, store: $store)';

  @override
  bool operator ==(covariant Store other) {
    if (identical(this, other)) return true;

    return other.id == id && other.store == store;
  }

  @override
  int get hashCode => id.hashCode ^ store.hashCode;
}
