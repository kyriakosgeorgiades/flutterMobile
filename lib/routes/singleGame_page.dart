import 'dart:io';
import 'dart:typed_data';

import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';
import 'package:provider/provider.dart';

import '../apiCalls.dart';
import '../custom_widgets/loading.dart';
import '../custom_widgets/reviewCards.dart';
import '../custom_widgets/singleGameInfo.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import '../states/games.dart';
import '../states/singleGame.dart';
import '../states/user.dart';

class SingleGameVeiwWidget extends StatefulWidget {
  const SingleGameVeiwWidget({Key key}) : super(key: key);

  @override
  _SingleGameVeiwWidgetState createState() => _SingleGameVeiwWidgetState();
}

class _SingleGameVeiwWidgetState extends State<SingleGameVeiwWidget> {
  TextEditingController textController;
  TextEditingController controller = TextEditingController();
  Future<dynamic> infoFuture;
  Future<dynamic> reviewsFuture;
  double sliderValue;
  String description = '';
  bool isApiResponse = false;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    infoFuture = getInfo(context);
    reviewsFuture = getReviews(context);
    textController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getInfo(BuildContext context) async {
    CurrentSingle _currentInfo =
        Provider.of<CurrentSingle>(context, listen: false);
    CurrentGames _currentGame =
        Provider.of<CurrentGames>(context, listen: false);
    return await _currentInfo.singleGame(_currentGame.getSingleGame);
  }

