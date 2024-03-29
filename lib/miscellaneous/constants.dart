import 'package:flutter/material.dart';

const TextStyle headingStyle = TextStyle(
  fontSize: 22,
  color: Colors.black,
  fontWeight: FontWeight.w300
);
const TextStyle whiteHeadingStyle = TextStyle(
  fontSize: 22,
  color: Colors.white,
  fontWeight: FontWeight.w300
);

const TextStyle style14Black = TextStyle(
  fontSize: 18,
  color: Colors.black,
  fontWeight: FontWeight.w300
);

const TextStyle styleWhite = TextStyle(
  fontSize: 16,
  color: Colors.white,
);

const TextStyle titleStyle = TextStyle(
  fontSize: 22,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

const focusedBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(10),
  ),
  borderSide: BorderSide(
    width: 2,
    color: Colors.black,
  ),
);

const errorBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(10),
  ),
  borderSide: BorderSide(
    width: 2,
    color: Colors.red,
  ),
);

const enabledBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(10),
  ),
  borderSide: BorderSide(
    width: 1,
    color: Colors.black,
  ),
);

InputDecoration formDecoration(String labelText, IconData iconData) {
  return InputDecoration(
      errorStyle: const TextStyle(
        fontSize: 10,
      ),
      //counterText: '',
      prefixIcon: Icon(
        iconData,
        color: Colors.black,
      ),
      errorMaxLines: 3,
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.grey),
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      focusedErrorBorder: errorBorder,
      );
}

class SizedBoxH10 extends StatelessWidget {
  const SizedBoxH10({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 10,
    );
  }
}

class SizedBoxH20 extends StatelessWidget {
  const SizedBoxH20({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
    );
  }
}

class SizedBoxH30 extends StatelessWidget {
  const SizedBoxH30({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 30,
    );
  }
}
