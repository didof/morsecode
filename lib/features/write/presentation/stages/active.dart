import 'package:flutter/material.dart';

class WriteActiveUI extends StatelessWidget {
  final String word;
  const WriteActiveUI({@required this.word});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(word),
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Theme.of(context).primaryColor)),
            child: InkWell(
              onTap: () {
                print('dot');
              },
              onLongPress: () {
                print('dash');
              },
              borderRadius: BorderRadius.circular(100),
              splashColor: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
// TODO create on UI an amount of slots as many letters the word is comosed of
// TODO operate on one slot at time
// TODO create two usecases (dot & dash) that create the user composition and
// renders it on the UI
// TODO when last slot is composed confront with the instance.morsecode, save
// the result and proceed to next word.
// TODO if it was last word, complete the level and assign completed and stars
// (in sqlite)