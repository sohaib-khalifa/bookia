import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void pushReplacement(BuildContext context, String routeName, {Object? extra}) {
  context.pushReplacement(routeName, extra: extra);
}

Future<void> pushTo(BuildContext context, String routeName, {Object? extra}) {
  return context.push(routeName, extra: extra);
}

void pushToBase(BuildContext context, String routeName) {
  context.go(routeName);
}

void pop(BuildContext context) {
  context.pop();
}
