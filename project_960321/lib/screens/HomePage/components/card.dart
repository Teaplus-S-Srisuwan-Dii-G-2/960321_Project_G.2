import 'dart:convert';
import 'package:animations/animations.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project_960321/constant.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../../DetailPage/detailScreen.dart';

class Trendind extends StatelessWidget {
  const Trendind({Key? key, required this.size, required this.num})
      : super(key: key);
  final Size size;
  final int num;

  @override
  Widget build(BuildContext context) {
    int num1 = num;
    return FutureBuilder<dynamic>(
      future: fetchAnime("2022"),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          while (snapshot.data[num1]['banner_image'] == null) {
            num1++;
          }
          return TitleCard(
              title: snapshot.data[num1]["titles"]["rj"],
              img: snapshot.data[num1]['banner_image'],
              id: snapshot.data[num1]['anilist_id'].toString());
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // รูป Spiner ขณะรอโหลดข้อมูล
        return LinearProgressIndicator(
          color: kPrimaryColor,
          backgroundColor: kBackgroundColor,
        );
      },
    );
  }
}

class TitleCard extends StatelessWidget {
  const TitleCard(
      {Key? key, required this.title, required this.img, required this.id})
      : super(key: key);

  final String title;
  final String img;
  final String id;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return OpenContainer(
      transitionType: ContainerTransitionType.fade,
      transitionDuration: Duration(seconds: 1),
      openBuilder: (context, _) => detail(id: id, name: title),
      closedElevation: 0,
      closedColor: kBackgroundColor,
      closedBuilder: (context, _) => Container(
        margin: EdgeInsets.all(size.width * 0.05),
        padding: EdgeInsets.all(size.width * 0.05),
        height: 200,
        decoration: BoxDecoration(
            color: kBackgroundColor,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(img),
              fit: BoxFit.fitHeight,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),),
            boxShadow: [ BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: kPrimaryColor.withOpacity(0.23))
                    ],
            ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AutoSizeText(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 1,
              ),
            ]),
      ),
    );
  }
}

Future<dynamic> fetchAnime(String type) async {
  final response =
      await http.get(Uri.parse('https://api.aniapi.com/v1/anime?year=$type'));

  if (response.statusCode == 200) {
    return json.decode(response.body)['data']['documents'];
  } else {
    throw Exception('Failed to load Anime');
  }
}
