import 'package:flutter/material.dart';
import 'package:georgiadek_sem2_flutter/flutter_flow/flutter_flow_theme.dart';
import 'package:georgiadek_sem2_flutter/states/games.dart';
import 'package:provider/provider.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ReviewCards extends StatelessWidget {
  final String reviewer;
  final String date;
  final String description;
  final int rating;

  ReviewCards({
    this.reviewer,
    this.date,
    this.description,
    this.rating,
  });

  @override
  Widget build(BuildContext context) {
    CurrentGames _currentGame =
        Provider.of<CurrentGames>(context, listen: false);
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
      child: Container(
        //height: 100,
        decoration: BoxDecoration(
          color: Color(0xFF2FD398),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: Text(
                      "Reveiwed By: ",
                      style: FlutterFlowTheme.of(context).bodyText1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 100),
                    child: Text(reviewer,
                        style: FlutterFlowTheme.of(context).subtitle2),
                  ),
                  Text(
                    "Rating: ",
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).bodyText1,
                  ),
                  Text(rating.toString(),
                      style: FlutterFlowTheme.of(context).subtitle2),
                  Icon(
                    Icons.star,
                    color: Colors.black,
                    size: 24,
                  ),
                ],
              ),
              Text(
                "Date: " + date,
                style: FlutterFlowTheme.of(context).bodyText1,
              ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MarkdownBody(data: description),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
