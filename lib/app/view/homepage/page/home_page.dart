import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:tableproject/app/models/comment_model.dart';
import 'package:tableproject/app/providers/comment_provider.dart';

import '../home_page_style.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<CommentProvider>().getDBComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }
}

Widget _buildBody(BuildContext context) {
  return RefreshIndicator(
    onRefresh: () => context.read<CommentProvider>().getDBComments(),
    child: ListView(
      children: <Widget>[
        const SizedBox(height: 50),
        _buildTableHeader(),
        const SizedBox(height: 20),
        _buildTable(context),
      ],
    ),
  );
}

Widget _buildTableHeader() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Container(width: 40, child: Text('ID', style: tableHeaderStyle())),
      Container(width: 180, child: Text('Email', style: tableHeaderStyle())),
      Container(
          width: 120, child: Text('Post name', style: tableHeaderStyle())),
    ],
  );
}

Widget _buildTableRow(
    String id, String email, String name, String body, BuildContext context) {
  return GestureDetector(
    onTap: () => showOkAlertDialog(context: context, title: email, message: body),
    child: Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(width: 40, child: Text(id, style: tableCellStyle())),
          Container(width: 180, child: Text(email, style: tableCellStyle())),
          Container(width: 120, child: Text(name, style: tableCellStyle())),
        ],
      ),
    ),
  );
}

Widget _buildTable(BuildContext context) {
  final List<CommentModel>? comments =
      Provider.of<CommentProvider>(context, listen: true).comments;

  return comments != null
      ? Table(
          children: comments
              .map((CommentModel e) => TableRow(
                    children: <Widget>[
                      _buildTableRow(
                        e.commentID,
                        e.commentEmail,
                        e.commentName,
                        e.commentBody,
                        context,
                      )
                    ],
                  ))
              .toList(),
        )
      : _buildLoader();
}

Widget _buildLoader() {
  return const Center(
    child: SpinKitCircle(
      size: 50,
      color: Colors.lightGreen,
    ),
  );
}
