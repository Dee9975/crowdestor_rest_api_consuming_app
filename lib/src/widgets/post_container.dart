import 'package:crowdestor_portfolio/src/resources/models/posts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostContainer extends StatelessWidget {
  final Posts post;
  final Function() onPressed;

  PostContainer({
    this.post,
    this.onPressed,
  }) : assert(post != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? () => null,
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
              spreadRadius: 2.0,
              offset: Offset(2.0, 2.0), // shadow direction: bottom right
            )
          ],
        ),
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.only(bottom: 8.0),
        child: Text(
          post.title,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
