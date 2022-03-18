import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:georgiadek_sem2_flutter/states/games.dart';
import 'package:georgiadek_sem2_flutter/states/user.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart';

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
  bool flag = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = true;
  bool isApiResponse = false;
  AsyncMemoizer _memoizer;

  @override
  void initState() {
    super.initState();
    _memoizer = AsyncMemoizer();
  }

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
          _currentUser.removeToken();
          setState(() {});
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
          Navigator.of(context).pushNamed('/login');
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

  _fetchData() async {
    return this._memoizer.runOnce(() async {
      gamesFuture = getGamesWidget(context);
      await Future.delayed(Duration(seconds: 1));
      return gamesFuture;
    });
  }

  @override
  Widget build(BuildContext context) {
    CurrentGames _currentGame =
        Provider.of<CurrentGames>(context, listen: false);

    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

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
            if (_currentUser.getToken != null) {
              print('IconButton pressed .dsdgs..');
              Navigator.of(context).pushNamed('/addGame');
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Login to add a Game!"),
                  duration: Duration(seconds: 2)));
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF42BEA5),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'Reviewed Games',
                          style: FlutterFlowTheme.of(context)
                              .bodyText2
                              .override(
                                fontFamily: 'Poppins',
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 8),
                  child: Container(
                    child: Material(
                      color: Colors.transparent,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FutureBuilder(
                          future: _fetchData(), //_currentGame.games(),
                          builder: (context, snapshot) {
                            print("snapshot");
                            print(snapshot.error);
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return Center(
                                    child: CircularProgressIndicator());
                              case ConnectionState.done:
                                if (snapshot.hasData && !snapshot.hasError) {
                                  return ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: _currentGame.getGames.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: GameCard(
                                            gameName: _currentGame.getGamesMap[
                                                    _currentGame.getGames[index]]
                                                ['name'],
                                            year: _currentGame
                                                .getGamesMap[_currentGame.getGames[index]]
                                                    ['year']
                                                .toString(),
                                            cover: _currentGame.getGamesMap[
                                                    _currentGame.getGames[index]]
                                                ['cover'],
                                            filePath:
                                                _currentGame.getBytes[index]),
                                      );
                                    },
                                  );
                                } else {
                                  return Text('Done');
                                }
                                break;
                              default:
                                return Text('ok');
                                break;
                            }
                          }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
