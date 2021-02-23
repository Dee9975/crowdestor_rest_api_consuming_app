import 'package:crowdestor_portfolio/src/resources/models/posts.dart';
import 'package:crowdestor_portfolio/src/widgets/post_container.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  final List<Posts> posts;
  Dashboard({Key key, this.posts}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: widget.posts
                .map(
                  (e) => PostContainer(
                    post: e,
                    onPressed: () => print(e.id),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
