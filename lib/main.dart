import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tableproject/app/providers/comment_provider.dart';
import 'package:tableproject/app/view/homepage/page/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CommentProvider>(
      create: (_) => CommentProvider(),
      child: MaterialApp(
        title: 'Material App',
        home: HomePage(),
      ),
    );
  }
}
