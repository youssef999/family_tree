import 'package:family_tree/database/database.dart';
import 'package:family_tree/models/treemember.dart';
import 'package:family_tree/pages/results_screen.dart';
import 'package:family_tree/resources/colorManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:family_tree/tools/string_extension.dart';
import 'homepage.dart';

class UpdatePage extends StatefulWidget {
  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  String _selected1;
  bool show = false;

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> getdata() async {
    setState(() {});
    refreshKey.currentState.show();
    Future.delayed(Duration(seconds: 3));
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.primary2,
          title: Text(
            "شجرة العائلة",
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Container(
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 40,
                      ),
                      Container(
                        width: 100,
                        child: ElevatedButton(
                            child: Text(
                              'النتائج ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ResultsScreen(
                                        _selected1,
                                      )));

                              // setState(() {
                              //   if (_selected1 != null) {
                              //     show = true;
                              //   }
                              // });
                            }),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      FutureBuilder(
                          future: DBProvider.db.getFamilies(),
                          builder: (context, ss) {
                            if (ss.data == null) {
                              return Container(
                                child: Text(
                                  'لا بيانات ',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              );
                            } else {
                              return Flexible(
                                child: DropdownButton(
                                  value: _selected1,
                                  items: ss.data
                                      .map<DropdownMenuItem<String>>((e) {
                                    String response = e['name'];
                                    return DropdownMenuItem(
                                      child: new Text(response),
                                      value: response,
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selected1 = value;
                                    });
                                  },
                                ),
                              );
                            }
                          }),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        ' اختر العائلة  ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                RefreshIndicator(
                  key: refreshKey,
                  onRefresh: () => getdata(),
                  child: show == true
                      ? FutureBuilder(
                          future: DBProvider.db.getMembers(_selected1),
                          builder: (context, ss) {
                            if (ss.connectionState == ConnectionState.waiting &&
                                !ss.hasData) {
                              return Container(
                                child: Text(
                                  'لا بيانات',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              );
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.people),
                                          Text(
                                            treemember.name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            children: [
                                              RaisedButton(
                                                child: Text(
                                                  "تحديث",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.green),
                                                ),
                                                onPressed: () {

                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Update(
                                                                table:
                                                                    _selected1,
                                                                treeMember:
                                                                    treemember,
                                                              )));
                                                },
                                              ),
                                              Spacer(),
                                              RaisedButton(
                                                child: Text(
                                                  "حذف",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                                treemember, _selected1);
                                                          },
                                                          child: Container(
                                                            color: Colors.green,
                                                            padding: const EdgeInsets.all(14),
                                                            child: const Text("نعم "),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(ctx).pop();
                                                          },
                                                          child: Container(
                                                            color: Colors.green,
                                                            padding: const EdgeInsets.all(14),
                                                            child: const Text("لا"),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );

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
                      : Container(),
                ),
              ],
            ),
          ),
        ));
  }
}

class Update extends StatefulWidget {
  final TreeMember treeMember;
  final table;

  Update({this.treeMember, this.table});

  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _name1 = TextEditingController();
  TextEditingController _name2 = TextEditingController();
  TextEditingController _name3 = TextEditingController();
  TextEditingController _name4 = TextEditingController();
  int _child;
  String table, msg = '';
  Color color = Colors.green;
  TreeMember treeMember;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    table = widget.table;
    treeMember = widget.treeMember;
    _child = widget.treeMember.c;

