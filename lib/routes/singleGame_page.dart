import 'package:georgiadek_sem2_flutter/custom_widgets/singleGameInfo.dart';
import 'package:georgiadek_sem2_flutter/states/user.dart';
import 'package:provider/provider.dart';

import '../custom_widgets/reviewCards.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import '../states/games.dart';
import '../states/singleGame.dart';

class SingleGameVeiwWidget extends StatefulWidget {
  const SingleGameVeiwWidget({Key key}) : super(key: key);

  @override
  _SingleGameVeiwWidgetState createState() => _SingleGameVeiwWidgetState();
}

class _SingleGameVeiwWidgetState extends State<SingleGameVeiwWidget> {
  Future<dynamic> infoFuture;
  Future<dynamic> reviewsFuture;
  TextEditingController textController;
  double sliderValue;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    infoFuture = getInfo(context);
    reviewsFuture = getReviews(context);
    textController = TextEditingController();
  }

  getInfo(BuildContext context) async {
    CurrentSingle _currentInfo =
        Provider.of<CurrentSingle>(context, listen: false);
    CurrentGames _currentGame =
        Provider.of<CurrentGames>(context, listen: false);
    print(" I HAVE THE NAME BEFORE RETURN");
    print(_currentGame.getSingleGame);
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
    CurrentGames _currentGame =
        Provider.of<CurrentGames>(context, listen: false);
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    CurrentSingle _currentInfo =
        Provider.of<CurrentSingle>(context, listen: false);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF42BEA5),
        automaticallyImplyLeading: false,
        title: Text(
          'Game Reviews',
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      _currentGame.getSingleGame,
                      style: FlutterFlowTheme.of(context).bodyText2.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 20,
                          ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                  child: Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                                child: Material(
                                  color: Colors.transparent,
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Expanded(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image.network(
                                                  'https://picsum.photos/seed/700/600',
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              FutureBuilder(
                                  future: infoFuture,
                                  builder: (context, snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.waiting:
                                        return Center(
                                            child: CircularProgressIndicator());
                                      case ConnectionState.done:
                                        return GameInfo(
                                          year:
                                              snapshot.data['year'].toString(),
                                          date: snapshot.data['date'],
                                          publisher: snapshot.data['publisher'],
                                          addedBy: snapshot.data['uploader'],
                                          description:
                                              snapshot.data['description'],
                                        );
                                      default:
                                        return null;
                                    }
                                  }),
                              FutureBuilder(
                                  future: reviewsFuture,
                                  builder: (context, snapshot) {
                                    switch (snapshot.connectionState) {
                                      case ConnectionState.waiting:
                                        return Center(
                                            child: CircularProgressIndicator());
                                      case ConnectionState.done:
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount:
                                              _currentInfo.getReviewsIDs.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: ReviewCards(
                                                reviewer: _currentInfo
                                                        .getReviewsMap[
                                                    _currentInfo.getReviewsIDs[
                                                        index]]['reviewer'],
                                                rating: _currentInfo
                                                        .getReviewsMap[
                                                    _currentInfo.getReviewsIDs[
                                                        index]]['rating'],
                                                date: _currentInfo
                                                        .getReviewsMap[
                                                    _currentInfo.getReviewsIDs[
                                                        index]]['date'],
                                                description: _currentInfo
                                                        .getReviewsMap[
                                                    _currentInfo.getReviewsIDs[
                                                        index]]['review'],
                                              ),
                                            );
                                          },
                                        );
                                      default:
                                        return Text('done');
                                    }
                                  }),
                              Expanded(
                                child: Form(
                                  key: formKey,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF2FD398),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    alignment: AlignmentDirectional(0, -0.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          TextFormField(
                                            controller: textController,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelText: 'Review',
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight:
                                                      Radius.circular(4.0),
                                                ),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(4.0),
                                                  topRight:
                                                      Radius.circular(4.0),
                                                ),
                                              ),
                                              filled: true,
                                              fillColor: Colors.black,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                ),
                                            textAlign: TextAlign.start,
                                            maxLines: 2,
                                            keyboardType:
                                                TextInputType.multiline,
                                          ),
                                          Slider(
                                            activeColor: Color(0xFF208DDD),
                                            inactiveColor: Color(0xFF673F3F),
                                            min: 1,
                                            max: 5,
                                            value: sliderValue ??= 1,
                                            onChanged: (newValue) {
                                              setState(
                                                  () => sliderValue = newValue);
                                            },
                                          ),
                                          FFButtonWidget(
                                            onPressed: () {
                                              print('Button pressed ...');
                                            },
                                            text: 'Sumbit Review',
                                            options: FFButtonOptions(
                                              width: 180,
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
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
    );
  }
}
