import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/colors.dart';
import '../theme/text_styles.dart';

class DetailDateTime extends StatelessWidget {
  const DetailDateTime({super.key, required this.article});

  final String article;

  @override
  Widget build(BuildContext context) {
    final time = DateFormat("d MMM, y. H:m").format(DateTime.parse(article));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.access_time,
          color: AppColor.grey,
          size: 30,
        ),
        Text(
          time,
          style: AppTextStyle.dateTime,
        )
      ],
    );
  }
}