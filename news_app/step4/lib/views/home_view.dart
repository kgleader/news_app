import 'package:flutter/material.dart';
import 'package:step4/components/news_card.dart';
import 'package:step4/constants/country_code.dart';
import 'package:step4/constants/text_constants.dart';
import 'package:step4/models/top_news.dart';
import 'package:step4/services/fetch_service.dart';
import 'package:step4/theme/colors.dart';
import 'package:step4/views/search_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TopNews? topNews;

  Future<void> fetchNews([String? domain]) async {
    topNews = null;
    setState(() {});
    topNews = await NewsRepo().fetchTopNews(domain);
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
        backgroundColor: AppColor.primary,
        title: const Text(AppText.topNewsAppBarTitle),
        actions: [
          PopupMenuButton<Country>(
            onSelected: (Country item) async {
              await fetchNews(item.domain);
            },
            itemBuilder: (BuildContext context) {
              return countriesSet
                  .map(
                    (e) => PopupMenuItem<Country>(
                      value: e,
                      child: Text(e.name),
                    ),
                  )
                  .toList();
            },
          ),
        ],
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primary,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => const SearchView()),
            ),
          );
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
