class Categories {
  String message;
  bool status;
  List<Category> data;

  Categories({
    required this.message,
    required this.status,
    required this.data,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        message: json["message"],
        status: json["status"],
        data: List<Category>.from(json["data"].map((x) => Category.fromJson(x))),
      );

}

class Category {
  String id;
  String categoryName;
  String? image;
  String? color;

  Category({
    required this.id,
    required this.categoryName,
    this.image,
    this.color,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        categoryName: json["category_name"],
        image: json["image"],
        color: json["color"],
      );

}
