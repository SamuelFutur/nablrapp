import 'package:flutter/material.dart';

class X extends StatefulWidget {
  const X({Key? key}) : super(key: key);

  @override
  State<X> createState() => _XState();
}

class _XState extends State<X> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("X"),
      ),
    );
  }
}