  getReviews(BuildContext context) async {
    CurrentSingle _currentInfo =
        Provider.of<CurrentSingle>(context, listen: false);
    CurrentGames _currentGame =
        Provider.of<CurrentGames>(context, listen: false);
    return await _currentInfo.reviewsGame(_currentGame.getSingleGame);
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: reviewBuild(context),
      inAsyncCall: isApiResponse,
      opacity: 0.3,
    );
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  Widget reviewBuild(BuildContext context) {
    CurrentGames _currentGame =
        Provider.of<CurrentGames>(context, listen: false);
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    CurrentSingle _currentInfo =
        Provider.of<CurrentSingle>(context, listen: false);
    List<String> gamesList = _currentGame.getGames;
    final int indexGame = gamesList
        .indexWhere((value) => value.contains('${_currentGame.getSingleGame}'));
    List<Uint8List> pathsList = _currentGame.getBytes;
    final Uint8List filePath = pathsList[indexGame];

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF42BEA5),
        automaticallyImplyLeading: true,
        title: Text(
          'Reviews',
          style: FlutterFlowTheme.of(context).title1,
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.of(context).secondaryText,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Align(
            alignment: Alignment.center,
            child: ListView(
              shrinkWrap: true,
              reverse: true,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryText,
                            image: DecorationImage(
                              image: Image.asset(
                                'assets/images/waves@2x.png',
                              ).image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color(0xFF42BEA5),
                            ),
                            child: Text(
                              _currentGame.getSingleGame,
                              textAlign: TextAlign.center,
                              style:
                                  FlutterFlowTheme.of(context).title3.override(
                                        fontFamily: 'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 30,
                                      ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                      child: Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 8),
                                    child: Material(
                                      color: Colors.transparent,
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular((8.0)),
                                          child: Image.memory(
                                            filePath,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: FutureBuilder(
                                        future: infoFuture,
                                        builder: (context, snapshot) {
                                          switch (snapshot.connectionState) {
                                            case ConnectionState.waiting:
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            case ConnectionState.done:
                                              return GameInfo(
                                                year: snapshot.data['year']
                                                    .toString(),
                                                date: snapshot.data['date'],
                                                publisher:
                                                    snapshot.data['publisher'],
                                                addedBy:
                                                    snapshot.data['uploader'],
                                                description: snapshot
                                                    .data['description'],
                                              );
                                            default:
                                              return null;
                                          }
                                        }),
                                  ),
                                  FutureBuilder(
                                      future: reviewsFuture,
                                      builder: (context, snapshot) {
                                        switch (snapshot.connectionState) {
                                          case ConnectionState.waiting:
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          case ConnectionState.done:
                                            if (_currentUser.getToken != null) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: ListView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  reverse: true,
                                                  shrinkWrap: true,
                                                  itemCount: _currentInfo
                                                      .getReviewsIDs.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10),
                                                      child: ReviewCards(
                                                        reviewer: _currentInfo
                                                            .getReviewsMap[_currentInfo
                                                                .getReviewsIDs[
                                                            index]]['reviewer'],
                                                        rating: _currentInfo
                                                                .getReviewsMap[
                                                            _currentInfo
                                                                    .getReviewsIDs[
                                                                index]]['rating'],
                                                        date: _currentInfo
                                                                .getReviewsMap[
                                                            _currentInfo
                                                                    .getReviewsIDs[
                                                                index]]['date'],
                                                        description: _currentInfo
                                                                .getReviewsMap[
                                                            _currentInfo
                                                                    .getReviewsIDs[
                                                                index]]['review'],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            } else {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: FFButtonWidget(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pushNamed('/login');
                                                    },
                                                    text:
                                                        'Login to view reviews',
                                                    options: FFButtonOptions(
                                                      width: 200,
                                                      height: 40,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryColor,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .subtitle2
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                      borderSide: BorderSide(
                                                        color:
                                                            Colors.transparent,
                                                        width: 1,
                                                      ),
                                                      borderRadius: 12,
                                                    )),
                                              );
                                            }
                                            break;
                                          default:
                                            return Text('done');
                                        }
                                      }),
                                  _currentUser.getToken != null
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xFF2FD398),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            alignment:
                                                AlignmentDirectional(0, -0.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: MarkdownTextInput(
                                                      (String value) =>
                                                          print('test'),
                                                      description,
                                                      controller: controller,
                                                      maxLines: 5,
                                                      actions:
                                                          MarkdownType.values,
                                                      label: 'Review'),
                                                ),
                                                Text(
                                                  sliderValue == null
                                                      ? '1'
                                                      : sliderValue
                                                          .toStringAsFixed(0),
                                                  style:
                                                      TextStyle(fontSize: 35),
                                                ),
                                                Slider(
                                                  activeColor:
                                                      Color(0xFF208DDD),
                                                  inactiveColor:
                                                      Color(0xFF673F3F),
                                                  min: 1,
                                                  max: 5,
                                                  divisions: 4,
                                                  value: sliderValue ??= 1,
                                                  onChanged: (newValue) {
                                                    setState(() =>
                                                        sliderValue = newValue);
                                                  },
                                                ),
                                                FFButtonWidget(
                                                  onPressed: () {
                                                    print(
                                                        'Button prefssddsfssed ...');
                                                    List<String> missing = [];
                                                    Map<String, dynamic>
                                                        newReview = {};
                                                    newReview.addAll({
                                                      'userID':
                                                          _currentUser.getUid,
                                                      'rate':
                                                          sliderValue.round(),
                                                      'description':
                                                          controller.text,
                                                      'token':
                                                          _currentUser.getToken,
                                                    });

                                                    newReview
                                                        .forEach((key, value) {
                                                      if ((value == null ||
                                                          value == '')) {
                                                        missing.add(key);
                                                      }
                                                    });
                                                    if (missing.isNotEmpty) {
                                                      var stringList =
                                                          missing.join(", ");
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(SnackBar(
                                                              content: Text(
                                                                  "Missing ${stringList}"),
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          4)));
                                                    } else {
                                                      setState(() {
                                                        isApiResponse = true;
                                                      });
                                                      CallApi().postDataAuth(
                                                          newReview,
                                                          'games' +
                                                              '/' +
                                                              '${_currentGame.getSingleGame}' +
                                                              '/' +
                                                              'reviews');

                                                      Future.delayed(
                                                          Duration(seconds: 3),
                                                          () async {
                                                        setState(() {
                                                          isApiResponse = false;
                                                        });
                                                        await _currentInfo
                                                            .reviewsGame(
                                                                _currentGame
                                                                    .getSingleGame);
                                                        rebuildAllChildren(
                                                            context);
                                                      });
                                                    }
                                                  },
                                                  text: 'Sumbit Review',
                                                  options: FFButtonOptions(
                                                    width: 180,
                                                    height: 40,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryColor,
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .subtitle2
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                        ),
                                                    borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1,
                                                    ),
                                                    borderRadius: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FFButtonWidget(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pushNamed('/login');
                                              },
                                              text: 'Login to leave a review',
                                              options: FFButtonOptions(
                                                width: 200,
                                                height: 40,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryColor,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .subtitle2
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                        ),
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1,
                                                ),
                                                borderRadius: 12,
                                              )),
                                        )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ].reversed.toList(),
            ),
          ),
        ),
      ),
    );
  }
}
