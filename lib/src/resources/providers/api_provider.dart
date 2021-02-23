import 'package:crowdestor_portfolio/src/resources/models/posts.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as g;

class ApiProvider {
  final Dio dio = new Dio(
    BaseOptions(
      baseUrl: "https://my-json-server.typicode.com/typicode/demo",
    ),
  );

  Future<List<Posts>> getUsers() async {
    try {
      Response response = await dio.get("/posts");
      List<Posts> posts = [];
      response.data?.forEach(
        (e) => posts.add(
          Posts.fromJson(e),
        ),
      );
      return posts;
    } on DioError catch (e, stacktrace) {
      g.Get.dialog(
        WillPopScope(
          onWillPop: () async => false,
          child: SimpleDialog(
            title: Text("Error"),
            children: [
              Text("There was an error fetching the data!"),
              Text("Would you like to try again?"),
              ElevatedButton(
                  onPressed: () async {
                    g.Get.back();
                    await getUsers();
                  },
                  child: Text("Try again")),
              ElevatedButton(
                onPressed: () {
                  g.Get.back();
                },
                child: Text("Close"),
              ),
            ],
          ),
        ),
        barrierDismissible: false,
      );

      throw new Exception(
          e.response.data ?? {"error": "Error retrieving posts"});
    } catch (e, stacktrace) {
      g.Get.dialog(
        WillPopScope(
          onWillPop: () async => false,
          child: SimpleDialog(
            title: Text("Error"),
            children: [
              Text("There was an error with the program, $e"),
              Text("Would you like to try again?"),
              ElevatedButton(
                  onPressed: () async {
                    g.Get.back();
                    await getUsers();
                  },
                  child: Text("Try again")),
              ElevatedButton(
                onPressed: () {
                  g.Get.back();
                },
                child: Text("Close"),
              ),
            ],
            contentPadding: EdgeInsets.all(24.0),
          ),
        ),
        barrierDismissible: false,
      );
      throw new Exception("There was an error at getPosts()");
    }
  }
}
