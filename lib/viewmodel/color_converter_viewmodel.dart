import 'package:flutter/foundation.dart';
import 'package:project_2/model/color_converter_model.dart';

class ColorConverterViewModel extends ChangeNotifier {
  // RGB
  double red = 0;
  double green = 128;
  double blue = 128;

  // CMYK
  double cyan = 0;
  double magenta = 0;
  double yellow = 0;
  double black = 0;

  // HSV
  double hue = 0;
  double saturation = 0;
  double value = 1;

  void updateRgb(double r, double g, double b) {
    red = r;
    green = g;
    blue = b;
    _updateCmyk();
    _updateHsv();
    notifyListeners();
  }

  void updateCmyk(double c, double m, double y, double k) {
    cyan = c;
    magenta = m;
    yellow = y;
    black = k;
    _updateRgbFromCmyk();
    _updateHsv();
    notifyListeners();
  }

  void updateHsv(double h, double s, double v) {
    hue = h;
    saturation = s;
    value = v;
    _updateRgbFromHsv();
    _updateCmyk();
    notifyListeners();
  }

  void _updateCmyk() {
    final cmyk =
        ColorConverter.rgbToCmyk(red.round(), green.round(), blue.round());
    cyan = cmyk['C'] ?? 0;
    magenta = cmyk['M'] ?? 0;
    yellow = cmyk['Y'] ?? 0;
    black = cmyk['K'] ?? 0;
  }

  void _updateHsv() {
    final hsv =
        ColorConverter.rgbToHsv(red.round(), green.round(), blue.round());
    hue = hsv['H'] ?? 0;
    saturation = hsv['S'] ?? 0;
    value = hsv['V'] ?? 0;
  }

  void _updateRgbFromCmyk() {
    final rgb = ColorConverter.cmykToRgb(cyan, magenta, yellow, black);
    red = rgb['R'] ?? 255;
    green = rgb['G'] ?? 255;
    blue = rgb['B'] ?? 255;
  }

  void _updateRgbFromHsv() {
    final rgb = ColorConverter.hsvToRgb(hue, saturation, value);
    red = rgb['R'] ?? 255;
    green = rgb['G'] ?? 255;
    blue = rgb['B'] ?? 255;
  }
}
