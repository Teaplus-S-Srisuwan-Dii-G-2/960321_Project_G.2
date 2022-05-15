import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_960321/constant.dart';

class ShowAll extends StatefulWidget {
  const ShowAll({Key? key, required this.name}) : super(key: key);
  final String name;
  @override
  State<ShowAll> createState() => _ShowAllState(name: name);
}

class _ShowAllState extends State<ShowAll> {
  String name;
  _ShowAllState({required this.name});
  fetchMovies() async {
    var url;
    url = await http
        .get(Uri.parse("https://api.aniapi.com/v1/anime?genres=$name"));
    return json.decode(url.body)['data']['documents'];
  }

  @override
  Widget build(BuildContext context) {
    int i = 0;
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
          future: fetchMovies(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                padding: EdgeInsets.all(20),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      print(i++);
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 250,
                          width: 150,
                          alignment: Alignment.centerLeft,
                          child: FittedBox(
                            child: Image.network(
                              snapshot.data[index]['cover_image'],
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  snapshot.data[index]["titles"]["rj"],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Year : " +
                                      snapshot.data[index]['season_year']
                                          .toString(),
                                  style: TextStyle(color: Color(0xff868597)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 100,
                                  child: Text(
                                    snapshot.data[index]["descriptions"]["en"],
                                    style: TextStyle(
                                        fontSize: 12, color: Color(0xff868597)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
