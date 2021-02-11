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
        context.dependOnInheritedWidgetOfExactType<LoadingTheme>();
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

  final BorderRadiusGeometry borderRadius;

  const LoadingThemeData.raw(
    this.backgroundColor,
    this.loadingBackgroundColor,
    this.loadingPadding,
    this.loadingSize,
    this.tapDismiss,
    this.animDuration,
    this.borderRadius,
  );

  factory LoadingThemeData({
    Color backgroundColor = Colors.black54,
    Color loadingBackgroundColor = Colors.white,
    EdgeInsets loadingPadding = const EdgeInsets.all(8.0),
    Size loadingSize = const Size(55, 55),
    bool tapDismiss = true,
    Duration animDuration = const Duration(milliseconds: 300),
    BorderRadiusGeometry borderRadius =
        const BorderRadius.all(Radius.circular(8)),
  }) {
    return LoadingThemeData.raw(
      backgroundColor,
      loadingBackgroundColor,
      loadingPadding,
      loadingSize,
      tapDismiss,
      animDuration,
      borderRadius,
    );
  }

  LoadingThemeData copyWith({
    Color backgroundColor,
    Color loadingBackgroundColor,
    EdgeInsets loadingPadding,
    Size loadingSize,
    bool tapDismiss,
    Duration animDuration,
    BorderRadiusGeometry borderRadius,
  }) {
    return LoadingThemeData.raw(
      backgroundColor ?? this.backgroundColor,
      loadingBackgroundColor ?? this.loadingBackgroundColor,
      loadingPadding ?? this.loadingPadding,
      loadingSize ?? this.loadingSize,
      tapDismiss ?? this.tapDismiss,
      animDuration ?? this.animDuration,
      borderRadius ?? this.borderRadius,
    );
  }
}
