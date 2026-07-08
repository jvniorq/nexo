import 'package:flutter/animation.dart';

abstract final class NexoSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double pageBottom = 120;
}

abstract final class NexoRadii {
  static const double brand = 14;
  static const double control = 16;
  static const double floatingButton = 18;
  static const double card = 20;
}

abstract final class NexoMotion {
  static const Duration fast = Duration(milliseconds: 180);
  static const Duration standard = Duration(milliseconds: 240);
  static const Duration emphasized = Duration(milliseconds: 320);

  static const Curve enterCurve = Curves.easeOutCubic;
  static const Curve exitCurve = Curves.easeInCubic;
}
