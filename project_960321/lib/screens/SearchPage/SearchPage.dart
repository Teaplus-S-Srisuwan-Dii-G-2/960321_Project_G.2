import 'package:flutter/material.dart';
import 'package:project_960321/screens/SearchPage/ShowSearchPage.dart';
import 'package:project_960321/screens/ShowAllPage/show_all.dart';

import '../../constant.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        elevation: 0.0,
        backgroundColor: kBackgroundColor,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            child: TextField(
              controller: search,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Anime Titles',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                focusColor: kPrimaryColor,
                fillColor: Colors.white,
              ),
              style: TextStyle(color: Colors.red),
            ),
          ),
          Container(
              child: OutlineButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ShowSearch(name: search.text)),
            ),
            textColor: Colors.blue,
            borderSide: BorderSide(
                color: Colors.blue, width: 1.0, style: BorderStyle.solid),
            child: Text(
              'Search',
            ),
          ))
        ],
      ),
      // backgroundColor: kBackgroundColor,
    );
  }
}
