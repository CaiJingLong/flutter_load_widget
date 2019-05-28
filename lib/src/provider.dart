import 'dart:async';
import 'package:flutter/material.dart';

import 'dismiss_future.dart';
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

  GlobalKey<LoadingWidgetState> loadingKey = GlobalKey();

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

  LoadingDismissFuture showLoading() {
    _realDismissDialog();
    var themeData = widget.themeData ?? LoadingThemeData();
    var w = LoadingTheme(
      data: themeData,
      child: LoadingWidget(
        key: loadingKey,
        loadingWidgetBuilder: widget.loadingWidgetBuilder,
      ),
    );
    var entry = OverlayEntry(builder: (BuildContext context) {
      return w;
    });

    overlayKey.currentState.insert(entry);

    var future =
        LoadingDismissFuture(entry, loadingKey, themeData.animDuration);
    return future;
  }

  LoadingDismissFuture showLoadingWidget(Widget loadingWidget) {
    _realDismissDialog();
    var themeData = widget.themeData ?? LoadingThemeData();
    var w = LoadingTheme(
      data: themeData,
      child: LoadingWidget(
        key: loadingKey,
        loadingWidgetBuilder: (_, __) => loadingWidget,
      ),
    );
    var entry = OverlayEntry(builder: (BuildContext context) {
      return w;
    });

    overlayKey.currentState.insert(entry);

    var future =
        LoadingDismissFuture(entry, loadingKey, themeData.animDuration);
    return future;
  }

  void _realDismissDialog() {
    FutureManager.getInstance().dismissAll(false);
  }

  void dismissLoading() {
    _realDismissDialog();
  }
}

/// Use [LoadingDismissFuture.dismiss] can dismiss current dialog
Future<LoadingDismissFuture> showLoadingDialog() {
  print("show loading dialog");
  var c = Completer<LoadingDismissFuture>();
  Future.delayed(Duration.zero, () {
    if (_keys.isNotEmpty) {
      var key = _keys.first;
      c.complete(key.currentState.showLoading());
    }
  });
  return c.future;
}

Future<LoadingDismissFuture> showCustomLoadingWidget(Widget widget) {
  var c = Completer<LoadingDismissFuture>();
  Future.delayed(Duration.zero, () {
    if (_keys.isNotEmpty) {
      var key = _keys.first;
      c.complete(key.currentState.showLoadingWidget(widget));
    }
  });
  return c.future;
}

/// will dismiss all dialog
void hideLoadingDialog() {
  print("hideLoadingDialog");
  Future.delayed(Duration.zero, () {
    if (_keys.isNotEmpty) {
      var key = _keys.first;
      key?.currentState?.loadingKey?.currentState?.dismissAnim();
      key.currentState.dismissLoading();
    }
  });
}
