import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_enes_ozmen/constants.dart';

class ScreensAppBarr extends StatelessWidget implements PreferredSizeWidget {
  const ScreensAppBarr({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_sharp),
        onPressed: () => Get.back(),
      ),
      title: Text(title),
      centerTitle: true,
      foregroundColor: kMaastrichtBlue,
      backgroundColor: kBlueStarlight,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
