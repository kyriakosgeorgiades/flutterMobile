import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Publisher: ",
                      style: FlutterFlowTheme.of(context).bodyText1,
                    ),
                    Text(
                      publisher,
                      style: FlutterFlowTheme.of(context).subtitle2,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Year: ",
                    style: FlutterFlowTheme.of(context).bodyText1,
                  ),
                  Text(
                    year,
                    style: FlutterFlowTheme.of(context).subtitle2,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Uploaded: ",
                    style: FlutterFlowTheme.of(context).bodyText1,
                  ),
                  Text(
                    date,
                    style: FlutterFlowTheme.of(context).subtitle2,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Uploaded By : ",
                    style: FlutterFlowTheme.of(context).bodyText1,
                  ),
                  Text(
                    addedBy,
                    style: FlutterFlowTheme.of(context).subtitle2,
                  ),
                ],
              ),
              Text(
                'Description',
                style: FlutterFlowTheme.of(context).bodyText1,
              ),
              Container(
                color: Colors.grey,
                child: MarkdownBody(
                  data: description,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
