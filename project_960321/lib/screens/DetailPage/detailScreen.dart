import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:project_960321/screens/DetailPage/component/video.dart';
import '../../constant.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class detail extends StatefulWidget {
  const detail({Key? key, required this.id, required this.name})
      : super(key: key);
  final String id;
  final String name;

  @override
  State<detail> createState() => _detailState(id: id, name: name);
}

class _detailState extends State<detail> {
  String id;
  String name;
  _detailState({required this.id, required this.name});
  fechdetail() async {
    var url;
    url = await http
        .get(Uri.parse("https://api.aniapi.com/v1/anime?anilist_id=$id"));
    return json.decode(url.body)['data']['documents'];
  }

  @override
  Widget build(BuildContext context) {
    var myGroup = AutoSizeGroup();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          name,
          style: TextStyle(fontSize: 25.0, color: kPrimaryColor),
        ),
        elevation: 0.0,
        backgroundColor: kBackgroundColor,
      ),
      body: FutureBuilder(
          future: fechdetail(),
          builder: (BuildContext cotext, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                padding: EdgeInsets.all(20),
                itemBuilder: (BuildContext context, int index) {
                  String imgcov =
                      snapshot.data[index]['cover_image'].toString();
                  return GestureDetector(
                    onTap: () {},
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.topCenter,  
                          width: size.width,
                          height: size.height/2,
                          child: Image.network(
                            snapshot.data[index]['banner_image'],
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(top: 40),
                            child: Column(
                              children: [
                                Image.network(
                            snapshot.data[index]['cover_image'],
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                                  height: 10,
                                ),
                                AutoSizeText(
                                    snapshot.data[index]["titles"]["rj"],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1),
                                SizedBox(
                                  height: 10,
                                ),
                                AutoSizeText(
                                  "season_year : " +
                                      snapshot.data[index]['season_year']
                                          .toString(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Color(0xff868597)),
                                ),
                                AutoSizeText(
                                  "start_date : " +
                                      snapshot.data[index]['start_date']
                                          .toString(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Color(0xff868597)),
                                ),
                                AutoSizeText(
                                  "end_date : " +
                                      snapshot.data[index]['end_date']
                                          .toString(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Color(0xff868597)),
                                ),
                                AutoSizeText(
                                  "episode_duration : " +
                                      snapshot.data[index]['episode_duration']
                                          .toString(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(color: Color(0xff868597)),
                                ),
                                AutoSizeText(
                                  snapshot.data[index]["descriptions"]["en"],
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xff868597)),
                                  maxLines: 6,
                                  group: myGroup,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                VideoYoutubeNaja(
                                  url: snapshot.data[index]["trailer_url"],
                                )
                              ],
                            )),
                      ],
                    ),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
