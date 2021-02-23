import 'package:crowdestor_portfolio/src/resources/models/posts.dart';
import 'package:crowdestor_portfolio/src/resources/providers/api_provider.dart';
import 'package:crowdestor_portfolio/src/screens/dashboard.dart';
import 'package:crowdestor_portfolio/src/widgets/splash_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ApiProvider _apiProvider = new ApiProvider();
  List<Posts> posts = [];
  @override
  Widget build(BuildContext context) {
    Future<void> retrieveData() async {
      List<Posts> retrievedPosts = await _apiProvider.getUsers();
      setState(() {
        posts = retrievedPosts;
      });
    }

    return Scaffold(
      body: Center(
        child: SplashLoader(
          payload: () async {
            // Usually this is where the data from the local database would be initialized,
            // but just for an example of an asynchronous operation running from the splash screen
            // this will do!
            await retrieveData();
          },
          onComplete: () {
            // When the animation is completed all the data has already been loaded
            // or an error has been caught
            // so this is a safe place to do the navigation!
            // the offAll method is made to remove all previously stored pages from the stack
            // and leave only the one that has just been navigated to
            // so that the user can't accidentally go back to the splash screen where they
            // would get stuck in an infinite loop
            Get.offAll(() => Dashboard(posts: posts));
          },
        ),
      ),
    );
  }
}