import 'package:flutter/material.dart';
import 'package:georgiadek_sem2_flutter/flutter_flow/flutter_flow_theme.dart';
import 'package:georgiadek_sem2_flutter/states/games.dart';
import 'package:provider/provider.dart';

class GameInfo extends StatelessWidget {
  final String year;
  final String date;
  final String publisher;
  final String addedBy;
  final String description;

  GameInfo({
    this.year,
    this.date,
    this.publisher,
    this.addedBy,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    CurrentGames _currentGame =
        Provider.of<CurrentGames>(context, listen: false);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 145,
      decoration: BoxDecoration(
        color: Color(0xFF2FD398),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF551212),
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
              child: Text(
                "Publisher: " + publisher,
                style: FlutterFlowTheme.of(context).bodyText1,
              ),
            ),
            Text(
              "Year: " + year,
              style: FlutterFlowTheme.of(context).bodyText1,
            ),
            Text(
              "Date: " + date,
              style: FlutterFlowTheme.of(context).bodyText1,
            ),
            Text(
              "Uploaded By: " + addedBy,
              style: FlutterFlowTheme.of(context).bodyText1,
            ),
            Text(
              "Description: " + description,
              style: FlutterFlowTheme.of(context).bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
