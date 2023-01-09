import 'package:family_tree/models/treemember.dart';
import 'package:family_tree/pages/infopage.dart';
import 'package:flutter/material.dart';
import 'package:family_tree/tools/string_extension.dart';

class GetNodeText extends StatefulWidget {
  final String txt1;
  final TreeMember treeMember;

  GetNodeText({this.txt1, this.treeMember});

  @override
  _GetNodeTextState createState() => _GetNodeTextState();
}

class _GetNodeTextState extends State<GetNodeText> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => InfoPage(
        //           txt1: widget.txt1,
        //           treeMember: widget.treeMember,
        //         )));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.green[100], spreadRadius: 1),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.txt1.split(" * ").length == 2)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Container(
                        // width: 230,
                        padding: const EdgeInsets.all(4.0),
                        child: Center(
                          child: Text(
                            "${widget.txt1.split(" * ")[1].capitalizeFirstofEach}",
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.person,
                        color: Colors.red,
                        size: 40,
                      ),
                    ],
                  ),
                ),
              )
            else
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Container(
                        // width: 200,
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.txt1.capitalizeFirstofEach
                                          .split(" * ")
                                          .toString()
                                          .replaceAll(
                                              widget.txt1.capitalizeFirstofEach
                                                  .split(" * ")[0],
                                              "")
                                          .replaceAll("*", "")
                                          .replaceAll("[", "")
                                          .replaceAll(',', '')
                                          .replaceAll("]", "") +
                                      "",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 50,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Center(
                                  child: Text(
                                    widget.txt1.capitalizeFirstofEach
                                            .split(" * ")[0]
                                            .replaceAll('Família',"")
                                            .replaceAll("*","") +
                                        "",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 50,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            )
                          ],
                        ),
                      ),
                      Icon(
                        Icons.people,
                        color: Colors.black,
                        size: 60,
                      ),
                    ],
                  ),
                ),
              ),
            widget.txt1.split(" * ").length == 2
                ? Card(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          Container(
                            // width: 200,
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "" +
                                  widget.txt1
                                      .split(" * ")[0]
                                      .capitalizeFirstofEach +
                                  "",
                              style: TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Icon(
                            Icons.person,
                            color: Colors.lightBlue,
                            size: 40,
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
