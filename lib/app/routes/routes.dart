
import 'package:flutter/widgets.dart';
import 'package:testing/app/app.dart';
import 'package:testing/app/home/home.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages
){
  switch(state){
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.authenticatedAsAdmin:
      return [AdminPage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}