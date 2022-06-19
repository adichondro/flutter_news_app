import 'package:flutter/material.dart';
import 'package:flutter_news_app/helper/news.dart';
import 'package:flutter_news_app/models/article_model.dart';
import 'package:flutter_news_app/widgets/blog_tile.dart';

class CategoryNewsView extends StatefulWidget {
  final String category;
  const CategoryNewsView({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryNewsView> createState() => _CategoryNewsViewState();
}

class _CategoryNewsViewState extends State<CategoryNewsView> {
  List<ArticleModel> articles = <ArticleModel>[];

  bool _loading = true;
  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNews newsClass = CategoryNews();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('News'),
              Text(
                'App',
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
          actions: const [
            Opacity(
              opacity: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.arrow_right),
              ),
            )
          ],
          elevation: 0.0,
        ),
        body: _loading
            ? const Center(
                child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ))
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                margin: const EdgeInsets.only(top: 16),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return BlogTile(
                      title: articles[index].title!,
                      imageUrl: articles[index].urlToImage!,
                      description: articles[index].description!,
                      url: articles[index].url!,
                    );
                  },
                  itemCount: articles.length,
                ),
              ));
  }
}
