import 'package:flutter/material.dart';

/// Método para crear la alerta
void showAlertDialog(
    {@required BuildContext context,
    String message,
    Widget child,
    String title,
    String titleButton1 = "OK",
    String titleButton2,
    bool loadingButton1 = false,
    Function() onTapButton1,
    Function() onTapButton2,
    Color colorButton1,
    Color colorButton2,
    Widget asset,
    double fontSizeMessage = 18,
    double fontSizeButton = 16,
    double height = 290,
    bool isOK = false,
    bool dismissible = true,
    bool centerText = true,
    bool isRow = true}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double alto = 40;
  double paddingButtons = 10;

  showDialog(
      barrierDismissible: dismissible,
      context: context,
      builder: (BuildContext context) {
        Widget buttonsArea;
        if (titleButton2 == null || titleButton2 == "") {
          buttonsArea = ButtonWidget(
            height: alto,
            title: titleButton1,
            width: 250,
            style: TextStyle(),
            onTap: () {
              if (onTapButton1 != null) {
                onTapButton1();
              }
              if (dismissible) {
                Navigator.of(context).pop();
              }
            },
          );
        } else {
          if (isRow) {
            buttonsArea = Row(
              children: <Widget>[
                SizedBox(
                  width: paddingButtons,
                ),
                SizedBox(
                  width: screenWidth <= 320 ? 90 : 120 - paddingButtons / 2,
                  child: Center(
                    child: ButtonWidget(
                      height: alto,
                      title: titleButton1,
                      style: TextStyle(),
                      width: screenWidth <= 320 ? 90 : 120 - paddingButtons / 2,
                      isOutline: true,
                      onTap: () async {
                        if (onTapButton1 != null) {
                          await onTapButton1();
                          if (loadingButton1) {
                            await Future.delayed(Duration(milliseconds: 500));
                          }
                        }
                        if (dismissible) {
                          Navigator.of(context).pop(1);
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: paddingButtons / 2,
                ),
                Spacer(),
                SizedBox(
                  width: paddingButtons / 2,
                ),
                ButtonWidget(
                  height: alto,
                  title: titleButton2,
                  style: TextStyle(),
                  width: screenWidth <= 320 ? 90 : 120 - paddingButtons / 2,
                  onTap: () {
                    if (onTapButton2 != null) {
                      onTapButton2();
                    }
                    if (dismissible) {
                      Navigator.of(context).pop(2);
                    }
                  },
                ),
                SizedBox(
                  width: paddingButtons,
                ),
              ],
            );
          } else {
            buttonsArea = Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: Column(
                children: <Widget>[
                  ButtonWidget(
                    height: alto,
                    style: TextStyle(),
                    title: titleButton2,
                    width: screenWidth,
                    onTap: () {
                      if (onTapButton2 != null) {
                        onTapButton2();
                      }
                      if (dismissible) {
                        Navigator.of(context).pop(2);
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ButtonWidget(
                    height: alto,
                    style: TextStyle(),
                    title: titleButton1,
                    isOutline: true,
                    outlineColor: colorButton2,
                    width: screenWidth,
                    onTap: () {
                      if (onTapButton1 != null) {
                        onTapButton1();
                      }
                      if (dismissible) {
                        Navigator.of(context).pop(1);
                      }
                    },
                  ),
                ],
              ),
            );
          }
        }

        asset = asset != null ? asset : Container();

        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
          backgroundColor: Colors.white,
          child: Container(
            height: height,
            width: 300.0,
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                title != null
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                        child: asset is Container
                            ? Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: centerText
                                    ? Center(child: Text(title, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))
                                    : SizedBox(
                                        width: 300,
                                        child: Text(title, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                      ),
                              )
                            : Container(
                                child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Spacer(),
                                  if (asset != null) asset,
                                  Spacer(),
                                ],
                              )))
                    : Container(),
                SizedBox(
                  height: title != null ? 5 : 0,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, title != null ? 10 : 0, 20, 10),
                    child: child == null && message == null
                        ? Center(child: Text("Sin mensaje"))
                        : message == null
                            ? child == null
                                ? Center(child: Text("Sin mensaje"))
                                : child
                            : child == null
                                ? Center(
                                    child: Column(
                                    children: [
                                      Spacer(),
                                      centerText
                                          ? Center(
                                              child: Text(
                                              message,
                                            ))
                                          : Text(
                                              message,
                                            ),
                                      Spacer(),
                                    ],
                                  ))
                                : Column(
                                    children: [
                                      centerText
                                          ? Center(
                                              child: Text(
                                              message,
                                              textAlign: TextAlign.center,
                                            ))
                                          : Text(
                                              message,
                                            ),
                                      Spacer(),
                                      child
                                    ],
                                  ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: buttonsArea,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      });
}

class ButtonWidget extends StatelessWidget {
  final Function() onTap;
  final String title;
  final double width;
  final double height;
  final bool isOutline;
  final bool enabled;
  final double fontSize;
  final TextStyle style;
  final bool negative;
  final Color outlineColor;

  ButtonWidget(
      {@required this.title,
      @required this.onTap,
      @required this.width,
      this.fontSize = 20,
      this.isOutline = false,
      this.enabled = true,
      this.height = 42,
      @required this.style,
      this.negative = false,
      this.outlineColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    TextStyle _style = style;
    double fontSizeTMP = fontSize;

    Color grey = Color.fromRGBO(0, 0, 0, 0.2);

    Color _outlineColor = outlineColor;
    Color _outlineColorBorder = outlineColor;

    return GestureDetector(
      onTap: () {
        if (enabled) {
          onTap();
        }
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: enabled
                ? isOutline
                    ? Colors.transparent
                    : negative
                        ? Colors.white
                        : Colors.black
                : grey,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: enabled
                    ? isOutline
                        ? _outlineColorBorder
                        : Colors.transparent
                    : Colors.transparent)),
        child: Center(
          child: Text(title,
              style: enabled
                  ? isOutline
                      ? _style.copyWith(fontSize: fontSizeTMP, color: _outlineColor)
                      : _style.copyWith(fontSize: fontSizeTMP, color: negative ? Colors.black : Colors.white)
                  : _style.copyWith(color: negative ? Colors.black : Colors.white, fontSize: fontSizeTMP)),
        ),
      ),
    );
  }
}
