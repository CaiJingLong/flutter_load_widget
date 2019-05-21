import 'package:flutter/material.dart';

class LoadingTheme extends InheritedWidget {
  final LoadingThemeData data;

  const LoadingTheme({Key key, this.data, Widget child})
      : super(child: child, key: key);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static LoadingThemeData of(BuildContext context) {
    final LoadingTheme result =
        context.inheritFromWidgetOfExactType(LoadingTheme);
    return result?.data;
  }
}

class LoadingThemeData {
  final bool tapDismiss;

  final Color backgroundColor;
  final Color loadingBackgroundColor;
  final EdgeInsets loadingPadding;
  final Size loadingSize;
  final Duration animDuration;

  const LoadingThemeData.raw(
    this.backgroundColor,
    this.loadingBackgroundColor,
    this.loadingPadding,
    this.loadingSize,
    this.tapDismiss,
    this.animDuration,
  );

  factory LoadingThemeData({
    Color backgroundColor = Colors.black54,
    Color loadingBackgroundColor = Colors.white,
    EdgeInsets loadingPadding = const EdgeInsets.all(8.0),
    Size loadingSize = const Size(55, 55),
    bool tapDismiss = true,
    Duration animDuration = const Duration(milliseconds: 300),
  }) {
    return LoadingThemeData.raw(
      backgroundColor,
      loadingBackgroundColor,
      loadingPadding,
      loadingSize,
      tapDismiss,
      animDuration,
    );
  }
}
