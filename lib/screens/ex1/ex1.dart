import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Ex1Page extends StatefulWidget {
  const Ex1Page({Key? key}) : super(key: key);

  @override
  _Ex1PageState createState() => _Ex1PageState();
}

class _Ex1PageState extends State<Ex1Page> {
  var time = '';
  late Timer timer;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(milliseconds: 300), getTimeNow);
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  getTimeNow(Timer callback) {
    var timeNow = DateTime.now();
    setState(() {
      time = DateFormat.Hms().format(timeNow);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("カウンタータイマー ",),
      ),
      body: SafeArea(child: Text(time,style: const TextStyle(fontSize: 50))),
    );
  }
}
