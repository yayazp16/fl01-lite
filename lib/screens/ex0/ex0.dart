import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Ex0Page extends StatefulWidget {
  const Ex0Page({Key? key}) : super(key: key);
  
  @override
  _Ex0PageState createState() => _Ex0PageState();
}

class _Ex0PageState extends State<Ex0Page> {
  final omikujiList = [
    '大吉',
    '吉',
    '中吉',
    '小吉',
    '半吉',
    '末吉',
    '末小吉',
    '凶',
    '小凶',
    '半凶',
    '末凶',
    '大凶'
  ];
  var unsei = '';
  String fortune() {
    var rand = Random().nextInt(omikujiList.length);
    return omikujiList[rand];
  }
  @override
  void initState() {
    unsei = fortune();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Container(
            width: 200.0,
            height: 200.0,
            decoration:
                const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
            child: Center(
                child: Text(
              unsei,
              style: const TextStyle(fontSize: 50, color: Colors.white),
            )),
          )),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () => {
              setState(() {
                unsei = fortune();
              })
            },
            child: Text(
              "あなたの運勢は？",
              style: TextStyle(fontSize: 20, color: Colors.lightBlue[900]),
            ),
            splashColor: Colors.white,
          ),
        ],
      )),
    );
  }
}
