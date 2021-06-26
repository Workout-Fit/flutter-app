import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WorkoutsPage extends StatefulWidget {
  @override
  WorkoutsPageState createState() => WorkoutsPageState();
}

class WorkoutsPageState extends State<WorkoutsPage> {
  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(top: 48.0),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your workouts',
                  style: Theme.of(context).textTheme.headline4,
                ),
                IconButton(
                  icon: Icon(Icons.dark_mode_outlined),
                  onPressed: () {},
                )
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: TextField(
                    decoration:
                        InputDecoration(hintText: "Search for a workout..."),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {},
                )
              ],
            ),
            SizedBox(height: 16),
            Flexible(
              child: Center(
                child: Text("You have no workouts."),
              ),
            ),
          ],
        ),
      );
}
