import 'package:flutter/material.dart';
import 'package:step4/constants/text_constants.dart';
import 'package:step4/theme/colors.dart';

class ReadMoreButton extends StatelessWidget {
  const ReadMoreButton({super.key, this.onPressed});
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: AppColor.primary),
      child: const Text(AppText.readMore),
    );
  }
}
