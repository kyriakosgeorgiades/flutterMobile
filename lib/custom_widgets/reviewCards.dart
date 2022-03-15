import 'package:flutter/material.dart';
import 'package:georgiadek_sem2_flutter/flutter_flow/flutter_flow_theme.dart';
import 'package:georgiadek_sem2_flutter/states/games.dart';
import 'package:provider/provider.dart';

class ReviewCards extends StatelessWidget {
  final String reviewer;
  final String date;
  final String description;
  final double rating;

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
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          decoration: BoxDecoration(
            color: Color(0xFF2FD398),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 50, 0),
                      child: Text(
                        reviewer,
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ),
                    Text(
                      rating.toString(),
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyText1,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.black,
                      size: 24,
                    ),
                  ],
                ),
                Align(
                  alignment: AlignmentDirectional(-1, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        date,
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                      Text(
                        description,
                        style: FlutterFlowTheme.of(context).bodyText1,
                      ),
                    ],
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
