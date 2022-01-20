import 'package:fl01_lite/screens/ex2/ex2_create.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Ex2Page extends StatefulWidget {
  const Ex2Page({Key? key}) : super(key: key);

  @override
  State<Ex2Page> createState() => _Ex2PageState();
}

class _Ex2PageState extends State<Ex2Page> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text("My Memos"),
          actions: [
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const Ex2CreatePage(
                          isCreate: true,
                        )),
              ),
              icon: const Icon(
                Icons.add,
                size: 32,
              ),
              splashRadius: 25,
            )
          ],
        ),
        body: ValueListenableBuilder(
          valueListenable: Hive.box("memos").listenable(),
          builder: (context, Box<dynamic> box, child) {
            return LayoutBuilder(builder: (context, constrain) {
              // Calculate height of MemoTile
              var h = constrain.maxHeight;
              int memoNum = 13;
              var memoHeight = (h ~/ (memoNum)) - 1.0;

              return AnimatedList(
                key: _listKey,
                initialItemCount: memoNum,
                itemBuilder: (context, idx, _) {
                  return GestureDetector(
                    onTap: () {

                      //If user click on valid MemoTile, set isCreate = false for edit mode.
                      if (box.length != 0 && idx < box.length) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Ex2CreatePage(
                                    isCreate: false,
                                    text: box.getAt(idx),
                                    id: idx,
                                  )),
                        );
                      }
                    },
                    child: SizedBox(
                      height: memoHeight,
                      width: double.infinity,
                      child: Slidable(
                        key: ValueKey(idx),
                        enabled: box.length - 1 >= idx,
                        endActionPane: ActionPane(
                          extentRatio: .2,
                          motion: const BehindMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (_) async {

                                //Insert dummy MemoTile to list and remove selected MemoTile
                                AnimatedList.of(context).insertItem(box.length);
                                AnimatedList.of(context).removeItem(idx,
                                    (context, animation) {
                                  return SizeTransition(
                                    sizeFactor: animation,
                                    child: MemoTile(
                                      box: box,
                                      idx: idx,
                                    ),
                                  );
                                });

                                // Delete memo from database
                                await box.deleteAt(idx);
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: MemoTile(
                          box: box,
                          idx: idx,
                        ),
                      ),
                    ),
                  );
                },
              );
            });
          },
        ));
  }
}

class MemoTile extends StatelessWidget {
  const MemoTile({
    Key? key,
    required this.box,
    required this.idx,
  }) : super(key: key);
  final Box<dynamic> box;
  final int idx;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(              
                    box.length - 1 >= idx                   // idx (index) must lowwer then the database length.
                        ? box.getAt(idx)                    // if true: get memo from database
                        : '', //box.getAt(idx),             // false: empty string
                    style: const TextStyle(fontSize: 25),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                  ),
                ),
                if (box.length - 1 >= idx)
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black54,
                      size: 20,
                    ),
                    splashRadius: 18,
                  ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
              child: Divider(
                height: 1,
              ),
            )
          ],
        ));
  }
}
