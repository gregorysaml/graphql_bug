import 'package:flutter/material.dart';

class Name extends StatelessWidget {
  const Name({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const Text('Cool')],
        ),
      ),
    );
  }
}
