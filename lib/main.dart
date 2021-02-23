import 'package:crowdestor_portfolio/src/app.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

//This is a very basic app that consumes an api and returns the data in a formatted manner

void main() async {
  await GetStorage.init();
  runApp(App());
}