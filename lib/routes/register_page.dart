import 'package:provider/provider.dart';

import '../custom_widgets/loading.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import '../states/user.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key key}) : super(key: key);

  @override
  _RegisterWidgetState createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  TextEditingController textController1;
  TextEditingController textController2;
  bool passwordVisibility1;
  TextEditingController textController3;
  bool passwordVisibility2;
  bool isApiResponse = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    passwordVisibility1 = false;
    textController3 = TextEditingController();
    passwordVisibility2 = false;
  }

  registerUser(String username, String password, BuildContext context) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    try {
      if (await _currentUser.registerUser(username, password)) {
        // Navigator.of(context).pushNamed('/games');
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/games', (Route<dynamic> route) => false);
      } else {
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("User already exists"),
            duration: Duration(seconds: 2)));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: registerBuild(context),
      inAsyncCall: isApiResponse,
      opacity: 0.3,
    );
  }

  @override
  Widget registerBuild(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryText,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 201,
                  decoration: BoxDecoration(
                    color: Color(0xFF208DDD),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: Image.asset(
                        'assets/images/Kyriakos.png',
                      ).image,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 24),
                        child: SingleChildScrollView(
                          reverse: true,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              TextFormField(
                                controller: textController1,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Username',
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
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                child: TextFormField(
                                  controller: textController2,
                                  obscureText: !passwordVisibility1,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    hintText: 'Enter your password',
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
                                    suffixIcon: InkWell(
                                      onTap: () => setState(
                                        () => passwordVisibility1 =
                                            !passwordVisibility1,
                                      ),
                                      child: Icon(
                                        passwordVisibility1
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: Color(0xFF757575),
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                child: TextFormField(
                                  controller: textController3,
                                  obscureText: !passwordVisibility2,
                                  decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    hintText: 'Enter your password',
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
                                    suffixIcon: InkWell(
                                      onTap: () => setState(
                                        () => passwordVisibility2 =
                                            !passwordVisibility2,
                                      ),
                                      child: Icon(
                                        passwordVisibility2
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: Color(0xFF757575),
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.of(context).bodyText1,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                                child: FFButtonWidget(
                                  onPressed: () {
                                    print("TEXT");
                                    print(textController1.text);
                                    if (textController1.text == '' ||
                                        textController2.text == '' ||
                                        textController3.text == '') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text("Fill all inputs"),
                                              duration: Duration(seconds: 2)));
                                    } else if (textController2.text !=
                                        textController3.text) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Passwords do not match"),
                                              duration: Duration(seconds: 2)));
                                    } else {
                                      setState(() {
                                        isApiResponse = true;
                                      });
                                      registerUser(textController1.text,
                                          textController2.text, context);
                                      setState(() {
                                        isApiResponse = false;
                                      });
                                    }
                                    print('Button pressed ...');
                                  },
                                  text: 'Register',
                                  options: FFButtonOptions(
                                    width: 200,
                                    height: 50,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryColor,
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
