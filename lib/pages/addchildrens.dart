
import 'package:family_tree/resources/colorManager.dart';
import 'package:flutter/material.dart';
import 'package:family_tree/database/database.dart';
import 'package:family_tree/models/treemember.dart';
import 'package:get/get.dart';
import 'homepage.dart';

class AddChildrens extends StatefulWidget {

   String parent;
  // int family;

  String selected1;
  int selected;
  int numChildren;

  AddChildrens({this.selected1, this.numChildren, this.selected,this.parent});

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddChildrens> {


  final _formKey = GlobalKey<FormState>();
  // colum1
  TextEditingController _name = TextEditingController();
  TextEditingController _name2 = TextEditingController();
  TextEditingController _name3 = TextEditingController();
  TextEditingController _name4 = TextEditingController();

  //  // column2
  // TextEditingController _name10 = TextEditingController();
  // TextEditingController _name20 = TextEditingController();
  // TextEditingController _name30 = TextEditingController();
  // TextEditingController _name40 = TextEditingController();
  //
  // //column3
  // TextEditingController _name50 = TextEditingController();
  // TextEditingController _name60 = TextEditingController();
  // TextEditingController _name70 = TextEditingController();
  // TextEditingController _name80 = TextEditingController();
  //
  // //column4
  // TextEditingController _name90 = TextEditingController();
  // TextEditingController _name100 = TextEditingController();
  // TextEditingController _name110 = TextEditingController();
  // TextEditingController _name120 = TextEditingController();
  //
  // //column5
  // TextEditingController _name130 = TextEditingController();
  // TextEditingController _name140 = TextEditingController();
  // TextEditingController _name150 = TextEditingController();
  // TextEditingController _name160 = TextEditingController();
  //
  //
  // //column6
  // TextEditingController _name170 = TextEditingController();
  // TextEditingController _name180 = TextEditingController();
  // TextEditingController _name190 = TextEditingController();
  // TextEditingController _name200= TextEditingController();
  //
  // //column7
  // TextEditingController _name210 = TextEditingController();
  // TextEditingController _name220 = TextEditingController();
  // TextEditingController _name230= TextEditingController();
  // TextEditingController _name240 = TextEditingController();
  //
  // //column8
  // TextEditingController _name250 = TextEditingController();
  // TextEditingController _name260 = TextEditingController();
  // TextEditingController _name270 = TextEditingController();
  // TextEditingController _name280 = TextEditingController();
  //
  // //column9
  // TextEditingController _name290 = TextEditingController();
  // TextEditingController _name300 = TextEditingController();
  // TextEditingController _name310 = TextEditingController();
  // TextEditingController _name320 = TextEditingController();
  //
  // //column10
  // TextEditingController _name330 = TextEditingController();
  // TextEditingController _name340 = TextEditingController();
  // TextEditingController _name350 = TextEditingController();
  // TextEditingController _name360 = TextEditingController();

  bool safe = true,
      married = false,
      married2 = false,
      married3 = false,
      dialog = false,
      safeNode = false,
      haveChild = false;
  Color color;
  String msg = '';

  var items = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int dropdownvalue = 0;
  var res = '';

  checkName(String table, String name) async {
    final res = await DBProvider.db.checkIfNameExists(table, name);
    setState(() {
      dialog = res;
    });
  }

  safeNodeStatus(String table) async {
    var res = await DBProvider.db.getMembers(table);
    if (res.length > 1) {
      setState(() {
        safeNode = true;
      });
    }
  }
  String _selected1='';
  int _selected=0;

  @override
  void initState() {

    super.initState();

     _selected1=widget.selected1;
    safeNodeStatus(_selected1);
     _selected=widget.selected;
     print("SSS="+_selected.toString());


  }

  @override
  Widget build(BuildContext context) {

    // _selected1=widget.selected1;
    // safeNodeStatus(_selected1);
    // _selected=widget.selected;


    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary2,
        title: Text(
          "شجرة العائلة",
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
                height: 730,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment(0, 0),
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [
                        ColorManager.primary,
                        ColorManager.primary,
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Container(
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               for (int i = 0; i < widget.numChildren; i++)
                                // if (married == false)
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          icon: Icon(Icons.person),
                                          hintText: ' الاسم ',
                                          labelText: 'الابن / الابنة',
                                        ),
                                        controller: _name,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'ادخل البيانات بشكل صحيح ';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.all(10)),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                    ),
                                    married == true
                                        ? Column(
                                            children: [
                                              TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  icon: Icon(Icons.person),
                                                  hintText:
                                                      'ادخل اسم الزوج/ الزوجة',
                                                  labelText: 'الزوج / الزوجة',
                                                ),
                                                controller: _name2,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return 'ادخل البيانات بشكل صحيح';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              SizedBox(height: 10),
                                              InkWell(
                                                child: Row(
                                                  children: [
                                                    SizedBox(width: 60),
                                                    Text("اضف زوجة اخري"),
                                                    SizedBox(width: 20),
                                                    InkWell(
                                                        child: Icon(Icons.add),
                                                        onTap: () {
                                                          setState(() {
                                                            married2 = true;
                                                          });
                                                        }),
                                                  ],
                                                ),
                                                onTap: () {
                                                  setState(() {
                                                    married2 = true;
                                                  });
                                                },
                                              ),
                                            ],
                                          )
                                        : Container(),
                                    SizedBox(height: 10),
                                    if (married2 == true)
                                      Column(
                                        children: [
                                          TextFormField(
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              icon: Icon(Icons.person),
                                              hintText:
                                                  'ادخل اسم الزوج/ الزوجة',
                                              labelText: 'الزوج / الزوجة',
                                            ),
                                            controller: _name3,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'ادخل البيانات بشكل صحيح';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(height: 10),
                                          InkWell(
                                            child: Row(
                                              children: [
                                                SizedBox(width: 60),
                                                Text("اضف زوجة اخري"),
                                                SizedBox(width: 20),
                                                InkWell(
                                                    child: Icon(Icons.add),
                                                    onTap: () {
                                                      setState(() {
                                                        married3 = true;
                                                      });
                                                    }),
                                              ],
                                            ),
                                            onTap: () {
                                              setState(() {
                                                married3 = true;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    SizedBox(height: 10),
                                    if (married3 == true)
                                      Column(
                                        children: [
                                          TextFormField(
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              icon: Icon(Icons.person),
                                              hintText:
                                                  'ادخل اسم الزوج/ الزوجة',
                                              labelText: 'الزوج / الزوجة',
                                            ),
                                            controller: _name4,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'ادخل البيانات بشكل صحيح';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    Padding(padding: EdgeInsets.all(10)),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            //  SizedBox(width: 40,),
                                            Text(
                                              'متزوج',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Checkbox(
                                                value: married,
                                                onChanged: (v) {
                                                  setState(() {
                                                    married = v;
                                                  });
                                                }),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            FutureBuilder(
                                                future:
                                                    DBProvider.db.getFamilies(),
                                                builder: (context, ss) {
                                                  if (ss.data == null) {
                                                    return Container(
                                                      child: Text(
                                                        'لا توجد عائلات ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    );
                                                  } else {
                                                    return Flexible(
                                                      child: DropdownButton(
                                                        value: _selected1,
                                                        items: ss.data.map<
                                                            DropdownMenuItem<
                                                                String>>((e) {
                                                          String response =
                                                              e['name'];
                                                          return DropdownMenuItem(
                                                            child: new Text(
                                                                response),
                                                            value: response,
                                                          );
                                                        }).toList(),
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _selected1 = value;
                                                            safe = true;
                                                            safeNodeStatus(value);
                                                          });
                                                          print(_selected1);
                                                        },
                                                      ),
                                                    );
                                                  }
                                                }),
                                            SizedBox(
                                              width: 30,
                                            ),
                                            Text(
                                              'اختر العائلة',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Padding(padding: EdgeInsets.all(10)),
                                        // married == true
                                        //     ?
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FutureBuilder(
                                                  future: safe == true
                                                      ? DBProvider.db
                                                          .getMembers(
                                                              _selected1)
                                                      : null,
                                                  builder: (context, ss) {
                                                    if (ss.data == null) {
                                                      return Container(
                                                        child: Text(
                                                          'لا توجد بيانات  حتى الان',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      );
                                                    }
                                                    else {
                                                      var data =
                                                          List.from(ss.data);
                                                         //..removeAt(0);


                                                       print("LENGTH"+data.length.toString());
                                                      if(_selected>data.length){
                                                        _selected=data.length;
                                                      }

                                                      return Flexible(
                                                        child: DropdownButton(
                                                          value: _selected,
                                                          items:
                                                          data.map<DropdownMenuItem<int>>((e)
                                                          {
                                                            TreeMember
                                                                treemember =
                                                                TreeMember
                                                                    .fromJson(e);
                                                            return DropdownMenuItem(
                                                              child: new Text(
                                                                  treemember
                                                                      .name
                                                                      .toString()
                                                              ),
                                                              value: treemember.id,
                                                            );
                                                          }).toList(),
                                                          onChanged: (value) {
                                                            setState(() {
                                                              _selected = value;
                                                            //  widget.selected=value;
                                                            });
                                                            print(_selected);
                                                          },
                                                        ),
                                                      );
                                                    }
                                                  }),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              Text(
                                                ' الاب لهذا الابن  ',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),


                                        // : Container(),
                                        Padding(padding: EdgeInsets.all(10)),
                                        ElevatedButton(
                                          onPressed: () {
                                            if (_formKey.currentState
                                                .validate())
                                            // _selected1 != null &&
                                            // (_selected != null ||
                                            //     _selected == null))

                                            {
                                              if (married == false) {
                                                checkName(
                                                    _selected1,
                                                    _name.text
                                                        .toLowerCase()
                                                        .trim());
                                                Future.delayed(
                                                    Duration(seconds: 3), () {
                                                  // dialog == true
                                                  //     ? showDialog(
                                                  //         context: context,
                                                  //         builder: (context) =>
                                                  //             AlertDialog(
                                                  //           title: Text(
                                                  //             "Alert",
                                                  //             style: TextStyle(
                                                  //                 fontWeight:
                                                  //                     FontWeight
                                                  //                         .bold),
                                                  //           ),
                                                  //           content: Text(
                                                  //             "${_name.text.toLowerCase().trim()} already exists!",
                                                  //             style: TextStyle(
                                                  //                 fontWeight:
                                                  //                     FontWeight
                                                  //                         .bold),
                                                  //           ),
                                                  //           actions: [
                                                  //             // ignore: deprecated_member_use
                                                  //             RaisedButton(
                                                  //                 child: Text(
                                                  //                   "رجوع ",
                                                  //                   style: TextStyle(
                                                  //                       fontWeight:
                                                  //                           FontWeight.bold),
                                                  //                 ),
                                                  //                 onPressed:
                                                  //                     () {
                                                  //                   Navigator.pop(
                                                  //                       context);
                                                  //                 }),
                                                  //             RaisedButton(
                                                  //                 child: Text(
                                                  //                   "ادخل",
                                                  //                   style: TextStyle(
                                                  //                       fontWeight:
                                                  //                           FontWeight.bold),
                                                  //                 ),
                                                  //                 onPressed:
                                                  //                     () {
                                                  //                   DBProvider
                                                  //                       .db
                                                  //                       .insertMember(
                                                  //                     TreeMember(
                                                  //                         _name
                                                  //                             .text
                                                  //                             .toLowerCase()
                                                  //                             .trim(),
                                                  //                       //  widget.family
                                                  //                         _selected
                                                  //                         widget.selected
                                                  //                     ),
                                                  //                     // widget
                                                  //                     //     .family,
                                                  //
                                                  //                     _selected1
                                                  //                   );
                                                  //                   // Get.snackbar('تم',  'تم اضافة البيانات بنجاح');
                                                  //                   // Navigator.of(
                                                  //                   //         context)
                                                  //                   //     .push(
                                                  //                   //         MaterialPageRoute(builder: (context) => LoadTree()));
                                                  //                   // Navigator.pop(context);
                                                  //                 })
                                                  //           ],
                                                  //         ),
                                                  //       )
                                                  //     :
                                                  safeNode == false
                                                          ? DBProvider.db
                                                              .insertMember(
                                                                  TreeMember(
                                                                      _name.text
                                                                          .toLowerCase()
                                                                          .trim(),
                                                                      1),
                                                                  _selected1)
                                                          : DBProvider.db
                                                              .insertMember(
                                                                  TreeMember(
                                                                      _name
                                                                          .text
                                                                          .toLowerCase()
                                                                          .trim(),
                                                                      //widget.family
                                                                     _selected
                                                                    //  widget.selected
                                                                  ),
                                                      _selected1
                                                                  );
                                                });
                                              } else if (married == true) {
                                                if (married3 == true) {
                                                  res =
                                                      "${_name.text.toLowerCase().trim()} * ${_name2.text.toLowerCase().trim()} * ${_name3.text.toLowerCase().trim()} * ${_name4.text.toLowerCase().trim()}";
                                                  checkName(_selected1, res);
                                                }
                                                if (married2 == false) {
                                                  res =
                                                      "${_name.text.toLowerCase().trim()} * ${_name2.text.toLowerCase().trim()}";
                                                  checkName(_selected1, res);
                                                }

                                                if (married2 == true) {
                                                  res =
                                                      "${_name.text.toLowerCase().trim()} * ${_name2.text.toLowerCase().trim()} * ${_name3.text.toLowerCase().trim()}";
                                                  checkName(_selected1, res);
                                                }

                                                checkName(_selected1, res);
                                                Future.delayed(
                                                    Duration(seconds: 3), () async {
                                                  dialog == true
                                                      ? showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              AlertDialog(
                                                            title: Text(
                                                              "!!!!!",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            content: Text(
                                                              "موجود مسبقا",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            actions: [
                                                              RaisedButton(
                                                                  child: Text(
                                                                    "رجوع",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  }),
                                                              RaisedButton(
                                                                  child: Text(
                                                                    "ادخل",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),

                                                                  onPressed:
                                                                      ()  async {

                                                                   await DBProvider.db.insertMember(
                                                                        TreeMember(
                                                                            res,
                                                                          //  widget.family
                                                                           _selected
                                                                        //    widget.selected
                                                                        ),
                                                                       _selected1
                                                                       );
                                                                  })
                                                            ],
                                                          ),
                                                        )
                                                      : safeNode == false
                                                          ?  DBProvider.db
                                                              .insertMember(
                                                                  TreeMember(
                                                                      res, 1),
                                                                  _selected1)
                                                          :  DBProvider.db
                                                              .insertMember(
                                                                  TreeMember(
                                                                      res,
                                                                    //  widget.selected
                                                                      _selected
                                                                    //  widget.family
                                                                  ),
                                                                  _selected1);


                                                });
                                              }
                                              setState(() {


                                                // _selected1=widget.selected1;
                                                // _selected=widget.selected;


                                                if (_selected != null) {
                                                  // _name.text = '';
                                                  // _name2.text = '';
                                                  msg = 'تم اضافة الابن بنجاح ';
                                                  color = Colors.green;

                                                  // Flushbar(
                                                  //   title:  "رائع",
                                                  //   message: "تم اضافة الابن بنجاح",
                                                  //   duration:  Duration(seconds: 3),
                                                  // )..show(context).then((value) {
                                                  //
                                                  //
                                                  // });






                                                  Future.delayed(
                                                      Duration(seconds: 3), () {

                                                    setState(() {
                                                      color = Colors.black;
                                                      _name.text = '';
                                                      _name2.text = '';
                                                      _name3.text = '';
                                                      _name4.text = '';
                                                      msg = '';
                                                    });
                                                  });
                                                } else {
                                                  Get.snackbar('خطا',
                                                      'تاكد من ادخال الاب بشكل سليم');
                                                }
                                              });
                                            } else {
                                              setState(() {
                                                msg = ' حدد العائلة بشكل سليم ';
                                                color = Colors.red;
                                              });
                                            }
                                          },
                                          child: Text(
                                            ' اضافة ',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          "اضغط اضافة كل ابن  بشكل منفصل حتى يتم اضافة البيانات بشكل سليم  ",
                                          style: TextStyle(
                                              fontSize: 13, color: Colors.red),
                                        ),
                                        Text(
                                          msg,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: color),
                                        ),
                                        SizedBox(height: 5),
                                        Container(
                                          child: RaisedButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomePage()),
                                                      (Route<dynamic> route) =>
                                                          false);
                                            },
                                            color: Colors.greenAccent,
                                            child: Text(
                                              "انتقل للرئيسية",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Divider(
                                      height: 10,
                                      color: Colors.black,
                                      thickness: 0.5,
                                    ),
                                    SizedBox(height: 20)
                                  ],
                                ),

                              // //column2
                              // Column(
                              //   children: [
                              //     Padding(
                              //       padding: const EdgeInsets.all(8.0),
                              //       child: TextFormField(
                              //         decoration: const InputDecoration(
                              //           border: OutlineInputBorder(),
                              //           icon: Icon(Icons.person),
                              //           hintText: ' الاسم ',
                              //           labelText: 'الابن / الابنة',
                              //         ),
                              //         controller: _name10,
                              //         validator: (value) {
                              //           if (value.isEmpty) {
                              //             return 'ادخل البيانات بشكل صحيح ';
                              //           }
                              //           return null;
                              //         },
                              //       ),
                              //     ),
                              //     Padding(padding: EdgeInsets.all(10)),
                              //     Padding(
                              //       padding: EdgeInsets.all(10),
                              //     ),
                              //     married == true
                              //         ? Column(
                              //       children: [
                              //         TextFormField(
                              //           decoration:
                              //           const InputDecoration(
                              //             border: OutlineInputBorder(),
                              //             icon: Icon(Icons.person),
                              //             hintText:
                              //             'ادخل اسم الزوج/ الزوجة',
                              //             labelText: 'الزوج / الزوجة',
                              //           ),
                              //           controller: _name20,
                              //           validator: (value) {
                              //             if (value.isEmpty) {
                              //               return 'ادخل البيانات بشكل صحيح';
                              //             }
                              //             return null;
                              //           },
                              //         ),
                              //         SizedBox(height: 10),
                              //         InkWell(
                              //           child: Row(
                              //             children: [
                              //               SizedBox(width: 60),
                              //               Text("اضف زوجة اخري"),
                              //               SizedBox(width: 20),
                              //               InkWell(
                              //                   child: Icon(Icons.add),
                              //                   onTap: () {
                              //                     setState(() {
                              //                       married2 = true;
                              //                     });
                              //                   }),
                              //             ],
                              //           ),
                              //           onTap: () {
                              //             setState(() {
                              //               married2 = true;
                              //             });
                              //           },
                              //         ),
                              //       ],
                              //     )
                              //         : Container(),
                              //     SizedBox(height: 10),
                              //     if (married2 == true)
                              //       Column(
                              //         children: [
                              //           TextFormField(
                              //             decoration: const InputDecoration(
                              //               border: OutlineInputBorder(),
                              //               icon: Icon(Icons.person),
                              //               hintText:
                              //               'ادخل اسم الزوج/ الزوجة',
                              //               labelText: 'الزوج / الزوجة',
                              //             ),
                              //             controller: _name30,
                              //             validator: (value) {
                              //               if (value.isEmpty) {
                              //                 return 'ادخل البيانات بشكل صحيح';
                              //               }
                              //               return null;
                              //             },
                              //           ),
                              //           SizedBox(height: 10),
                              //           InkWell(
                              //             child: Row(
                              //               children: [
                              //                 SizedBox(width: 60),
                              //                 Text("اضف زوجة اخري"),
                              //                 SizedBox(width: 20),
                              //                 InkWell(
                              //                     child: Icon(Icons.add),
                              //                     onTap: () {
                              //                       setState(() {
                              //                         married3 = true;
                              //                       });
                              //                     }),
                              //               ],
                              //             ),
                              //             onTap: () {
                              //               setState(() {
                              //                 married3 = true;
                              //               });
                              //             },
                              //           ),
                              //         ],
                              //       ),
                              //     SizedBox(height: 10),
                              //     if (married3 == true)
                              //       Column(
                              //         children: [
                              //           TextFormField(
                              //             decoration: const InputDecoration(
                              //               border: OutlineInputBorder(),
                              //               icon: Icon(Icons.person),
                              //               hintText:
                              //               'ادخل اسم الزوج/ الزوجة',
                              //               labelText: 'الزوج / الزوجة',
                              //             ),
                              //             controller: _name40,
                              //             validator: (value) {
                              //               if (value.isEmpty) {
                              //                 return 'ادخل البيانات بشكل صحيح';
                              //               }
                              //               return null;
                              //             },
                              //           ),
                              //           SizedBox(height: 10),
                              //         ],
                              //       ),
                              //     Padding(padding: EdgeInsets.all(10)),
                              //     Column(
                              //       children: [
                              //         Row(
                              //           mainAxisAlignment:
                              //           MainAxisAlignment.center,
                              //           children: [
                              //             //  SizedBox(width: 40,),
                              //             Text(
                              //               'متزوج',
                              //               style: TextStyle(
                              //                   fontWeight: FontWeight.bold),
                              //             ),
                              //             Checkbox(
                              //                 value: married,
                              //                 onChanged: (v) {
                              //                   setState(() {
                              //                     married = v;
                              //                   });
                              //                 }),
                              //           ],
                              //         ),
                              //         Row(
                              //           mainAxisAlignment:
                              //           MainAxisAlignment.center,
                              //           children: [
                              //             FutureBuilder(
                              //                 future:
                              //                 DBProvider.db.getFamilies(),
                              //                 builder: (context, ss) {
                              //                   if (ss.data == null) {
                              //                     return Container(
                              //                       child: Text(
                              //                         'لا توجد عائلات ',
                              //                         style: TextStyle(
                              //                             fontWeight:
                              //                             FontWeight
                              //                                 .bold),
                              //                       ),
                              //                     );
                              //                   } else {
                              //                     return Flexible(
                              //                       child: DropdownButton(
                              //                         value: _selected1,
                              //                         items: ss.data.map<
                              //                             DropdownMenuItem<
                              //                                 String>>((e) {
                              //                           String response =
                              //                           e['name'];
                              //                           return DropdownMenuItem(
                              //                             child: new Text(
                              //                                 response),
                              //                             value: response,
                              //                           );
                              //                         }).toList(),
                              //                         onChanged: (value) {
                              //                           setState(() {
                              //                             _selected1 = value;
                              //                             safe = true;
                              //                             safeNodeStatus(
                              //                                 value);
                              //                           });
                              //                           print(_selected1);
                              //                         },
                              //                       ),
                              //                     );
                              //                   }
                              //                 }),
                              //             SizedBox(
                              //               width: 30,
                              //             ),
                              //             Text(
                              //               'اختر العائلة',
                              //               style: TextStyle(
                              //                   fontWeight: FontWeight.bold),
                              //             ),
                              //           ],
                              //         ),
                              //         Padding(padding: EdgeInsets.all(10)),
                              //         // married == true
                              //         //     ?
                              //         Padding(
                              //           padding:
                              //           const EdgeInsets.only(top: 15.0),
                              //           child: Row(
                              //             mainAxisAlignment:
                              //             MainAxisAlignment.center,
                              //             children: [
                              //               FutureBuilder(
                              //                   future: safe == true
                              //                       ? DBProvider.db
                              //                       .getMembers(
                              //                       _selected1)
                              //                       : null,
                              //                   builder: (context, ss) {
                              //                     if (ss.data == null) {
                              //                       return Container(
                              //                         child: Text(
                              //                           'لا توجد بيانات حتي الان',
                              //                           style: TextStyle(
                              //                               fontWeight:
                              //                               FontWeight
                              //                                   .bold),
                              //                         ),
                              //                       );
                              //                     }
                              //                     else {
                              //                       var data =
                              //                       List.from(ss.data)
                              //                         ..removeAt(0);
                              //                       return Flexible(
                              //                         child: DropdownButton(
                              //                           value: _selected,
                              //                           items:
                              //                           data.map<
                              //                               DropdownMenuItem<int>>((e)
                              //                           {
                              //                             TreeMember
                              //                             treemember =
                              //                             TreeMember
                              //                                 .fromJson(e);
                              //                             return DropdownMenuItem(
                              //                               child: new Text(
                              //                                   treemember
                              //                                       .name
                              //                                       .toString()
                              //                               ),
                              //                               value: treemember.id,
                              //                             );
                              //                           }).toList(),
                              //                           onChanged: (value) {
                              //                             setState(() {
                              //                               _selected = value;
                              //                             });
                              //                             print(_selected);
                              //                           },
                              //                         ),
                              //                       );
                              //                     }
                              //                   }),
                              //               SizedBox(
                              //                 width: 30,
                              //               ),
                              //               Text(
                              //                 ' الاب لهذا الابن  ',
                              //                 style: TextStyle(
                              //                     fontWeight:
                              //                     FontWeight.bold),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //         // : Container(),
                              //         Padding(padding: EdgeInsets.all(10)),
                              //         ElevatedButton(
                              //           onPressed: () {
                              //             if (_formKey.currentState
                              //                 .validate())
                              //               // _selected1 != null &&
                              //               // (_selected != null ||
                              //               //     _selected == null))
                              //
                              //                 {
                              //               if (married == false) {
                              //                 checkName(
                              //                     _selected1,
                              //                     _name.text
                              //                         .toLowerCase()
                              //                         .trim());
                              //                 Future.delayed(
                              //                     Duration(seconds: 3), () {
                              //                   dialog == true
                              //                       ? showDialog(
                              //                     context: context,
                              //                     builder: (context) =>
                              //                         AlertDialog(
                              //                           title: Text(
                              //                             "Alert",
                              //                             style: TextStyle(
                              //                                 fontWeight:
                              //                                 FontWeight
                              //                                     .bold),
                              //                           ),
                              //                           content: Text(
                              //                             "${_name.text.toLowerCase().trim()} already exists!",
                              //                             style: TextStyle(
                              //                                 fontWeight:
                              //                                 FontWeight
                              //                                     .bold),
                              //                           ),
                              //                           actions: [
                              //                             // ignore: deprecated_member_use
                              //                             RaisedButton(
                              //                                 child: Text(
                              //                                   "رجوع ",
                              //                                   style: TextStyle(
                              //                                       fontWeight:
                              //                                       FontWeight.bold),
                              //                                 ),
                              //                                 onPressed:
                              //                                     () {
                              //                                   Navigator.pop(
                              //                                       context);
                              //                                 }),
                              //                             RaisedButton(
                              //                                 child: Text(
                              //                                   "ادخل",
                              //                                   style: TextStyle(
                              //                                       fontWeight:
                              //                                       FontWeight.bold),
                              //                                 ),
                              //                                 onPressed:
                              //                                     () {
                              //                                   DBProvider
                              //                                       .db
                              //                                       .insertMember(
                              //                                       TreeMember(
                              //                                           _name
                              //                                               .text
                              //                                               .toLowerCase()
                              //                                               .trim(),
                              //                                           //  widget.family
                              //                                           _selected
                              //                                       ),
                              //                                       // widget
                              //                                       //     .family,
                              //
                              //                                       _selected1
                              //                                   );
                              //                                   // Get.snackbar('تم',  'تم اضافة البيانات بنجاح');
                              //                                   // Navigator.of(
                              //                                   //         context)
                              //                                   //     .push(
                              //                                   //         MaterialPageRoute(builder: (context) => LoadTree()));
                              //                                   // Navigator.pop(context);
                              //                                 })
                              //                           ],
                              //                         ),
                              //                   )
                              //                       : safeNode == false
                              //                       ? DBProvider.db
                              //                       .insertMember(
                              //                       TreeMember(
                              //                           _name.text
                              //                               .toLowerCase()
                              //                               .trim(),
                              //                           1),
                              //                       _selected1)
                              //                       : DBProvider.db
                              //                       .insertMember(
                              //                       TreeMember(
                              //                           _name
                              //                               .text
                              //                               .toLowerCase()
                              //                               .trim(),
                              //                           //widget.family
                              //                           _selected
                              //
                              //                       ),
                              //                       _selected1
                              //                   );
                              //                 });
                              //               } else if (married == true) {
                              //                 if (married3 == true) {
                              //                   res =
                              //                   "${_name.text.toLowerCase().trim()} * ${_name2.text.toLowerCase().trim()} * ${_name3.text.toLowerCase().trim()} * ${_name4.text.toLowerCase().trim()}";
                              //                   checkName(_selected1, res);
                              //                 }
                              //                 if (married2 == false) {
                              //                   res =
                              //                   "${_name.text.toLowerCase().trim()} * ${_name2.text.toLowerCase().trim()}";
                              //                   checkName(_selected1, res);
                              //                 }
                              //
                              //                 if (married2 == true) {
                              //                   res =
                              //                   "${_name.text.toLowerCase().trim()} * ${_name2.text.toLowerCase().trim()} * ${_name3.text.toLowerCase().trim()}";
                              //                   checkName(_selected1, res);
                              //                 }
                              //
                              //                 checkName(_selected1, res);
                              //                 Future.delayed(
                              //                     Duration(seconds: 3), () async {
                              //                   dialog == true
                              //                       ? showDialog(
                              //                     context: context,
                              //                     builder: (context) =>
                              //                         AlertDialog(
                              //                           title: Text(
                              //                             "!!!!!",
                              //                             style: TextStyle(
                              //                                 fontWeight:
                              //                                 FontWeight
                              //                                     .bold),
                              //                           ),
                              //                           content: Text(
                              //                             "موجود مسبقا",
                              //                             style: TextStyle(
                              //                                 fontWeight:
                              //                                 FontWeight
                              //                                     .bold),
                              //                           ),
                              //                           actions: [
                              //                             RaisedButton(
                              //                                 child: Text(
                              //                                   "رجوع",
                              //                                   style: TextStyle(
                              //                                       fontWeight:
                              //                                       FontWeight.bold),
                              //                                 ),
                              //                                 onPressed:
                              //                                     () {
                              //                                   Navigator.pop(
                              //                                       context);
                              //                                 }),
                              //                             RaisedButton(
                              //                                 child: Text(
                              //                                   "ادخل",
                              //                                   style: TextStyle(
                              //                                       fontWeight:
                              //                                       FontWeight.bold),
                              //                                 ),
                              //
                              //                                 onPressed:
                              //                                     ()  async {
                              //
                              //                                   await DBProvider.db.insertMember(
                              //                                       TreeMember(
                              //                                           res,
                              //                                           //  widget.family
                              //                                           _selected
                              //
                              //                                       ),
                              //                                       _selected1
                              //                                   );
                              //                                 })
                              //                           ],
                              //                         ),
                              //                   )
                              //                       : safeNode == false
                              //                       ?  DBProvider.db
                              //                       .insertMember(
                              //                       TreeMember(
                              //                           res, 1),
                              //                       _selected1)
                              //                       :  DBProvider.db
                              //                       .insertMember(
                              //                       TreeMember(
                              //                           res,
                              //                           _selected
                              //                         //  widget.family
                              //                       ),
                              //                       _selected1);
                              //
                              //
                              //                 });
                              //               }
                              //               setState(() {
                              //                 if (_selected != null) {
                              //                   // _name.text = '';
                              //                   // _name2.text = '';
                              //                   msg = 'تم اضافة الابن بنجاح ';
                              //                   color = Colors.green;
                              //
                              //
                              //
                              //                   // Flushbar(
                              //                   //   title:  "رائع",
                              //                   //   message: "تم اضافة الابن بنجاح",
                              //                   //   duration:  Duration(seconds: 3),
                              //                   // )..show(context).then((value) {
                              //                   //
                              //                   //
                              //                   // });
                              //
                              //
                              //
                              //
                              //
                              //
                              //                   Future.delayed(
                              //                       Duration(seconds: 3), () {
                              //
                              //                     setState(() {
                              //                       color = Colors.black;
                              //                       _name.text = '';
                              //                       _name2.text = '';
                              //                       _name3.text = '';
                              //                       _name4.text = '';
                              //                       msg = '';
                              //                     });
                              //                   });
                              //                 } else {
                              //                   Get.snackbar('خطا',
                              //                       'تاكد من ادخال الاب بشكل سليم');
                              //                 }
                              //               });
                              //             } else {
                              //               setState(() {
                              //                 msg = ' حدد العائلة بشكل سليم ';
                              //                 color = Colors.red;
                              //               });
                              //             }
                              //           },
                              //           child: Text(
                              //             ' اضافة ',
                              //             style: TextStyle(
                              //                 color: Colors.white,
                              //                 fontWeight: FontWeight.bold),
                              //           ),
                              //         ),
                              //         Text(
                              //           "اضغط اضافة كل ابن  بشكل منفصل حتي يتم اضافة البيانات بشكل سليم  ",
                              //           style: TextStyle(
                              //               fontSize: 13, color: Colors.red),
                              //         ),
                              //         Text(
                              //           msg,
                              //           style: TextStyle(
                              //               fontWeight: FontWeight.bold,
                              //               color: color),
                              //         ),
                              //         SizedBox(height: 5),
                              //         Container(
                              //           child: RaisedButton(
                              //             onPressed: () {
                              //               Navigator.of(context)
                              //                   .pushAndRemoveUntil(
                              //                   MaterialPageRoute(
                              //                       builder: (context) =>
                              //                           HomePage()),
                              //                       (Route<dynamic> route) =>
                              //                   false);
                              //             },
                              //             color: Colors.greenAccent,
                              //             child: Text(
                              //               "انتقل للرئيسية",
                              //               style: TextStyle(
                              //                   color: Colors.white),
                              //             ),
                              //           ),
                              //         )
                              //       ],
                              //     ),
                              //     Divider(
                              //       height: 10,
                              //       color: Colors.black,
                              //       thickness: 0.5,
                              //     ),
                              //     SizedBox(height: 20)
                              //   ],
                              // ),




                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
