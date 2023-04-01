/// Creator : Azimjon Makhmudov
/// Date : 2/15/2023 Time : 01:46
/// Project : terabayt_uz
/// Package : lib/data/source/remote/response

import 'dart:convert';

List<Categories> categoryFromJson(String str) => List<Categories>.from(json.decode(str).map((x) => Categories.fromJson(x)));

String categoryToJson(List<Categories> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categories {
  Categories({
    required this.id,
    required this.name,
    required this.slug,
    this.child,
  });

  final int id;
  final String name;
  final String slug;
  final List<Categories>? child;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        child: json["child"] == null ? [] : List<Categories>.from(json["child"]!.map((x) => Categories.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "child": child == null ? [] : List<dynamic>.from(child!.map((x) => x.toJson())),
      };
}
