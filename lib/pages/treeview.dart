import 'dart:io';
import 'dart:typed_data';
import 'package:family_tree/database/database.dart';
import 'package:family_tree/models/treemember.dart';
import 'package:family_tree/resources/colorManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:graphview/GraphView.dart';
import 'package:family_tree/pages/getnodetext.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'addpage.dart';
import 'dart:ui' as ui;

class LoadTree extends StatefulWidget {
  @override
  _LoadTreeState createState() => _LoadTreeState();
}

class _LoadTreeState extends State<LoadTree> {
  String _selected1;

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
        alignment: Alignment(0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      child: Text(
                        'عرض شجرة العائلة ',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        setState(() {
                          if (_selected1 != null) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TreeViewPage(
                                      familyName: _selected1,
                                    )));
                          }
                        });
                      }),
                  SizedBox(
                    width: 20,
                  ),
                  FutureBuilder(
                      future: DBProvider.db.getFamilies(),
                      builder: (context, ss) {
                        if (ss.data == null) {
                          return Container(
                            child: Text(
                              "لا توجد عائلات حتى الان ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          );
                        } else {
                          return Flexible(
                            child: DropdownButton(
                              value: _selected1,
                              items: ss.data.map<DropdownMenuItem<String>>((e) {
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
                    'العائلة  ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TreeViewPage extends StatefulWidget {
  final String familyName;

  TreeViewPage({this.familyName});

  @override
  _GraphViewPageState createState() => _GraphViewPageState();
}

class _GraphViewPageState extends State<TreeViewPage> {
  final Graph graph = Graph();
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  List<Node> node = [];
  List<Edge> edge = [];
  List<Map> family = [];

  List<Node> generateNodes(List<Map> strings) {
    List<Node> list = [];

    for (int x = 0; x < strings.length; x++) {
      if (x == 0) {
        list.add(Node(
            GetNodeText(
              txt1: "Família ${strings[x]['name']}",
              treeMember: TreeMember.fromJson(strings[x]),
            ),
            key: Key("${strings[x]['id']}")));
      }
      list.add(Node(
          GetNodeText(
            txt1: strings[x]['name'],
            treeMember: TreeMember.fromJson(strings[x]),
          ),
          key: Key("${strings[x]['id']}")));
    }

    return list;
  }

  findChild(List list) {
    List<Edge> edge = [];
    for (var map1 in list) {
      for (var map in list) {
        if (map.containsKey("c")) {
          if (map["c"] == map1["id"]) {
            edge.add(Edge(graph.getNodeUsingKey(Key(map1['id'].toString())),
                graph.getNodeUsingKey(Key(map['id'].toString()))));
          }
        }
      }
    }
    return edge;
  }

  Uint8List _imageFile;
  ScreenshotController _screenshotController = ScreenshotController();
  GlobalKey previewContainer = new GlobalKey();
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
        actions: [
          InkWell(
            child: Padding(
                padding: const EdgeInsets.only(right: 14.0, top: 10),
                child: Icon(
                  Icons.share,
                  color: Colors.white,
                )),
            onTap: () async {
              // _captureSocialPng();
              _takeScreenShot();
            },
            //  },
          ),
        ],
      ),
      body:
          // RepaintBoundary(
          // key: previewContainer,
          Screenshot(
        controller: _screenshotController,
        child: Container(
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
          child: FutureBuilder(
            future: DBProvider.db.getMembers(widget.familyName),
            builder: (context, ss) {
              if (ss.data == null) {
                return Center(
                  child: Container(
                    alignment: Alignment(0, 0),
                    color: Colors.grey,
                    height: 400,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                );
              } else {
                family = ss.data;

                // Matrix4 matrix4 =
                //     Matrix4(2, 0, 6, 0, 0, 1, 0, 0, 0, 0, 4, 0, 0, 0, 0, 4);
                //     TransformationController controller = TransformationController(matrix4);

                node = generateNodes(family);
                graph.addNodes(node);
                edge = findChild(family);
                graph.addEdges(edge);
                builder
                  ..siblingSeparation = (10)
                  ..levelSeparation = (120)
                  ..subtreeSeparation = (130)
                  ..orientation =
                      (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: InteractiveViewer(
                        constrained: false,
                        scaleEnabled: true,
                        alignPanAxis: true,
                        onInteractionEnd: (ScaleEndDetails scaleEndDetails) {
                          print(
                              'Interaction End - Velocity: ${scaleEndDetails.velocity}');

                          // if (scaleUpdateDetails.localFocalPoint >=
                          //     Offset(234.9, 105.3)) {
                          //   print(",,,,,,,,,,,,FFFFFFFFF,,,,,,,,");

                          // } else {
                          //   print(",,,,,,,,,,,,XXXXXXXX,,,,,,,,");
                          // }

                          // builder
                          //   ..siblingSeparation = (40)
                          //   ..levelSeparation = (80)
                          //   ..subtreeSeparation = (15);
                        },
                        // transformationController: controller,
                        boundaryMargin: EdgeInsets.all(4400),
                        minScale: 0.05,
                        // maxScale: 5.6,
                        child: GraphView(
                          paint: Paint()
                            ..color = Colors.red
                            ..strokeWidth = 3
                            ..style = PaintingStyle.stroke,
                          graph: graph,
                          algorithm: BuchheimWalkerAlgorithm(
                            builder,
                            TreeEdgeRenderer(builder),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      child: CircleAvatar(
                          child: Icon(
                        Icons.add,
                        size: 30,
                        color: Colors.white,
                      )),
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => AddPage()));
                      },
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void _takeScreenShot() async {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;

    final imageFile =
        await _screenshotController.capture(pixelRatio: pixelRatio);

    print("img==" + imageFile.toString());
    // var result = await FlutterImageCompress.compressWithFile(
    //   imageFile.absolute.path,
    //   minWidth: 2300,
    //   minHeight: 1500,
    //   quality: 94,
    //   rotate: 90,
    // );
    // File f=File.fromRawPath(result);
    Share.shareFiles([imageFile.path], text: "Family Tree");
  }

  // Future<void> _captureSocialPng() {
  //
  //   List<String> imagePaths = [];
  //   final RenderBox box = context.findRenderObject() as RenderBox;
  //   return new Future.delayed(const Duration(milliseconds: 20), () async {
  //     RenderRepaintBoundary boundary = previewContainer.currentContext
  //         .findRenderObject() as RenderRepaintBoundary;
  //     ui.Image image = await boundary.toImage();
  //     final directory = (await getApplicationDocumentsDirectory()).path;
  //     ByteData byteData =
  //     await image.toByteData(format: ui.ImageByteFormat.png);
  //     Uint8List pngBytes = byteData.buffer.asUint8List();
  //     File imgFile = new File('$directory/screenshot.png');
  //     imagePaths.add(imgFile.path);
  //     imgFile.writeAsBytes(pngBytes).then((value) async {
  //       await Share.shareFiles(imagePaths,
  //           subject: 'Share',
  //           text: 'Check this Out!',
  //           sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  //     }).catchError((onError) {
  //       print(onError);
  //     });
  //   });
  // }
}
