import 'package:flutter/material.dart';

enum AppBarType { empty, titleAction, basic }

extension AppBarTypeEx on AppBarType {
  PreferredSizeWidget appBar({
    Function? beforeReturnBack,
    bool isBackNavigate = true,
    bool hasBackIcon = true,
    Widget? leftWidget,
    Widget? rightWidget,
    String? title,
    bool hasColor = true,
    bool isDarkMode = false,
  }) {
    switch (this) {
      case AppBarType.empty:
        return AppBar(
          backgroundColor: Colors.transparent,
        );
      case AppBarType.titleAction:
        return AppBar(
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.settings_outlined))
          ],
        );
      case AppBarType.basic:
        return AppBar(
          title: Text('DevProject'),
          backgroundColor: Colors.white,
        );
    }
  }
}