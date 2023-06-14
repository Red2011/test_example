import 'package:test_example/models/tags.dart';
import '../data/repository.dart';
import '../models/categories.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class categoryController extends ControllerMVC {
  final Repository_Categories repo = Repository_Categories();
  categoryController();
  CategoryResult currentState = CategoryResultLoading();

  void init() async {
    try {
      final postList = await repo.fetchCategory();
      setState(() => currentState = CategoryResultSuccess(postList));
    } catch (error) {
      setState(() => currentState = CategoryResultFailure("No internet"));
    }
  }
}

class tagController extends ControllerMVC {
  final Repository_Tags repo = Repository_Tags();
  tagController();
  TagsResult currentState = TagsResultLoading();

  void init() async {
    try {
      final tagsList = await repo.fetchTag();
      setState(() => currentState = TagsResultSuccess(tagsList));
    } catch (error) {
      setState(() => currentState = TagsResultFailure("No internet"));
    }
  }
}