    if (treeMember.name.split(" * ").length == 2) {
      _name1.text = treeMember.name.split(" * ")[0].capitalizeFirstofEach;
      _name2.text = treeMember.name.split(" * ")[1].capitalizeFirstofEach;
    } else {
      _name1.text = treeMember.name;
    }
  }

  bool married = false;
   bool married2 = false;
    bool married3 = false;

  @override
  Widget build(BuildContext context) {
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
          Container(
            alignment: Alignment(0, 0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
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
            child: Container(
              color: Colors.white,
              height: 700,
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      treeMember.name.split(" * ").length == 2
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  icon: Icon(Icons.person),
                                  hintText: 'الاسم ',
                                  labelText: 'اسم الزوج ',
                                ),
                                controller: _name1,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'ادخل بيانات بشكل صحيح';
                                  }
                                  return null;
                                },
                                // inputFormatters: <TextInputFormatter>[
                                //     FilteringTextInputFormatter.allow(
                                //         RegExp("[a-zA-Z\u00C0-\u017F ]")),
                                //     FilteringTextInputFormatter.singleLineFormatter,
                                // ],
                              ),
                            )
                          : Container(),
                      treeMember.name.split(" * ").length == 2
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      icon: Icon(Icons.person),
                                      hintText: 'ادخل الاسم',
                                      labelText: 'اسم الزوجة ',
                                    ),
                                    controller: _name2,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'ادخل البيانات بشكل صحيح';
                                      }
                                      return null;
                                    },
                                    // inputFormatters: <TextInputFormatter>[
                                    //     FilteringTextInputFormatter.allow(
                                    //         RegExp("[a-zA-Z\u00C0-\u017F ]")),
                                    //     FilteringTextInputFormatter.singleLineFormatter,
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


                     if(married2==true)
                            Column(
                                children: [
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      icon: Icon(Icons.person),
                                      hintText: 'ادخل الاسم',
                                      labelText: 'اسم الزوجة ',
                                    ),
                                    controller: _name3,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'ادخل البيانات بشكل صحيح';
                                      }
                                      return null;
                                    },
                                    // inputFormatters: <TextInputFormatter>[
                                    //     FilteringTextInputFormatter.allow(
                                    //         RegExp("[a-zA-Z\u00C0-\u017F ]")),
                                    //     FilteringTextInputFormatter.singleLineFormatter,
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








 if(married3==true)
                            Column(
                                children: [
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      icon: Icon(Icons.person),
                                      hintText: 'ادخل الاسم',
                                      labelText: 'اسم الزوجة ',
                                    ),
                                    controller: _name4,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'ادخل البيانات بشكل صحيح';
                                      }
                                      return null;
                                    },
                                    // inputFormatters: <TextInputFormatter>[
                                    //     FilteringTextInputFormatter.allow(
                                    //         RegExp("[a-zA-Z\u00C0-\u017F ]")),
                                    //     FilteringTextInputFormatter.singleLineFormatter,
                                    // ],
                                  ),

                           SizedBox(height: 10),
                          
                                ]),
                                ],
                               ) ],
                              ),
                            )
                          : Container(),
                      treeMember.name.split(" * ").length != 2
                          ? Column(
                              children: [
                                TextFormField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    icon: Icon(Icons.person),
                                    hintText: 'ادخل الاسم',
                                    labelText: 'الاسم',
                                  ),
                                  controller: _name1,
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
                                SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  child: Row(
                                    children: [
                                      SizedBox(width: 70),
                                      Icon(Icons.add),
                                      SizedBox(width: 20),
                                      Text("اضف زوجة")
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      married = true;
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            )
                          : Container(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          FutureBuilder(
                              future: DBProvider.db.getMembers(table),
                              builder: (context, ss) {
                                if (ss.data == null) {
                                  return Container(
                                    child: Text(
                                      'لا بيانات',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  );
                                } else {
                                  return Flexible(
                                    child: DropdownButton(
                                      value: _child,
                                      items: ss.data
                                          .map<DropdownMenuItem<int>>((e) {
                                        TreeMember treemember =
                                            TreeMember.fromJson(e);
                                        return DropdownMenuItem(
                                          child: new Text(
                                              treemember.name.toString()),
                                          value: treemember.id,
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _child = value;
                                        });
                                      },
                                    ),
                                  );
                                }
                              }),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'الاب ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      if (married == true)
                        TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            icon: Icon(Icons.person),
                            hintText: 'ادخل الاسم',
                            labelText: 'اسم الزوجة ',
                          ),
                          controller: _name2,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'ادخل البيانات بشكل صحيح';
                            }
                            return null;
                          },
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate() &&
                                _child != null) {

 if(married3==true){
                                    var res =
                                    "${_name1.text.toLowerCase().trim()} * ${_name2.text.toLowerCase().trim()} * ${_name3.text.toLowerCase().trim()} * ${_name4.text.toLowerCase().trim()}";
                                treeMember.name = res;
                                treeMember.c = _child;
                                DBProvider.db.updateMember(table, treeMember);
                                  }
                                  else if(married2==true){
                                    var res =
                                    "${_name1.text.toLowerCase().trim()} * ${_name2.text.toLowerCase().trim()} * ${_name3.text.toLowerCase().trim()}";
                                treeMember.name = res;
                                treeMember.c = _child;
                                DBProvider.db.updateMember(table, treeMember);
                                  }
                              else if (widget.treeMember.name.split(' * ').length ==
                                      2 ||
                                  married == true) {
                                var res =
                                    "${_name1.text.toLowerCase().trim()} * ${_name2.text.toLowerCase().trim()}";
                                treeMember.name = res;
                                treeMember.c = _child;
                                DBProvider.db.updateMember(table, treeMember);
                              } else {
                                treeMember.name = _name1.text;
                                treeMember.c = _child;
                                DBProvider.db.updateMember(table, treeMember);
                              }
                              setState(() {
                                msg = "تم التحديث ";
                              });
                              Future.delayed(Duration(seconds: 1), () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()),
                                    (Route<dynamic> route) => false);

                                setState(() {
                                  msg = "";
                                });
                              });
                            }
                          },
                          child: Text(
                            'تحديث',
                            style: TextStyle(fontSize: 19, color: Colors.white),
                          )),
                      Text(
                        msg,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: color),
                      ),
                    ],
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

