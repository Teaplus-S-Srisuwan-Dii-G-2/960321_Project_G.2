import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import '../../constant.dart';

class detail extends StatefulWidget {
  const detail({Key? key, required this.name}) : super(key: key);
  final String name;
  @override
  State<detail> createState() => _detailState(name: name);
}

class _detailState extends State<detail> {
 String name;
 _detailState({required this.name});
 fechdetail() async {
   var url;
   url = await http.get(Uri.parse("https://api.aniapi.com/v1/anime?anilist_id=5114"));
   return json.decode(url.body);
 }
  
  
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          name,
          style: TextStyle(fontSize: 25.0, color: kPrimaryColor),
        ),
        elevation: 0.0,
        backgroundColor: kBackgroundColor,
      ),
      body:  Center(child: Column(children: [Container(
        child: Text(name),
      )]),
        
      ),
    );
  }
}
