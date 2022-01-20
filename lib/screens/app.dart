import 'package:fl01_lite/screens/ex0/ex0.dart';
import 'package:fl01_lite/screens/ex1/ex1.dart';
import 'package:fl01_lite/screens/ex2/ex2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // define all pages for generate button using [List.generate] below.
    final exam = [const Ex0Page(), const Ex1Page(), const Ex2Page()];
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("FL01-lite-sukon_sahunalu"),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                exam.length,
                (idx) => Center(
                    child: ElevatedButton(
                        onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => exam[idx]),
                            ),
                        child: Text("Ex$idx"))))));
  }
}
