import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'widgets/choose_message.widget.dart';
import 'widgets/failed_message.widget.dart';
import 'widgets/info_message.widget.dart';
import 'widgets/success.message.dart';

void successSnackBar({String? message}) {
  final snackBar = SuccessMessage(
    message: message ?? 'تمت العملية بنجاح',
  );
  Flushbar(
    duration: const Duration(seconds: 3),
    messageText: snackBar,
    backgroundColor: Colors.transparent,
    boxShadows: const [
      BoxShadow(color: Colors.transparent), // No shadow
    ],
    flushbarPosition: FlushbarPosition.TOP, // Position at the top
  ).show(navigatorKey.currentContext!);
}

void failedSnackBar({String? message}) {
  final snackBar = FailedMessage(
    message: message ?? 'خطأ الرجاء إعادة المحاولة',
  );
  Flushbar(
    duration: const Duration(seconds: 3),
    messageText: snackBar,
    backgroundColor: Colors.transparent,
    boxShadows: const [
      BoxShadow(color: Colors.transparent), // No shadow
    ],
    flushbarPosition: FlushbarPosition.TOP, // Position at the top
  ).show(navigatorKey.currentContext!);
}

void infoSnackBar({String? message}) {
  final snackBar = InfoMessage(
    message: message ?? 'خطأ الرجاء إعادة المحاولة',
  );
  Flushbar(
    duration: const Duration(seconds: 3),
    messageText: snackBar,
    backgroundColor: Colors.transparent,
    boxShadows: const [
      BoxShadow(color: Colors.transparent), // No shadow
    ],
    flushbarPosition: FlushbarPosition.TOP, // Position at the top
  ).show(navigatorKey.currentContext!);
}

void chooseSnackBar({String? message}) {
  final snackBar = ChooseMessage(
    message: message ?? 'خطأ الرجاء إعادة المحاولة',
  );
  Flushbar(
    duration: const Duration(seconds: 3),
    messageText: snackBar,
    backgroundColor: Colors.transparent,
    boxShadows: const [
      BoxShadow(color: Colors.transparent), // No shadow
    ],
    flushbarPosition: FlushbarPosition.TOP, // Position at the top
  ).show(navigatorKey.currentContext!);
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
