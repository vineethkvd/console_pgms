import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;

import '../model/news_model.dart';

class NewsController extends GetxController {
  var isLoading = true.obs;
  var error = ''.obs;
  final String apiKey = '6842c385dc5e467eac91d810f147b54a';
  Future<NewsModel?> fetchNews() async {
    final String url =
        'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=$apiKey';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Handle the successful response, e.g., parse the JSON data
        print('Response: ${response.body}');
        final data = json.decode(response.body);
        return NewsModel.fromJson(data);
      } else {
        // Handle errors, e.g., show an error message.
        print('Error: ${response.reasonPhrase}');
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
