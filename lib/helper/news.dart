import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_news_app/models/article_model.dart';

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=id&apiKey=e2814615845c45d3801188611be1072e';

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((article) {
        if (article['urlToImage'] != null && article['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            author: article['title'],
            title: article['title'],
            description: article['description'],
            url: article['url'],
            urlToImage: article['urlToImage'],
            content: article['content'],
          );
          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNews {
  List<ArticleModel> news = [];

  Future<void> getNews(String category) async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=id&category=$category&apiKey=e2814615845c45d3801188611be1072e';

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((article) {
        if (article['urlToImage'] != null && article['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            author: article['title'],
            title: article['title'],
            description: article['description'],
            url: article['url'],
            urlToImage: article['urlToImage'],
            content: article['content'],
          );
          news.add(articleModel);
        }
      });
    }
  }
}
