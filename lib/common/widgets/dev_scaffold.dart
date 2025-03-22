import 'package:flutter/material.dart';

import 'app_bars/app_bar_type.dart';

class DevScaffold extends StatelessWidget {
  const DevScaffold({
    super.key,
    required this.body,
    this.appBarType,
    this.title = '',
    this.extendBodyBehindAppBar = false,
    this.beforeReturnBack,
    this.isBackNavigate = true,
    this.hasBackIcon = true,
    this.rightWidget,
    this.leftWidget,
    this.bottomNavigationBar,
    this.isWhiteBg = false,
    this.bgColor,
    this.hasAppBarColor = true,
    this.isBackDarkMode = false,
  });


  final Widget body;
  final AppBarType? appBarType;
  final String title;
  final bool extendBodyBehindAppBar;
  final Function? beforeReturnBack;
  final bool isBackNavigate;
  final bool hasBackIcon;
  final Widget? rightWidget;
  final Widget? leftWidget;
  final Widget? bottomNavigationBar;
  final bool isWhiteBg;
  final Color? bgColor;
  final bool hasAppBarColor;
  final bool isBackDarkMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarType?.appBar(
        beforeReturnBack: beforeReturnBack,
        hasBackIcon: hasBackIcon,
        isBackNavigate: isBackNavigate,
        rightWidget: rightWidget,
        leftWidget: leftWidget,
        title: title,
        hasColor: hasAppBarColor,
        isDarkMode: isBackDarkMode,
      ),
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: bgColor ?? (isWhiteBg ? Colors.white : null),
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      body: isWhiteBg == true || bgColor != null
          ? body
          : Stack(
        children: [
          body,
        ],
      ),
    );
  }
}
