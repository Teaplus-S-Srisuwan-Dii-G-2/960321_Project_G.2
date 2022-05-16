import 'package:flutter/material.dart';
import 'package:project_960321/constant.dart';
import 'package:project_960321/screens/ShowAllPage/show_all.dart';

class TextTitle extends StatelessWidget {
  const TextTitle({Key? key, required this.size, required this.name})
      : super(key: key);

  final Size size;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.only(left: size.width * 0.1),
              child: Text(name,
                  style: TextStyle(fontSize: 20, color: Colors.white))),
          Spacer(),
          Container(
              margin: EdgeInsets.only(right: size.width * 0.05),
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 500),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              animation = CurvedAnimation(
                                  parent: animation, curve: Curves.easeInOut);
                              return ScaleTransition(
                                scale: animation,
                                child: child,
                              );
                            },
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return ShowAll(
                                name: name,
                              );
                            }));
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Icon(Icons.arrow_forward_ios, color: kPrimaryColor)))
        ],
      ),
    );
  }
}