class UpdateFamilies extends StatefulWidget {
  @override
  _UpdateFamiliesState createState() => _UpdateFamiliesState();
}

class _UpdateFamiliesState extends State<UpdateFamilies> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> getdata() async {
    //refreshKey.currentState.show();
    setState(() {});
    Future.delayed(
      Duration(seconds: 3),
    );
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary2,
        title: Text(
          "شجرة العائلة",
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
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
        child: RefreshIndicator(
          key: refreshKey,
          onRefresh: () => getdata(),
          child: Container(
              alignment: Alignment(0, -1),
              child: FutureBuilder(
                future: DBProvider.db.getFamilies(),
                builder: (context, ss) {
                  if (ss.data == null) {
                    return Container();
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: ss.data.length,
                        itemBuilder: (context, item) {
                          var data = ss.data[item]['name'];
                          return Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.people),
                                Text(
                                  data,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
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
                                                    NewDataFamily(
                                                      table: data,
                                                    )));
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
                                        DBProvider.db.deleteTable(data);

                                        Future.delayed(Duration(seconds: 1),
                                            () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomePage()));
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                  }
                },
              )),
        ),
      ),
    );
  }
}

class NewDataFamily extends StatefulWidget {
  final table;

  NewDataFamily({this.table});

  @override
  _NewDataFamilyState createState() => _NewDataFamilyState();
}

class _NewDataFamilyState extends State<NewDataFamily> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _name1 = TextEditingController();

  String table, msg = '';
  Color color = Colors.green;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    table = widget.table;
  }

  @override
  Widget build(BuildContext context) {
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
          Container(
            alignment: Alignment(0, 0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
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
            child: Container(
              color: Colors.white,
              height: 300,
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                          hintText: 'اسم العائلة',
                          labelText: 'اسم العائلة',
                        ),
                        controller: _name1,
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
                      ElevatedButton(
                          onPressed: () {
                            DBProvider.db.renameTable(
                                widget.table, _name1.text.toLowerCase().trim());
                            setState(() {
                              msg = "تم التحديث";
                            });
                            Future.delayed(Duration(seconds: 3), () {
                              setState(() {
                                msg = "";
                              });

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => HomePage()));
                            });
                          },
                          child: Text(
                            'تحديث',
                            style: TextStyle(color: Colors.white),
                          )),
                      Text(
                        msg,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: color),
                      ),
                    ],
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
