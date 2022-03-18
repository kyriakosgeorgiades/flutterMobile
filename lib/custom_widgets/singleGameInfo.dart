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
            mainAxisSize: MainAxisSize.min,
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
                      style: FlutterFlowTheme.of(context)
                          .subtitle2
                          .override(fontFamily: 'Poppins', color: Colors.black),
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
                    style: FlutterFlowTheme.of(context)
                        .subtitle2
                        .override(fontFamily: 'Poppins', color: Colors.black),
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
                    style: FlutterFlowTheme.of(context)
                        .subtitle2
                        .override(fontFamily: 'Poppins', color: Colors.black),
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
                    style: FlutterFlowTheme.of(context)
                        .subtitle2
                        .override(fontFamily: 'Poppins', color: Colors.black),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Description',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color.fromARGB(255, 5, 26, 16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MarkdownBody(
                    data: description,
                    styleSheet: MarkdownStyleSheet(
                      a: const TextStyle(color: Colors.white),
                      p: const TextStyle(color: Colors.white),
                      h1: const TextStyle(color: Colors.white),
                      h2: const TextStyle(color: Colors.white),
                      h3: const TextStyle(color: Colors.white),
                      h4: const TextStyle(color: Colors.white),
                      h5: const TextStyle(color: Colors.white),
                      h6: const TextStyle(color: Colors.white),
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
