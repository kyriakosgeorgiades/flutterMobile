import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:georgiadek_sem2_flutter/states/games.dart';
import 'package:provider/provider.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';

class GameCard extends StatelessWidget {
  final String gameName;
  final String year;
  final String cover;
  final Uint8List filePath;

  GameCard({this.gameName, this.year, this.cover, this.filePath});

  @override
  Widget build(BuildContext context) {
    CurrentGames _currentGame =
        Provider.of<CurrentGames>(context, listen: false);
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 201, 82, 82),
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: Image.memory(
                filePath,
              ).image)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          Color.fromARGB(255, 255, 255, 255).withOpacity(0.3),
                      borderRadius: BorderRadius.all((Radius.circular(20))),
                    ),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        gameName,
                        style: FlutterFlowTheme.of(context).bodyText2.override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          Color.fromARGB(255, 255, 247, 247).withOpacity(0.3),
                      borderRadius: BorderRadius.all((Radius.circular(20))),
                    ),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        year,
                        style: FlutterFlowTheme.of(context).bodyText2.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 20,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.white,
                  size: 40,
                ),
                onPressed: () {
                  print('IconButton pressed ...');
                  print(gameName);
                  _currentGame.setSingleGame(gameName);
                  Navigator.of(context).pushNamed('/games/game');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
