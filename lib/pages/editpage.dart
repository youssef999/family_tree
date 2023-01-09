import 'package:family_tree/pages/updatepage.dart';
import 'package:family_tree/resources/colorManager.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(height: 20,),

            InkWell(
              child: Container(
                  width: 140,
                  height: 45,
                  child: Card(
                    child:
                    Center(
                      child: Text('الافراد',style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  )),
              onTap:(){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => UpdatePage()));

              },
            ),
            SizedBox(height: 20,),
            InkWell(
              child: Container(
                  width: 140,
                  height: 45,
                  child: Card(
                    child:
                    Center(
                      child: Text('العائلات',style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  )),
              onTap:(){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => UpdateFamilies()));

              },
            ),

          ],
        ),
      ),
    );
  }
}
