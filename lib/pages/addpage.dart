// ignore_for_file: unrelated_type_equality_checks

import 'package:family_tree/pages/treeview.dart';
import 'package:family_tree/resources/colorManager.dart';
import 'package:flutter/material.dart';
import 'package:family_tree/database/database.dart';
import 'package:family_tree/models/treemember.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'addchildrens.dart';
import 'homepage.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _name2 = TextEditingController();

  TextEditingController _name3 = TextEditingController();
  TextEditingController _name4 = TextEditingController();
  TextEditingController _numChild = TextEditingController();
  bool checkBoxValue = false;
  int _selected;
  String _selected1;
  String _selected2;
  var res = '';
  bool safe = false,
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

  var data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            child: Container(
              // height: 1200,
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
                child: Container(
                  //height: 1100,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (married == false)
                            TextFormField(
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
                              // inputFormatters: <TextInputFormatter>[
                              //   FilteringTextInputFormatter.allow(
                              //       RegExp("[a-zA-Z\u00C0-\u017F ]")),
                              //   FilteringTextInputFormatter.singleLineFormatter,
                              // ],
                            ),
                          if (married == true)
                            TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                icon: Icon(Icons.person),
                                hintText: 'ادخل اسم الابن / الابنة ',
                                labelText: 'الابن او الابنة ',
                              ),
                              controller: _name,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'ادخل البيانات بشكل صحيح';
                                }
                                return null;
                              },
                              // inputFormatters: <TextInputFormatter>[
                              //   FilteringTextInputFormatter.allow(
                              //       RegExp("[a-zA-Z\u00C0-\u017F ]")),
                              //   FilteringTextInputFormatter.singleLineFormatter,
                              // ],
                            ),
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                          married == true
                              ? Column(
                                  children: [
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        icon: Icon(Icons.person),
                                        hintText: 'ادخل اسم الزوج/ الزوجة',
                                        labelText: 'الزوج / الزوجة',
                                      ),
                                      controller: _name2,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'ادخل البيانات بشكل صحيح';
                                        }
                                        return null;
                                      },
                                      // inputFormatters: <TextInputFormatter>[
                                      //   FilteringTextInputFormatter.allow(
                                      //       RegExp("[a-zA-Z\u00C0-\u017F ]")),
                                      //   FilteringTextInputFormatter
                                      //       .singleLineFormatter,
                                      // ],
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
                                    SizedBox(height: 10),
                                  ],
                                )
                              : Container(),
                          married2 == true && married == true
                              ? Column(
                                  children: [
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        icon: Icon(Icons.person),
                                        hintText: 'ادخل اسم الزوج/ الزوجة',
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
                                    SizedBox(height: 10),
                                  ],
                                )
                              : Container(),

                          married2 == true &&
                                  married == true &&
                                  married3 == true
                              ? Column(
                                  children: [
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        icon: Icon(Icons.person),
                                        hintText: 'ادخل اسم الزوج/ الزوجة',
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
                                )
                              : Container(),

                          Padding(padding: EdgeInsets.all(10)),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //  SizedBox(width: 40,),
                                  Text(
                                    'متزوج',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                              if (married == true)
                                Column(
                                  children: [
                                    if (checkBoxValue == false)
                                      Row(
                                        children: [
                                          SizedBox(width: 20),
                                          SizedBox(width: 120),
                                          DropdownButton(
                                            value: dropdownvalue,
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),
                                            items: items.map((int items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(items.toString()),
                                              );
                                            }).toList(),
                                            onChanged: (int newValue) {
                                              setState(() {
                                                dropdownvalue = newValue;
                                              });
                                            },
                                          ),
                                          Text("  عدد الاولاد    "),
                                          SizedBox(width: 20),
                                        ],
                                      ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(width:60,),
                                            Text('عدد الابناء اكبر من 10'),
                                            SizedBox(width:20,),
                                            Checkbox(
                                                value: checkBoxValue,
                                                activeColor: Colors.green,
                                                onChanged: (bool newValue) {
                                                  setState(() {
                                                    checkBoxValue = newValue;
                                                  });
                                                }),
                                            SizedBox(width:60,),

                                          ],
                                        ),
                                        SizedBox(height:20,),
                                        if (checkBoxValue == true)
                                          TextFormField(
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              icon: Icon(Icons.person),
                                              hintText: 'عدد الابناء',
                                              labelText: 'عدد الابناء',
                                            ),
                                            controller: _numChild,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'ادخل البيانات بشكل صحيح';
                                              }
                                              return null;
                                            },
                                          ),
                                      ],
                                    )
                                  ],
                                ),
                              Padding(padding: EdgeInsets.all(10)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FutureBuilder(
                                      future: DBProvider.db.getFamilies(),
                                      builder: (context, ss) {
                                        if (ss.data == null) {
                                          return Container(
                                            child: Text(
                                              'لا توجد عائلات ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          );
                                        } else {
                                          return Flexible(
                                            child: DropdownButton(
                                              value: _selected1,
                                              items: ss.data.map<
                                                      DropdownMenuItem<String>>(
                                                  (e) {
                                                String response = e['name'];
                                                return DropdownMenuItem(
                                                  child: new Text(response),
                                                  value: response,
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                FocusScopeNode currentFocus =
                                                    FocusScope.of(context);
                                                setState(() {
                                                  _selected1 = value;
                                                  safe = true;
                                                  safeNodeStatus(value);
                                                });
                                                print("RRRR===" +
                                                    _selected1.toString());
                                              },
                                            ),
                                          );
                                          //   return
                                          // Column(
                                          //     children: [
                                          //       if(checkBoxValue==false)
                                          //
                                          //
                                          //
                                          //       Checkbox(value: checkBoxValue,
                                          //           activeColor: Colors.green,
                                          //           onChanged:(bool newValue){
                                          //             setState(() {
                                          //               checkBoxValue = newValue;
                                          //             });
                                          //             Text('عدد الابناء اكبر من 10');
                                          //           }),
                                          //
                                          //          if( checkBoxValue ==true)
                                          //            TextFormField(
                                          //              decoration: const InputDecoration(
                                          //                border: OutlineInputBorder(),
                                          //                icon: Icon(Icons.person),
                                          //                hintText: 'عدد الابناء',
                                          //                labelText: 'عدد الابناء',
                                          //              ),
                                          //              controller: _numChild,
                                          //              validator: (value) {
                                          //                if (value.isEmpty) {
                                          //                  return 'ادخل البيانات بشكل صحيح';
                                          //                }
                                          //                return null;
                                          //              },
                                          //            ),
                                          //
                                          //
                                          //
                                          //
                                          //
                                          //
                                          //     ],
                                          //   );
                                        }
                                      }),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Text(
                                    'اختر العائلة',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              safeNode == true
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          FutureBuilder(
                                              future: safe == true
                                                  ? DBProvider.db
                                                      .getMembers(_selected1)
                                                  : null,
                                              builder: (context, ss) {
                                                if (ss.data == null) {
                                                  return Container(
                                                    child: Text(
                                                      'لا توجد بيانات حتى الان',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  );
                                                } else {
                                                  data = List.from(ss.data)
                                                    ..removeAt(0);
                                                  return Flexible(
                                                    child: DropdownButton(
                                                      value: _selected,
                                                      items: data.map<
                                                          DropdownMenuItem<
                                                              int>>((e) {
                                                        TreeMember treemember =
                                                            TreeMember.fromJson(
                                                                e);
                                                        return DropdownMenuItem(
                                                          child: new Text(
                                                              treemember.name
                                                                  .toString()),
                                                          value: treemember.id,
                                                        );
                                                      }).toList(),
                                                      onChanged: (value) {
                                                        print("e==" +
                                                            data.length
                                                                .toString());
                                                        setState(() {
                                                          _selected = value;
                                                          FocusScopeNode
                                                              currentFocus =
                                                              FocusScope.of(
                                                                  context);
                                                        });
                                                        print("SSS=" +
                                                            _selected
                                                                .toString());
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
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                          Padding(padding: EdgeInsets.all(10)),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate() &&
                                  _selected1 != null &&
                                  (_selected != null || _selected == null)) {
                                if (married == false) {
                                  checkName(_selected1,
                                      _name.text.toLowerCase().trim());
                                  Future.delayed(Duration(seconds: 3), () {
                                    dialog == true
                                        ? showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text(
                                                "Alert",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              content: Text(
                                                "${_name.text.toLowerCase().trim()} already exists!",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              actions: [
                                                RaisedButton(
                                                    child: Text(
                                                      "رجوع ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    }),
                                                RaisedButton(
                                                    child: Text(
                                                      "ادخل",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    onPressed: () {
                                                      DBProvider.db.insertMember(
                                                          TreeMember(
                                                              _name.text
                                                                  .toLowerCase()
                                                                  .trim(),
                                                              _selected),
                                                          _selected1);
                                                      // Get.snackbar('تم',  'تم اضافة البيانات بنجاح');
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  LoadTree()));
                                                      // Navigator.pop(context);
                                                    })
                                              ],
                                            ),
                                          )
                                        : Container();

                                    if (safeNode == false) {
                                      DBProvider.db.insertMember(
                                          TreeMember(
                                              _name.text.toLowerCase().trim(),
                                              1),
                                          _selected1);
                                    } else {
                                      DBProvider.db.insertMember(
                                          TreeMember(
                                              _name.text.toLowerCase().trim(),
                                              _selected),
                                          _selected1);
                                    }
                                  });
                                } else if (married == true) {
                                  if (married2 == false) {
                                    res =
                                        "${_name.text.toLowerCase().trim()} * ${_name2.text.toLowerCase().trim()}";
                                    checkName(_selected1, res);
                                  }

                                  if (married3 == true) {
                                    res =
                                        "${_name.text.toLowerCase().trim()} * ${_name2.text.toLowerCase().trim()} * ${_name3.text.toLowerCase().trim()} * ${_name4.text.toLowerCase().trim()}";
                                    checkName(_selected1, res);
                                  }

                                  if (married2 == true) {
                                    res =
                                        "${_name.text.toLowerCase().trim()} * ${_name2.text.toLowerCase().trim()} * ${_name3.text.toLowerCase().trim()}";
                                    checkName(_selected1, res);
                                  }

                                  Future.delayed(Duration(seconds: 3), () {
                                    // dialog == true
                                    //     ? showDialog(
                                    //         context: context,
                                    //         builder: (context) => AlertDialog(
                                    //           title: Text(
                                    //             "Alert",
                                    //             style: TextStyle(
                                    //                 fontWeight:
                                    //                     FontWeight.bold),
                                    //           ),
                                    //           content: Text(
                                    //             " already exists!",
                                    //             style: TextStyle(
                                    //                 fontWeight:
                                    //                     FontWeight.bold),
                                    //           ),
                                    //           actions: [
                                    //             RaisedButton(
                                    //                 child: Text(
                                    //                   "رجوع",
                                    //                   style: TextStyle(
                                    //                       fontWeight:
                                    //                           FontWeight.bold),
                                    //                 ),
                                    //                 onPressed: () {
                                    //                   Navigator.pop(context);
                                    //                 }),
                                    //             RaisedButton(
                                    //                 child: Text(
                                    //                   "ادخل",
                                    //                   style: TextStyle(
                                    //                       fontWeight:
                                    //                           FontWeight.bold),
                                    //                 ),
                                    //                 onPressed: () {
                                    //                   checked();
                                    //                   DBProvider.db
                                    //                       .insertMember(
                                    //                           TreeMember(res,
                                    //                               _selected),
                                    //                           _selected1);
                                    //                 })
                                    //           ],
                                    //         ),
                                    //       )
                                    //     : Container();

                                    if (safeNode == false) {
                                      checked();
                                      DBProvider.db.insertMember(
                                          TreeMember(res, 1), _selected1);

                                      //print( "DDDDBBB"+ DBProvider.db.getMembers(_selected1).name.toString());
                                    } else {
                                      checked();
                                      DBProvider.db.insertMember(
                                          TreeMember(res, _selected),
                                          _selected1);
                                      // print( "DDDDBBB"+ DBProvider.db.getMembers(_selected1).id.toString());
                                      // TreeMember(res, _selected),
                                      // _selected1);
                                    }
                                  });
                                }
                                setState(() {
                                  // if(_selected!=null){

                                  msg = 'تم اضافة الابن بنجاح ';
                                  color = Colors.red;
                                  Future.delayed(Duration(seconds: 2), () {
                                    // Navigator.of(context).pushAndRemoveUntil(
                                    //     MaterialPageRoute(
                                    //         builder: (context) => HomePage()),
                                    //     (Route<dynamic> route) => false);
                                    setState(() {
                                      msg = '';
                                      color = Colors.red;
                                    });
                                  });
                                  // }
                                  // else{
                                  //   Get.snackbar('خطا', 'تاكد من ادخال الاب بشكل سليم');
                                  // }
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
                            msg,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: color),
                          ),
                          if (dropdownvalue != 0 || checkBoxValue==true)
                            Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text("اضغط على اضافة قبل اضافة الابناء ",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20)),
                                SizedBox(
                                  height: 10,
                                ),
                                // ignore: deprecated_member_use
                                RaisedButton(
                                  color: ColorManager.primary,
                                  onPressed: () {


                                    if (_numChild.text == '') {

                                      Future.delayed(Duration(seconds: 3), () {
                                        print("LLL====="+ data.length.toString());
                                        int num=0;
                                        if(data.length==0){
                                          num=data.length+2;
                                        } else {
                                          num = data.length+2;
                                        }

                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddChildrens(
                                                      // parentname:  treemember.name.toString(),
                                                      //   parentId:  treemember.id,
                                                      parent: _name.text +
                                                          "*" +
                                                          _name2.text +
                                                          "*" +
                                                          _name3.text +
                                                          _name4.text,
                                                      //   family: _selected,
                                                      numChildren: dropdownvalue,
                                                      selected1: _selected1,
                                                      selected:num
                                                      //data.length + 1,
                                                      //_selected,
                                                      //  numChildren: 3,
                                                    )));
                                      });
                                    } else {
                                      print("LLL======="+ data.length.toString());
                                      int num=0;
                                      if(data.length==0){
                                        num=data.length+2;
                                      }else{
                                        num=data.length+2;
                                      }
                                      Future.delayed(Duration(seconds: 3), () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddChildrens(
                                                      parent: _name.text +
                                                          "*" +
                                                          _name2.text +
                                                          "*" +
                                                          _name3.text +
                                                          _name4.text,
                                                      numChildren: int.parse(
                                                          _numChild.text),
                                                      selected1: _selected1,
                                                      selected: num
                                                      //data.length + 1,
                                                    )));
                                      });
                                    }
                                  },
                                  child: Text("اضف الابناء",
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 17)),
                                ),
                              ],
                            ),
                          // ignore: deprecated_member_use
                          RaisedButton(
                            color: ColorManager.primary,
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => HomePage()));
                            },
                            child: Text("انتقل للرئيسية",
                                style: TextStyle(
                                    color: Colors.green, fontSize: 17)),
                          )
                        ],
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

  void checked() {
    if (married2 == false) {
      res =
          "${_name.text.toLowerCase().trim()} * ${_name2.text.toLowerCase().trim()}";
      checkName(_selected1, res);
    }

    if (married2 == true && married3 == false) {
      res =
          "${_name.text.toLowerCase().trim()} * ${_name2.text.toLowerCase().trim()} * ${_name3.text.toLowerCase().trim()}";
      checkName(_selected1, res);
    }

    if (married2 == true && married3 == true) {
      res =
          "${_name.text.toLowerCase().trim()} * ${_name2.text.toLowerCase().trim()} * ${_name3.text.toLowerCase().trim()} * ${_name4.text.toLowerCase().trim()}";
      checkName(_selected1, res);
    }
  }
}
