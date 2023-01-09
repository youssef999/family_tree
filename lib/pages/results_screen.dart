

// ignore_for_file: deprecated_member_use

  import 'package:family_tree/database/database.dart';
import 'package:family_tree/models/treemember.dart';
import 'package:family_tree/pages/homepage.dart';
import 'package:family_tree/pages/updatepage.dart';
import 'package:flutter/material.dart';

class ResultsScreen extends StatefulWidget {
  String _selected1;


  ResultsScreen(this._selected1);

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:   FutureBuilder(
          future: DBProvider.db.getMembers(widget._selected1),
          builder: (context, ss) {
            if (ss.connectionState == ConnectionState.waiting && !ss.hasData) {
              return Container(child: Text('لا بيانات',style: TextStyle(fontWeight: FontWeight.bold),),);
            } else {
              var data = List.from(ss.data)..removeAt(0);
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, item) {
                    TreeMember treemember =
                    TreeMember.fromJson(data[item]);
                    return Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.people),
                          Text(
                            treemember.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              // ignore: deprecated_member_use
                              RaisedButton(
                                child: Text(
                                  "تحديث",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                                onPressed: () {
                                  
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Update(
                                                table: widget._selected1,
                                                treeMember:
                                                treemember,
                                              ))).then((value) {
                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             HomePage()));
                                  });


                                },
                              ),
                              Spacer(),
                              RaisedButton(
                                child: Text(
                                  "حذف",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                                onPressed: () {

                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: const Text("هل انت متاكد من انك تريد الحذف"),
                                      content: const Text("لا تحذف شخص عنده ابناء حتي لا تفسد شجرة العائلة"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                  DBProvider.db.removeMember(
                                  treemember, widget._selected1);

                                  Future.delayed(Duration(seconds: 1), () {
                                  Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                  builder: (context) =>
                                  HomePage()));
                                  });
                                          },
                                          child: Container(
                                            color: Colors.green,
                                            padding: const EdgeInsets.all(14),
                                            child: const Text("نعم ",
                                                style:TextStyle(
                                              color:Colors.white,fontSize: 20
                                            )
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                          child: Container(
                                            color: Colors.green,
                                            padding: const EdgeInsets.all(14),
                                            child: const Text("لا",
                                  style:TextStyle(
                                  color:Colors.white,fontSize: 20
                                  )
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );





                                 // });


                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            }
          })
    );
  }
}
