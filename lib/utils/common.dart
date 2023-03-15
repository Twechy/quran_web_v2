import 'package:flutter/material.dart';

import 'consts.dart';

enum ViewDirection { V, H }

enum TextType { header, label, text, custom }

class TextView extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final TextStyle textStyle;
  final String label;
  final TextStyle labelStyle;
  final ViewDirection viewDirection;
  final double spaceBetween;
  final double padding;
  final int labelHFlex;
  final int index;
  final int textHFlex;

  const TextView({super.key,
    required this.label,
    required this.labelStyle,
    required this.text,
    required this.textStyle,
    this.index = 0,
    this.spaceBetween = 15.0,
    this.viewDirection = ViewDirection.V,
    this.padding = 2.0,
    this.textAlign = TextAlign.center,
    this.labelHFlex = 1,
    this.textHFlex = 1,
  });

  @override
  Widget build(BuildContext context) {
    var isIndex0 = index == 0;
    var vContainer = Container(
      padding: EdgeInsets.all(padding),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            isIndex0
                ? Text(
                    label,
                    style: labelStyle,
                    textAlign: textAlign,
                  )
                : const SizedBox(height: 25.0),
            SizedBox(
              height: isIndex0 ? spaceBetween : 0.0,
            ),
            Text(
              text,
              style: textStyle,
              textAlign: textAlign,
            ),
          ],
        ),
      ),
    );

    var hContainer = Container(
      padding: EdgeInsets.all(padding),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            isIndex0
                ? Text(
                    label,
                    style: labelStyle,
                    textAlign: textAlign,
                  )
                : const SizedBox(width: 10.0),
            SizedBox(
              width: isIndex0 ? spaceBetween : 0.0,
            ),
            Text(
              text,
              style: textStyle,
              textAlign: textAlign,
            ),
          ],
        ),
      ),
    );

    switch (viewDirection) {
      case ViewDirection.H:
        return hContainer;
      case ViewDirection.V:
        return vContainer;
      default:
        return hContainer;
    }
  }
}

Widget streamBuilder<T>({
  required Stream<T> stream,
  required Widget Function(BuildContext, AsyncSnapshot<T>) builder,
}) {
  return StreamBuilder<T>(
    stream: stream,
    builder: builder,
  );
}

Widget ayaCounterView({
  required String ayaNumber,
  required Color counterColor,
  required Color textColor,
  fontSize = 13.0,
  radius = 12.0,
  ayaFontFamily = 'hafs',
}) {
  final double radiusWidth = ayaNumber.length > 2 ? 15.0 : radius;
  return CircleAvatar(
    foregroundColor: Colors.white,
    radius: radiusWidth,
    backgroundColor: counterColor,
    child: Text(
      ayaNumber,
      style: textStyle(
          textType: TextType.text,
          fontSize: fontSize,
          color: textColor,
          fontFamily: ayaFontFamily != 'hafs' ? ayaFontFamily : 'hafs',
          fontWeight: FontWeight.w500,
          letterSpacing: 1.0),
    ),
  );
}

TextStyle textStyle({
  required TextType textType,
  double fontSize = 18,
  FontWeight fontWeight = FontWeight.w400,
  String fontFamily = 'hafs',
  Color color = Colors.black,
  double wordSpacing = 0.0,
  double letterSpacing = 0.0,
}) {
  switch (textType) {
    case TextType.label:
      if (fontSize == 18) {
        fontSize = 12;
      }
      fontWeight = FontWeight.w400;
      color = AppConst.mainColor;
      break;
    case TextType.text:
      fontWeight = FontWeight.w500;
      break;
    case TextType.header:
      fontWeight = FontWeight.w500;
      color = AppConst.mainColor;
      break;
    case TextType.custom:
      break;
    default:
  }
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    fontFamily: fontFamily == 'hafs' ? AppConst.fontFamily : fontFamily,
    package: fontFamily == 'hafs' ? null : AppConst.fontPackage,
    wordSpacing: wordSpacing,
    letterSpacing: letterSpacing,
    color: color,
  );
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class ShowLoading extends StatelessWidget {
  const ShowLoading({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

Future<dynamic> showAppDialog({required BuildContext context, required Widget widget}) async {
  return await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => widget,
  );
}

Widget textField({
  required GlobalKey key,
  required String label,
  fillColor = Colors.white,
  required Function(String) onChanged,
  width = 450.0 / 1.6,
  String initValue = '',
  String validationMessage = 'Please enter some text',
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 4.0),
    child: SizedBox(
      width: width,
      child: TextFormField(
        key: key,
        onChanged: onChanged,
        initialValue: initValue,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: textStyle(textType: TextType.label, fontSize: 16),
          fillColor: fillColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return validationMessage;
          }
          return null;
        },
        keyboardType: TextInputType.emailAddress,
        style: textStyle(textType: TextType.text),
      ),
    ),
  );
}

Widget appBar(BuildContext context,
    {String title = 'القرأن الكريم', bool showBack = true}) {
  Widget titleWdg = Container();

  if (title != 'القرأن الكريم') {
    titleWdg = Text(
      title,
      style: textStyle(
        textType: TextType.text,
        fontSize: 28,
      ),
    );
  } else {
    titleWdg = Image.asset(
      'assets/icons/logo.PNG',
      fit: BoxFit.cover,
      height: 55.0,
      alignment: Alignment.center,
    );
  }

  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0.0,
    centerTitle: true,
    leading: showBack
        ? InkWell(
            child: Icon(
              Icons.arrow_back_ios,
              size: 25,
              color: HexColor('5381EB'),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          )
        : null,
    title: titleWdg,
  );
}
