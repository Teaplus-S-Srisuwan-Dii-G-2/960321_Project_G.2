import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project_960321/constant.dart';
import 'package:project_960321/screens/HomePage/components/card.dart';

import 'slideCard.dart';
import 'textTitle.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView(children: <Widget>[
      TitleHead(size: size),
      Trendind(
        size: size,
        num: Random().nextInt(99),
      ),
      Trendind(
        size: size,
        num: Random().nextInt(99),
      ),
      Container(
        child: Column(children: [
          TextTitle(
            size: size,
            name: "Action",
          ),
          SlideCard(
            size: size,
            type: "Action",
          ),
        ]),
      ),
      Container(
        child: Column(children: [
          TextTitle(
            size: size,
            name: "School",
          ),
          SlideCard(
            size: size,
            type: "School",
          ),
        ]),
      ),
      Container(
          child: Column(
        children: [
          TextTitle(
            size: size,
            name: "Astronomy",
          ),
          SlideCard(
            size: size,
            type: "Astronomy",
          ),
        ],
      )),
    ]);
  }
}

class TitleHead extends StatelessWidget {
  const TitleHead({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.05),
      padding: EdgeInsets.only(left: size.width * 0.1),
      child: Text(
        "Trending",
        style: TextStyle(fontSize: 32, color: Colors.white),
      ),
    );
  }
}
