import 'package:flutter/material.dart';

import '../constants/text_constants.dart';
import '../models/model_from_quik.dart';
import '../services/fetch_service.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

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
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: const Text(Apptext.topNewsAppBarTitle),
      ),
      body: topNews == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: topNews!.articles.length,
              itemBuilder: (context, index) {
                final news = topNews!.articles[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Image.network(
                            news.urlToImage,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          flex: 5,
                          child: Text(
                            news.title,
                            style: AppTextStyle.newsTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
