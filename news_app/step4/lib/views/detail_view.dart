import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/detail_date_time.dart';
import '../components/detail_divider.dart';
import '../components/detaile_title.dart';
import '../components/read_more_button.dart';
import '../constants/api_constants.dart';
import '../models/article.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

class NewsDetailView extends StatelessWidget {
  const NewsDetailView({super.key, required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text(
          article.title,
          overflow: TextOverflow.fade,
        ),
        actions: article.url != null
            ? [
                IconButton(
                  onPressed: () {
                    Share.share(article.url!);
                  },
                  icon: const Icon(Icons.share),
                )
              ]
            : null,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(13, 17, 13, 20),
        children: [
          DetailTitle(title: article.title),
          const DetailDivider(),
          DetailDateTime(article: article.publishedAt),
          const SizedBox(height: 10),
          CachedNetworkImage(
            imageUrl: article.urlToImage ?? ApiConst.defaultImage,
            placeholder: (context, url) =>
                Image.asset('assets/news_loading.webp'),
            errorWidget: (context, url, e) =>
                Image.asset('assets/news_error.jpeg'),
            fit: BoxFit.fitWidth,
          ),
          const SizedBox(height: 10),
          Text(article.description ?? '',
              style: AppTextStyle.detailDescription),
          const SizedBox(height: 20),
          article.url != null
              ? ReadMoreButton(
                  onPressed: () async {
                    final uri = Uri.parse(article.url!);

                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    }
                  },
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
