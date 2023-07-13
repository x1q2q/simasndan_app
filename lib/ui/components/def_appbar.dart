import 'package:flutter/material.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';

class DefAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actBtn;
  const DefAppBar({Key? key, required this.title, this.actBtn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(
        color: orangev3, //change your color here
      ),
      backgroundColor: orangev1,
      elevation: 0.3,
      title: Text(title, style: Styles.titleBarStyle),
      centerTitle: false,
      actions: actBtn,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


// by rafiknurf