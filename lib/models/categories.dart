
class Categories {

  final int _id;
  final String _name;
  final String _image_url;

  int get id => _id;
  String get name => _name;
  String get image_url => _image_url;

  Categories.fromJson(Map<String, dynamic> json) :
        _id = json["id"],
        _name = json["name"],
        _image_url = json["image_url"];
}

// CategoryList являются оберткой для массива постов
class CategoryList {
  final List<Categories> categories = [];
  CategoryList.fromJson(Map<String, dynamic> jsonItems) {
    for (final el in jsonItems.entries) {
      for (var jsonItem in el.value) {
        categories.add(Categories.fromJson(jsonItem));
      }
    }
  }
}

abstract class CategoryResult {}

class CategoryResultSuccess extends CategoryResult {
  final CategoryList categoryList;
  CategoryResultSuccess(this.categoryList);
}

class CategoryResultFailure extends CategoryResult {
  final String error;
  CategoryResultFailure(this.error);
}

class CategoryResultLoading extends CategoryResult {
  CategoryResultLoading();
}