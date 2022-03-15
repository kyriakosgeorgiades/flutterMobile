import 'package:flutter/material.dart';
import 'package:georgiadek_sem2_flutter/states/games.dart';
import 'package:provider/provider.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';

class GameCard extends StatelessWidget {
  final String gameName;
  final String year;
  final cover;

  GameCard({
    this.gameName,
    this.year,
    this.cover,
  });

  @override
  Widget build(BuildContext context) {
    CurrentGames _currentGame =
        Provider.of<CurrentGames>(context, listen: false);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 201, 82, 82),
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: Image.asset(
            cover,
          ).image)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  gameName,
                  style: FlutterFlowTheme.of(context).bodyText2.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 16,
                      ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                  child: Text(
                    year,
                    style: FlutterFlowTheme.of(context).bodyText2.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 16,
                        ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30,
                  borderWidth: 1,
                  buttonSize: 60,
                  icon: Icon(
                    Icons.info_outline,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    print('IconButton pressed ...');
                    print(gameName);
                    _currentGame.setSingleGame(gameName);
                    Navigator.of(context).pushNamed('/games/game');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
