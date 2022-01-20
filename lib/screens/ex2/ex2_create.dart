import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Ex2CreatePage extends StatefulWidget {
  const Ex2CreatePage({Key? key, this.isCreate, this.text, this.id})
      : super(key: key);
  final isCreate;
  final text;
  final id;
  // final GlobalKey<AnimatedListState> listKey;
  /// final totolLen;
  @override
  _Ex2CreatePageState createState() => _Ex2CreatePageState();
}

class _Ex2CreatePageState extends State<Ex2CreatePage> {
  late TextEditingController textEditingController;
  @override
  void initState() {
    textEditingController = TextEditingController(text: widget.text ?? '');
    super.initState();
  }

  void addMemo() async {
    var box = await Hive.openBox("memos");
    if (widget.isCreate) {
      // If create mode: add new memo to database
      await box.add(textEditingController.value.text);
    } else {
      // If edit mode: update memo
      await box.putAt(widget.id, textEditingController.value.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.isCreate ? "New memo" : "Edit memo"),
          leading: InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
              Navigator.of(context).pop();
            },
            child: const Center(child: Text("Cancel")),
          ),
          actions: [
            InkWell(
              onTap: () async {
                FocusScope.of(context).unfocus();
                addMemo();
                Navigator.of(context).pop();
              },
              child: const Center(
                  child: Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Text("Save"),
              )),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 50),
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),isDense: true),
          ),
        ));
  }
}
