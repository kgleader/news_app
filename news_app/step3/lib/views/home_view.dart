import 'package:flutter/material.dart';
import 'package:step3/components/news_card.dart';
import 'package:step3/constants/text_constants.dart';
import 'package:step3/models/top_news.dart';
import 'package:step3/services/fetch_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TopNews? topNews;

  Future<void> fetchNews() async {
    topNews = await TopNewsRepo().fetchTopNews();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 33, 51, 255),
        title: const Text(AppText.topNewsAppBarTitle),
      ),
      body: topNews == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: topNews!.articles.length,
              itemBuilder: (context, index) {
                final news = topNews!.articles[index];
                return NewsCard(news: news);
              },
            ),
    );
  }
}
