import 'package:flutter/material.dart';

import '../miscellaneous/constants.dart';

class NoteViewPage extends StatelessWidget {
  const NoteViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('View Note'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Title',
                style: titleStyle,
              ),
              SizedBoxH20(),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Message',
                  style: style14Blue,
                ),
              ),
            ],
          ),
        ));
  }
}
