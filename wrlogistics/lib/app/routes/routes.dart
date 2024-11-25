import 'package:WrLogistics/app/app.dart';
import 'package:WrLogistics/home/home.dart';
import 'package:flutter/widgets.dart';
import 'package:WrLogistics/login/login.dart';
import 'package:WrLogistics/admin/admin.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.authenticatedAsAdmin:
      return [AdminPage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}