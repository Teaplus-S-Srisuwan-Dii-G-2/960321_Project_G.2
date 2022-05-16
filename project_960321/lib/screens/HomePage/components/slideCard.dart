import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_960321/constant.dart';
import 'dart:convert';
import 'dart:async';

import '../../DetailPage/detailScreen.dart';

Future<dynamic> fetchAnime(String type) async {
  final response =
      await http.get(Uri.parse('https://api.aniapi.com/v1/anime?genres=$type'));

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load Anime');
  }
}

class SlideCard extends StatelessWidget {
  const SlideCard({Key? key, required this.size, required this.type})
      : super(key: key);

  final Size size;
  final String type;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: FutureBuilder<dynamic>(
        future: fetchAnime(type),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                //สร้าง Widget ListView
                padding: EdgeInsets.all(16.0),
                itemBuilder: (context, i) {
                  //หากไม่สร้าง Object สามารถเรียกใช้งานแบบนี้ได้เลย
                  return MyBox(
                      title: snapshot.data["data"]["documents"][i]["titles"]
                          ["rj"],
                      img: snapshot.data["data"]["documents"][i]["cover_image"],
                      id: snapshot.data["data"]["documents"][i]["anilist_id"]
                          .toString());
                },
                itemCount: 5);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // รูป Spiner ขณะรอโหลดข้อมูล
          return LinearProgressIndicator(
            color: kPrimaryColor,
            backgroundColor: kBackgroundColor,
          );
        },
      ),
    );
  }
}

class MyBox extends StatelessWidget {
  const MyBox(
      {Key? key, required this.title, required this.img, required this.id})
      : super(key: key);

  final String title;
  final String img;
  final String id;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        print("next page >>");
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  animation = CurvedAnimation(
                      parent: animation, curve: Curves.easeInOut);
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) {
                  return detail(
                    id: id,
                    name: title,
                  );
                }));
      },
      child: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(left: size.width * 0.05),
        height: 180,
        width: 150,
        decoration: BoxDecoration(
            color: kBackgroundColor,
            borderRadius: BorderRadius.circular(20),
            image:DecorationImage(image: NetworkImage(img), 
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken)),
              boxShadow: [BoxShadow(
                          offset: Offset(0, 5),
                          blurRadius: 5,
                          color: kPrimaryColor.withOpacity(0.23))
                    ],),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AutoSizeText(title, style: TextStyle(fontSize: 18, color: Colors.white),maxLines: 1,)
          ],
        ),
      ),
    );
  }
}
