import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'provider.dart';
import 'theme.dart';

typedef Widget LoadingWidgetBuilder(
    BuildContext context, LoadingThemeData data);

class LoadingWidget extends StatefulWidget {
  final LoadingWidgetBuilder loadingWidgetBuilder;

  const LoadingWidget({
    Key key,
    this.loadingWidgetBuilder,
  }) : super(key: key);

  @override
  LoadingWidgetState createState() => LoadingWidgetState();

  static Widget buildDefaultLoadingWidget(
    BuildContext context,
    LoadingThemeData data,
  ) {
    return Center(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {},
        child: Container(
          width: data.loadingSize.width,
          height: data.loadingSize.height,
          decoration: BoxDecoration(
            color: data.loadingBackgroundColor,
            borderRadius: data.borderRadius,
          ),
          padding: data.loadingPadding,
          child: CircularProgressIndicator(),
          // child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}

class LoadingWidgetState extends State<LoadingWidget> {
  bool show = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      show = true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildLoadingWidget();
  }

  Widget buildLoadingWidget() {
    var data = LoadingTheme.of(context);
    Widget w = widget.loadingWidgetBuilder(context, data);

    if (data.backgroundColor != null) {
      w = AnimatedOpacity(
        duration: data.animDuration,
        opacity: show ? 1 : 0,
        child: Container(
          child: w,
          color: data.backgroundColor,
        ),
      );
    }

    if (data.tapDismiss) {
      w = GestureDetector(
        child: w,
        behavior: HitTestBehavior.translucent,
        onTap: hideLoadingDialog,
      );
    }

    return w;
  }

  void dismissAnim() {
    setState(() {
      show = false;
    });
  }
}
