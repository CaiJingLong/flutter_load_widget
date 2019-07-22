import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:load/load.dart';

void main() {
  runApp(
    LoadingProvider(
      themeData: LoadingThemeData(
          // tapDismiss: false,
          ),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    showAndDelayDismiss();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    showAndDelayDismiss();
  }

  void showAndDelayDismiss(
      [Duration duration = const Duration(seconds: 2)]) async {
    var future = await showLoadingDialog();
    Future.delayed(duration, () {
      future.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          buildDefaultDialog(),
          buildCustomLoadingButton(),
          buildTouchLoadingDialog(),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildCustomLoadingButton() {
    return IconButton(
      icon: Icon(Icons.cloud_download),
      onPressed: () {
        showCustomLoadingWidget(
          Center(
            child: Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  LinearProgressIndicator(),
                  Container(
                    height: 10,
                  ),
                  Text("loading"),
                ],
              ),
            ),
          ),
          tapDismiss: false,
        );
      },
    );
  }

  Widget buildTouchLoadingDialog() {
    return IconButton(
      icon: Icon(Icons.touch_app),
      onPressed: () {
        showCustomLoadingWidget(
          Center(
            child: Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 40,
                    height: 40,
                    color: Colors.blue,
                    child: CupertinoActivityIndicator(
                      radius: 10,
                    ),
                  ),
                  Container(
                    height: 10,
                  ),
                  FlatButton(
                    color: Colors.white,
                    child: Text("Add"),
                    onPressed: () {
                      _counter++;
                      setState(() {});
                      print("touch Add button, this counter is :$_counter");
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildDefaultDialog() {
    return IconButton(
      icon: Icon(Icons.slideshow),
      onPressed: () {
        showLoadingDialog();
      },
    );
  }

  Widget exampleLoadApp() {
    return LoadingProvider(
      themeData: LoadingThemeData(),
      loadingWidgetBuilder: (ctx, data) {
        return Center(
          child: SizedBox(
            width: 30,
            height: 30,
            child: Container(
              child: CupertinoActivityIndicator(),
              color: Colors.blue,
            ),
          ),
        );
      },
      child: MyApp(),
    );
  }
}
