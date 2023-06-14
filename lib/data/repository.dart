import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_example/models/categories.dart';
import 'package:test_example/models/tags.dart';


const String SERVER = "https://run.mocky.io/v3";
const List addresses = [
  "/058729bd-1402-4578-88de-265481fd7d54",
  "/c7a508f2-a904-498a-8539-09d96785446e"
];


class Repository_Categories {
  Future fetchCategory() async {
    final url = Uri.parse("$SERVER${addresses[0]}");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return CategoryList.fromJson(json.decode(response.body));
    } else {
      throw Exception("failed request");
    }
  }
}

class Repository_Tags {
  Future fetchTag() async {
    final url = Uri.parse("$SERVER${addresses[1]}");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return TagsList.fromJson(json.decode(response.body));
    } else {
      throw Exception("failed request");
    }
  }
}