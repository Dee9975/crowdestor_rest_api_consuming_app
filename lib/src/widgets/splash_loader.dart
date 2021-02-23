import 'package:flutter/material.dart';

class SplashLoader extends StatefulWidget {
  final Future<void> Function() payload;
  final Function onComplete;
  SplashLoader({Key key, this.payload, this.onComplete}) : super(key: key);
  @override
  _SplashLoaderState createState() => _SplashLoaderState();
}

class _SplashLoaderState extends State<SplashLoader>
    with SingleTickerProviderStateMixin {
  // The animation controller is responsible for running/stopping/reversing the animation
  AnimationController _controller;
  // The animation is responsible for running the calculations for the next frame
  Animation<double> animation;

  @override
  void initState() {
    // For actions where the context of the app is required on state initialization
    // This whole block of code would be wrapped in:
    // WidgetsBinding.instance.addPostFrameCallback()
    // So that it only runs the code when the first frame has been rendered
    // But in this case we don't need that functionality so let's keep the code a bit cleaner and simpler
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
    // This is just a simple animation that changes it's value from 100 to 300 in a set amount of time
    // On a production app the animation would probably be a bit more complex and not so boring
    animation = Tween<double>(
      begin: 100,
      end: 300,
    ).animate(_controller)
      ..addListener(
        () {
          setState(() {});
        },
      )
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            // When the status of the animation has completed we can run the custom code that
            // Has been defined in the constructor
            widget.onComplete();
          }
        },
      );
    // You can't call asynchronous code in an initState method
    // So this data must be fetched synchronously
    recieveData();
    super.initState();
  }

  @override
  void dispose() {
    // You should never forget to dispose of all the controllers
    // Otherwise you could clog up the memory of the device
    _controller.dispose();
    super.dispose();
  }

  void recieveData() async {
    if (widget.payload != null) {
      await widget.payload();
    }
    // After the data has been loaded run the animation
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: animation.value,
      height: animation.value,
      child: FlutterLogo(),
    );
  }
}
