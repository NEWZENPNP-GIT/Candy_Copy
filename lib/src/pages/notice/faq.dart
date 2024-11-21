import 'package:candy/src/pages/commons/app_bar_title.dart';
import 'package:candy/src/pages/commons/constants.dart';
import 'package:flutter/material.dart';

class Faq extends StatelessWidget {
  const Faq({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarTitle(
          title: 'FAQ(자주하는질문)',
          backgroundColor: kColorFaq,
        ),
        body: SafeArea(child: Container()));
  }
}
