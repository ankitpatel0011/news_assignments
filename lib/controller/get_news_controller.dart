import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/data_model.dart';

class GetNewsContent extends GetxController {
  RxList<Article> listOfNewsVariable = <Article>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    apiRequest();
    super.onInit();
  }

  Future<void> apiRequest() async {
    var response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=e1ab1b2e6a9d4aa296d994582349ba93"));
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      List<dynamic> listOfNews = decodedData["articles"];
      listOfNewsVariable
          .addAll(listOfNews.map((e) => Article.fromJson(e)).toList());
    }
    isLoading.value = false;
  }
}
