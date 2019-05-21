import 'package:flutter/material.dart';
import 'package:load/load.dart';

class NextPage extends StatefulWidget {
  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  void initState() {
    super.initState();
    showLoadingDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
