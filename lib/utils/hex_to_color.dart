import 'dart:ui';

Color hexToColor(String hex) {
  hex = hex.replaceAll('#', '');
  if (hex.length == 6) {
    hex = 'FF$hex'; // agrega opacidad completa si no está
  }
  return Color(int.parse(hex, radix: 16));
}
