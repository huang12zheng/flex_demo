import 'package:flex_demo/flex_theme_controller.dart';
import 'package:flex_demo/shared/controllers/controller_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeControllerProvider((controller) => Scaffold(
          appBar: AppBar(
            title: Text(AppColor.schemes[controller.schemeIndex].name),
          ),
          body: CustomScrollView(
            slivers: [],
          ),
        ));
  }
}
