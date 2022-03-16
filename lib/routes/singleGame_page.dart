import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';
import 'package:provider/provider.dart';

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
  String description = 'Enter your review...';

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
          child: SingleChildScrollView(
            reverse: true,
            child: Align(
              alignment: Alignment.center,
              child: Column(
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
                            fit: BoxFit.none,
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
                        Text(
                          "Game: " + _currentGame.getSingleGame,
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .bodyText2
                              .override(
                                fontFamily: 'Poppins',
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 20,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
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
                                    width: MediaQuery.of(context).size.width,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Image.network(
                                                'https://picsum.photos/seed/700/600',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
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
                                            addedBy: snapshot.data['uploader'],
                                            description:
                                                snapshot.data['description'],
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
                                            child: CircularProgressIndicator());
                                      case ConnectionState.done:
                                        if (_currentUser.getToken != null) {
                                          return ListView.builder(
                                            //reverse: true,
                                            shrinkWrap: true,
                                            itemCount: _currentInfo
                                                .getReviewsIDs.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: SingleChildScrollView(
                                                  reverse: true,
                                                  child: ReviewCards(
                                                    reviewer: _currentInfo
                                                            .getReviewsMap[
                                                        _currentInfo
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
                                                ),
                                              );
                                            },
                                          );
                                        } else {
                                          return Text("Login to view reviews",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30));
                                        }
                                        break;
                                      default:
                                        return Text('done');
                                    }
                                  }),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Color(0xFF2FD398),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: AlignmentDirectional(0, -0.0),
                                child: SingleChildScrollView(
                                  reverse: true,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      MarkdownTextInput(
                                          (String value) => setState(
                                              () => description = value),
                                          description,
                                          controller: controller,
                                          maxLines: 5,
                                          actions: MarkdownType.values,
                                          label: 'Review'),
                                      Text(
                                        sliderValue.toString(),
                                        style: TextStyle(fontSize: 35),
                                      ),
                                      Slider(
                                        activeColor: Color(0xFF208DDD),
                                        inactiveColor: Color(0xFF673F3F),
                                        min: 1,
                                        max: 5,
                                        divisions: 4,
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
                                          color: FlutterFlowTheme.of(context)
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
                            ],
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
      ),
    );
  }
}
