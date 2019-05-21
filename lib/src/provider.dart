import 'package:flutter/material.dart';

import 'loading.dart';
import 'theme.dart';

List<GlobalKey<_LoadingProviderState>> _keys = [];

class LoadingProvider extends StatefulWidget {
  final Widget child;

  final LoadingThemeData themeData;

  final Key key;

  final LoadingWidgetBuilder loadingWidgetBuilder;

  LoadingProvider({
    @required this.child,
    this.themeData,
    this.loadingWidgetBuilder = LoadingWidget.buildDefaultLoadingWidget,
    Key key,
  })  : key = createKey(),
        super(key: key);

  @override
  _LoadingProviderState createState() => _LoadingProviderState();

  static GlobalKey<_LoadingProviderState> createKey() {
    return GlobalKey();
  }
}

class _LoadingProviderState extends State<LoadingProvider> {
  GlobalKey<OverlayState> overlayKey = GlobalKey();

  OverlayEntry entry;

  @override
  void initState() {
    super.initState();
    _keys.add(widget.key);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Overlay(
        key: overlayKey,
        initialEntries: [
          OverlayEntry(
            builder: (BuildContext context) {
              return widget.child;
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _keys.remove(widget.key);
    super.dispose();
  }

  void showLoading() {
    this.entry?.remove();
    var themeData = widget.themeData ?? LoadingThemeData();
    var w = LoadingTheme(
      data: themeData,
      child: LoadingWidget(
        loadingWidgetBuilder: widget.loadingWidgetBuilder,
      ),
    );
    var entry = OverlayEntry(builder: (BuildContext context) {
      return w;
    });

    overlayKey.currentState.insert(entry);

    this.entry = entry;
  }

  void hideLoading() {
    entry?.remove();
    entry = null;
  }
}

showLoadingDialog() {
  Future.delayed(Duration.zero, () {
    if (_keys.isNotEmpty) {
      var key = _keys.first;
      key.currentState.showLoading();
    }
  });
}

hideLoadingDialog() {
  Future.delayed(Duration.zero, () {
    if (_keys.isNotEmpty) {
      var key = _keys.first;
      key.currentState.hideLoading();
    }
  });
}
