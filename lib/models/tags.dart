class Tags {
  final int _id;
  final String _name;
  final int _price;
  final int _weight;
  final String _description;
  final String? _image_url;
  final List _tegs;

  int get id => _id;
  String get name => _name;
  int get price => _price;
  int get weight => _weight;
  String get description => _description;
  String? get image_url => _image_url;
  List get tegs => _tegs;


  Tags.fromJson(Map<String, dynamic> json) :
        _id = json["id"],
        _name = json["name"],
        _price = json["price"],
        _weight = json["weight"],
        _description = json["description"],
        _image_url = json["image_url"],
        _tegs = json["tegs"];
}


class TagsList {
  final List<Tags> tags = [];

  TagsList.fromJson(Map<String, dynamic> jsonItems) {
    for (final el in jsonItems.entries) {
      for (var jsonItem in el.value) {
        tags.add(Tags.fromJson(jsonItem));
      }
    }
  }
}

abstract class TagsResult {}

class TagsResultSuccess extends TagsResult {
  final TagsList tagsList;
  TagsResultSuccess(this.tagsList);
}

class TagsResultFailure extends TagsResult {
  final String error;
  TagsResultFailure(this.error);
}


class TagsResultLoading extends TagsResult {
  TagsResultLoading();
}
