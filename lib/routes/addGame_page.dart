import 'dart:io';

import 'package:flutter/services.dart';
import 'package:georgiadek_sem2_flutter/states/games.dart';
import 'package:georgiadek_sem2_flutter/states/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';
import 'package:provider/provider.dart';

import '../custom_widgets/loading.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';

class AddGameWidget extends StatefulWidget {
  const AddGameWidget({Key key}) : super(key: key);

  @override
  _AddGameWidgetState createState() => _AddGameWidgetState();
}

class _AddGameWidgetState extends State<AddGameWidget> {
  TextEditingController name;
  TextEditingController publisher;
  TextEditingController description_;
  TextEditingController controller;
  double sliderValue;
  String description;
  String base64String;
  String fileName;
  bool isApiResponse = false;
  File image;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return null;
      String imagePath = image.path;
      fileName = imagePath.split('/').last;
      print("I AM THE FILE NAME LOL: $fileName");

      final imageTemporary = File(image.path);
      File imageFile = File(imagePath);
      Uint8List imageBytes = await imageFile.readAsBytes();
      base64String = base64.encode(imageBytes);

      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to get the image :$e');
    }
  }

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    publisher = TextEditingController();
    description_ = TextEditingController();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    name.dispose();
    publisher.dispose();
    description_.dispose();
    controller.dispose();
    super.dispose();
  }

  addGame(BuildContext context, Map<String, dynamic> data) async {
    CurrentGames _currentGame =
        Provider.of<CurrentGames>(context, listen: false);
    await _currentGame.addgame(data);
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: addingGame(context),
      inAsyncCall: isApiResponse,
      opacity: 0.3,
    );
  }

  Widget addingGame(BuildContext context) {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF42BEA5),
        automaticallyImplyLeading: false,
        title: Text(
          'Add a Game',
          style: FlutterFlowTheme.of(context).title1,
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.of(context).secondaryText,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryText,
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: Image.asset(
                        'assets/images/waves@2x.png',
                      ).image,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                              child: TextFormField(
                                controller: name,
                                obscureText: false,
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Game Name',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFF208DDD),
                                ),
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                              child: TextFormField(
                                controller: publisher,
                                obscureText: false,
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Publisher',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x00000000),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFF208DDD),
                                ),
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                            Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                                child: MarkdownTextInput(
                                    (String value) =>
                                        setState(() => description = value),
                                    description,
                                    controller: controller,
                                    maxLines: 5,
                                    actions: MarkdownType.values,
                                    label: 'Description')),
                            Align(
                              alignment: AlignmentDirectional(-0.95, 0),
                              child: Text(
                                'Year',
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                            Text(
                              sliderValue == null
                                  ? 'Loading'
                                  : sliderValue.toStringAsFixed(0),
                              style: TextStyle(fontSize: 35),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                              child: Slider(
                                activeColor:
                                    FlutterFlowTheme.of(context).primaryColor,
                                inactiveColor: Color(0xFF9E9E9E),
                                min: 1980,
                                max: 2022,
                                divisions: 42,
                                value: sliderValue ??= 2022,
                                onChanged: (newValue) {
                                  setState(() => sliderValue = newValue);
                                },
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(-0.95, 0),
                              child: Text(
                                'Cover',
                                style: FlutterFlowTheme.of(context).bodyText1,
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                              child: FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 181111111,
                                buttonSize: 60,
                                icon: Icon(
                                  Icons.picture_in_picture,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                onPressed: () {
                                  print('Gallery pressed ...');
                                  pickImage(ImageSource.gallery);
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                              child: FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 181111111,
                                buttonSize: 60,
                                icon: Icon(
                                  Icons.camera,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                onPressed: () {
                                  print('Camera pic ...');
                                  pickImage(ImageSource.camera);
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                              child: FFButtonWidget(
                                onPressed: () {
                                  List<String> missing = [];
                                  Map<String, dynamic> newGame = {};
                                  newGame.addAll({
                                    'name': name.text,
                                    'publisher': publisher.text,
                                    'description': controller.text,
                                    'year': sliderValue.round(),
                                    'user_id': _currentUser.getUid,
                                    'token': _currentUser.getToken,
                                    'fileName': fileName,
                                    'cover': base64String,
                                  });
                                  print("I am map");
                                  print(newGame);
                                  newGame.forEach((key, value) {
                                    if ((value == null || value == '') &&
                                        (value != 'fileName')) {
                                      missing.add(key);
                                    }
                                  });
                                  if (missing.isNotEmpty) {
                                    var stringList = missing.join(", ");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("Missing ${stringList}"),
                                            duration: Duration(seconds: 4)));
                                  } else {
                                    setState(() {
                                      isApiResponse = true;
                                    });
                                    addGame(context, newGame);

                                    Future.delayed(Duration(seconds: 1), () {
                                      setState(() {
                                        isApiResponse = false;
                                      });
                                      Navigator.pushNamed(context, '/games');
                                    });
                                  }
                                },
                                text: 'Sumbit Game',
                                options: FFButtonOptions(
                                  width: 200,
                                  height: 50,
                                  color:
                                      FlutterFlowTheme.of(context).primaryColor,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .subtitle2
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                      ),
                                  elevation: 2,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
