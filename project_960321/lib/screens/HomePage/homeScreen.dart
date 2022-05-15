import 'package:flutter/material.dart';
import 'package:project_960321/constant.dart';
import 'package:project_960321/screens/HomePage/components/body.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'search',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          )
        ],
      ),
      body: Body(),
      backgroundColor: kBackgroundColor,
    );
  }
}




// export PATH="$PATH:/Users/athiwatjansomwong/Desktop/flutter/bin"
