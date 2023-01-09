import 'package:family_tree/resources/colorManager.dart';
import 'package:flutter/material.dart';
import 'package:family_tree/database/database.dart';
import 'package:family_tree/models/treemember.dart';
import 'package:flutter/services.dart';

import 'homepage.dart';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  String _msg = '';
  Color color;

  _start() async {

    String name = _name.text.toLowerCase().replaceAll(" ", "");

    var table = await DBProvider.db.checkIfTableExists(name);


    if (table == false) {
      DBProvider.db.createNewTable(
        name,
        TreeMember(name, null, 1),
      );
      setState(() {
        _msg = "تم اضافة عائلة جديدة ";
        color = Colors.black;
      });
    }
    else {
      print('Exists');
      setState(() {
        _msg = "سبق ادخال هذا الاسم ";
        color = Colors.red;
      });
    }
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _msg = "";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.primary2,
        title: Text("شجرة العائلة",style:TextStyle(
            fontSize: 22,
            color: Colors.white
        ),),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Container(
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
            padding: EdgeInsets.all(50),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("ادخل الاسم الرئيسي فقط بدون مسافات",
                    style: TextStyle(
                      color:Colors.black,fontSize: 16
                    ),
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        icon: Icon(Icons.person),
                        hintText: 'اسم العائلة ',
                        labelText: 'الاسم ',
                      ),
                      controller: _name,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'ادخل البيانات بشكل صحيح ';
                        }
                        return null;
                      },
                
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),

                    ElevatedButton(
                      onPressed: () async{
                      
                        if (_formKey.currentState.validate()) {
                         await _start();

                          Future.delayed(Duration(seconds: 2), () {
                            Navigator.of(context).
                            pushReplacement(MaterialPageRoute(builder: (context) =>
                                HomePage()));
                          });




                        }
                      },
                      child: Text(
                        'اضافة',
                        style: TextStyle(
                            color:Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      _msg,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, color: color),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
