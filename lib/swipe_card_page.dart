import 'package:flutter/material.dart';
import 'package:login/content.dart';
import 'package:swipe_cards/swipe_cards.dart';

class SwipeCardPage extends StatefulWidget {
  const SwipeCardPage({Key? key}) : super(key: key);

  @override
  State<SwipeCardPage> createState() => _SwipeCardPageState();
}

class _SwipeCardPageState extends State<SwipeCardPage> {
  late MatchEngine _matchEngine;
  late List<SwipeItem> _SwipeItems;
  late bool _isNoItem = false;

  void reset() {
    _SwipeItems = [];
    for (var content in contents) {
      var swipeItem = SwipeItem(
        content: content,
      );
      _SwipeItems.add(swipeItem);
    }

    _matchEngine = MatchEngine(swipeItems: _SwipeItems);
    _isNoItem = false;
  }

  @override
  void initState() {
    reset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        elevation: 77.0,
        backgroundColor: Color.fromARGB(0, 196, 32, 32),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),*/

      // body app
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 70, top: 0, right: 0, left: 0),
          child: Container(
            child: _isNoItem
                ? Center(
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          reset();
                        });
                      },
                      icon: const Icon(Icons.restore),
                    ),
                  )
                : Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 20),
                        color: const Color.fromARGB(255, 255, 255, 255), // Change this to the desired color
                        child: SwipeCards(
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    contents[index].imageURL,
                                    width: 400,
                                    height: 400,
                                    fit: BoxFit.cover,
                                  ),
                                  Text(
                                    contents[index].title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40,
                                    ),
                                  ),
                                  Text(
                                    contents[index].age,
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          matchEngine: _matchEngine,
                          onStackFinished: () {
                            print('onStackFinished');
                            setState(() {
                              _isNoItem = true;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FloatingActionButton(
                              heroTag: '1',
                              onPressed: () {
                                _matchEngine.currentItem!.nope();
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              shape: CircleBorder(),
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 17, 0),
                            ),
                            FloatingActionButton(
                              heroTag: '2',
                              onPressed: () {
                                _matchEngine.currentItem!.like();
                              },
                              child:
                                  const Icon(Icons.check, color: Colors.white),
                              shape: CircleBorder(),
                              backgroundColor: Color.fromARGB(255, 6, 197, 13),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
