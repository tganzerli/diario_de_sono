import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color light50;
  final Color light100;
  final Color light200;
  final Color light300;
  final Color light400;
  final Color light500;
  final Color light600;
  final Color light700;
  final Color light800;
  final Color light900;

  final Color dark50;
  final Color dark100;
  final Color dark200;
  final Color dark300;
  final Color dark400;
  final Color dark500;
  final Color dark600;
  final Color dark700;
  final Color dark800;
  final Color dark900;

  final Color base50;
  final Color base100;
  final Color base200;
  final Color base300;
  final Color base400;
  final Color base500;
  final Color base600;
  final Color base700;
  final Color base800;
  final Color base900;

  final Color greenText;
  final Color greenBg;
  final Color greenSuccess;

  final Color amberWarning;
  final Color amberText;
  final Color amberBg;

  final Color redError;
  final Color redText;
  final Color redBg;

  final Color blueText;
  final Color blueBg;

  final Color purpleText;
  final Color purpleBg;

  final MaterialColor light;
  final MaterialColor dark;
  final MaterialColor base;

  AppColors({
    this.light50 = const Color(0xFFF2F2F2),
    this.light100 = const Color(0xFFD9E7F5),
    this.light200 = const Color(0xFFC1DCF7),
    this.light300 = const Color(0xFFA8D1FA),
    this.light400 = const Color(0xFF90C6FC),
    this.light500 = const Color(0xFF77BBFF),
    this.light600 = const Color(0xFF5FA5E6),
    this.light700 = const Color(0xFF488FCF),
    this.light800 = const Color(0xFF3079B7),
    this.light900 = const Color(0xFF19629F),
    this.dark50 = const Color(0xFFF2F2F2),
    this.dark100 = const Color(0xFFD5DBE0),
    this.dark200 = const Color(0xFFB9C3CF),
    this.dark300 = const Color(0xFF9CACBE),
    this.dark400 = const Color(0xFF8095AC),
    this.dark500 = const Color(0xFF637E9A),
    this.dark600 = const Color(0xFF476689),
    this.dark700 = const Color(0xFF2A4F78),
    this.dark800 = const Color(0xFF0E3866),
    this.dark900 = const Color(0xFF142940),
    this.base50 = const Color(0xFFFFFFFF),
    this.base100 = const Color(0xFFF8FAFC),
    this.base200 = const Color(0xFFF1F5F9),
    this.base300 = const Color(0xFFE2E8F0),
    this.base400 = const Color(0xFFCBD5E1),
    this.base500 = const Color(0xFF94A3B8),
    this.base600 = const Color(0xFF64748B),
    this.base700 = const Color(0xFF475569),
    this.base800 = const Color(0xFF334155),
    this.base900 = const Color(0xFF020617),
    this.greenText = const Color(0xFF059691),
    this.greenBg = const Color(0xFFD1FAE5),
    this.greenSuccess = const Color(0xFF16A34A),
    this.amberWarning = const Color(0xFFD97706),
    this.amberText = const Color(0xFFE07706),
    this.amberBg = const Color(0xFFFEF3C7),
    this.redError = const Color(0xFFDC2626),
    this.redText = const Color(0xFFE11D48),
    this.redBg = const Color(0xFFFFE4E6),
    this.blueText = const Color(0xFF178DCC),
    this.blueBg = const Color(0xFFE0F2FE),
    this.purpleText = const Color(0xFF5D5FEF),
    this.purpleBg = const Color(0xFFE0E7FF),
  }) : light = MaterialColor(light500.toARGB32(), <int, Color>{
         50: light50,
         100: light100,
         200: light200,
         300: light300,
         400: light400,
         500: light500,
         600: light600,
         700: light700,
         800: light800,
         900: light900,
       }),
       dark = MaterialColor(dark800.toARGB32(), <int, Color>{
         50: dark50,
         100: dark100,
         200: dark200,
         300: dark300,
         400: dark400,
         500: dark500,
         600: dark600,
         700: dark700,
         800: dark800,
         900: dark900,
       }),
       base = MaterialColor(base900.toARGB32(), <int, Color>{
         50: base50,
         100: base100,
         200: base200,
         300: base300,
         400: base400,
         500: base500,
         600: base600,
         700: base700,
         800: base800,
         900: base900,
       });

  @override
  AppColors copyWith({
    Color? light50,
    Color? light100,
    Color? light200,
    Color? light300,
    Color? light400,
    Color? light500,
    Color? light600,
    Color? light700,
    Color? light800,
    Color? light900,
    Color? dark50,
    Color? dark100,
    Color? dark200,
    Color? dark300,
    Color? dark400,
    Color? dark500,
    Color? dark600,
    Color? dark700,
    Color? dark800,
    Color? dark900,
    Color? base50,
    Color? base100,
    Color? base200,
    Color? base300,
    Color? base400,
    Color? base500,
    Color? base600,
    Color? base700,
    Color? base800,
    Color? base900,
    Color? greenText,
    Color? greenBg,
    Color? greenSuccess,
    Color? amberWarning,
    Color? amberText,
    Color? amberBg,
    Color? redError,
    Color? redText,
    Color? redBg,
    Color? blueText,
    Color? blueBg,
    Color? purpleText,
    Color? purpleBg,
  }) {
    return AppColors(
      light50: light50 ?? this.light50,
      light100: light100 ?? this.light100,
      light200: light200 ?? this.light200,
      light300: light300 ?? this.light300,
      light400: light400 ?? this.light400,
      light500: light500 ?? this.light500,
      light600: light600 ?? this.light600,
      light700: light700 ?? this.light700,
      light800: light800 ?? this.light800,
      light900: light900 ?? this.light900,
      dark50: dark50 ?? this.dark50,
      dark100: dark100 ?? this.dark100,
      dark200: dark200 ?? this.dark200,
      dark300: dark300 ?? this.dark300,
      dark400: dark400 ?? this.dark400,
      dark500: dark500 ?? this.dark500,
      dark600: dark600 ?? this.dark600,
      dark700: dark700 ?? this.dark700,
      dark800: dark800 ?? this.dark800,
      dark900: dark900 ?? this.dark900,
      base50: base50 ?? this.base50,
      base100: base100 ?? this.base100,
      base200: base200 ?? this.base200,
      base300: base300 ?? this.base300,
      base400: base400 ?? this.base400,
      base500: base500 ?? this.base500,
      base600: base600 ?? this.base600,
      base700: base700 ?? this.base700,
      base800: base800 ?? this.base800,
      base900: base900 ?? this.base900,
      greenText: greenText ?? this.greenText,
      greenBg: greenBg ?? this.greenBg,
      greenSuccess: greenSuccess ?? this.greenSuccess,
      amberWarning: amberWarning ?? this.amberWarning,
      amberText: amberText ?? this.amberText,
      amberBg: amberBg ?? this.amberBg,
      redError: redError ?? this.redError,
      redText: redText ?? this.redText,
      redBg: redBg ?? this.redBg,
      blueText: blueText ?? this.blueText,
      blueBg: blueBg ?? this.blueBg,
      purpleText: purpleText ?? this.purpleText,
      purpleBg: purpleBg ?? this.purpleBg,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;

    return AppColors(
      light50: Color.lerp(light50, other.light50, t)!,
      light100: Color.lerp(light100, other.light100, t)!,
      light200: Color.lerp(light200, other.light200, t)!,
      light300: Color.lerp(light300, other.light300, t)!,
      light400: Color.lerp(light400, other.light400, t)!,
      light500: Color.lerp(light500, other.light500, t)!,
      light600: Color.lerp(light600, other.light600, t)!,
      light700: Color.lerp(light700, other.light700, t)!,
      light800: Color.lerp(light800, other.light800, t)!,
      light900: Color.lerp(light900, other.light900, t)!,
      dark50: Color.lerp(dark50, other.dark50, t)!,
      dark100: Color.lerp(dark100, other.dark100, t)!,
      dark200: Color.lerp(dark200, other.dark200, t)!,
      dark300: Color.lerp(dark300, other.dark300, t)!,
      dark400: Color.lerp(dark400, other.dark400, t)!,
      dark500: Color.lerp(dark500, other.dark500, t)!,
      dark600: Color.lerp(dark600, other.dark600, t)!,
      dark700: Color.lerp(dark700, other.dark700, t)!,
      dark800: Color.lerp(dark800, other.dark800, t)!,
      dark900: Color.lerp(dark900, other.dark900, t)!,
      base50: Color.lerp(base50, other.base50, t)!,
      base100: Color.lerp(base100, other.base100, t)!,
      base200: Color.lerp(base200, other.base200, t)!,
      base300: Color.lerp(base300, other.base300, t)!,
      base400: Color.lerp(base400, other.base400, t)!,
      base500: Color.lerp(base500, other.base500, t)!,
      base600: Color.lerp(base600, other.base600, t)!,
      base700: Color.lerp(base700, other.base700, t)!,
      base800: Color.lerp(base800, other.base800, t)!,
      base900: Color.lerp(base900, other.base900, t)!,
      greenText: Color.lerp(greenText, other.greenText, t)!,
      greenBg: Color.lerp(greenBg, other.greenBg, t)!,
      greenSuccess: Color.lerp(greenSuccess, other.greenSuccess, t)!,
      amberWarning: Color.lerp(amberWarning, other.amberWarning, t)!,
      amberText: Color.lerp(amberText, other.amberText, t)!,
      amberBg: Color.lerp(amberBg, other.amberBg, t)!,
      redError: Color.lerp(redError, other.redError, t)!,
      redText: Color.lerp(redText, other.redText, t)!,
      redBg: Color.lerp(redBg, other.redBg, t)!,
      blueText: Color.lerp(blueText, other.blueText, t)!,
      blueBg: Color.lerp(blueBg, other.blueBg, t)!,
      purpleText: Color.lerp(purpleText, other.purpleText, t)!,
      purpleBg: Color.lerp(purpleBg, other.purpleBg, t)!,
    );
  }
}
