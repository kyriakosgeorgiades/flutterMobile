import 'package:georgiadek_sem2_flutter/states/games.dart';
import 'package:georgiadek_sem2_flutter/states/user.dart';
import 'package:provider/provider.dart';

import '../custom_widgets/dynamicCards.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

class GamesWidget extends StatefulWidget {
  const GamesWidget({Key key}) : super(key: key);

  @override
  _GamesWidgetState createState() => _GamesWidgetState();
}

class _GamesWidgetState extends State<GamesWidget> {
  Future<dynamic> gamesFuture;
  void initState() {
    super.initState();

    gamesFuture = getGamesWidget(context);
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = true;
  bool isApiResponse = false;

  FlutterFlowIconButton getIconStatus(BuildContext context) {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    var jwt = _currentUser.getToken;
    print("status of jwt: ${jwt}");
    if (jwt != null) {
      return FlutterFlowIconButton(
        borderColor: Color.fromARGB(0, 202, 18, 18),
        borderRadius: 30,
        borderWidth: 1,
        buttonSize: 60,
        icon: Icon(
          Icons.login,
          color: Color.fromARGB(255, 252, 38, 0),
          size: 30,
        ),
        onPressed: () async {
          print('IconButton pressed test');
        },
      );
    } else {
      return FlutterFlowIconButton(
        borderColor: Color.fromARGB(0, 202, 18, 18),
        borderRadius: 30,
        borderWidth: 1,
        buttonSize: 60,
        icon: Icon(
          Icons.logout,
          color: Color.fromARGB(255, 0, 0, 0),
          size: 30,
        ),
        onPressed: () async {
          print('IconButton pressed test');
        },
      );
    }
  }

  getGamesWidget(BuildContext context) async {
    CurrentGames _currentGame =
        Provider.of<CurrentGames>(context, listen: false);
    await _currentGame.games();
    return _currentGame;
  }

  @override
  Widget build(BuildContext context) {
    CurrentGames _currentGame =
        Provider.of<CurrentGames>(context, listen: false);
    _currentGame.getGames;
    _currentGame.getGamesMap;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF42BEA5),
        automaticallyImplyLeading: false,
        title: Text(
          'Games',
          style: FlutterFlowTheme.of(context).title1,
        ),
        actions: [getIconStatus(context)],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.of(context).secondaryText,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('FloatingActionButton pressed ...');
        },
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        elevation: 8,
        child: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          fillColor: Color(0xFF42BEA5),
          icon: Icon(
            Icons.add,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () {
            print('IconButton pressed .dsdgs..');
          },
        ),
      ),
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
                      'Reviewed Games',
                      style: FlutterFlowTheme.of(context).bodyText2.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.of(context).primaryText,
                          ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                                child: Material(
                                  color: Colors.transparent,
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: FutureBuilder(
                                      future: gamesFuture,
                                      builder: (context, snapshot) {
                                        print("snapshot");
                                        print(snapshot.error);
                                        switch (snapshot.connectionState) {
                                          case ConnectionState.waiting:
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          case ConnectionState.done:
                                            return ListView.builder(
                                              itemCount:
                                                  _currentGame.getGames.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 10),
                                                  child: GameCard(
                                                      gameName: _currentGame
                                                              .getGamesMap[
                                                          _currentGame.getGames[
                                                              index]]['name'],
                                                      year: _currentGame
                                                          .getGamesMap[
                                                              _currentGame
                                                                  .getGames[index]]
                                                              ['year']
                                                          .toString(),
                                                      cover:
                                                          'assets/images/waves@2x.png'),
                                                );
                                              },
                                            );
                                          default:
                                            return Text('Done');
                                        }
                                      }),
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
            ],
          ),
        ),
      ),
    );
  }
}
