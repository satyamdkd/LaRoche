import 'package:laroch/const/colors.dart';
import '../const/common_lib.dart';

AppColors get appColors => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

class ThemeHelper {
  ThemeData themeData() => _getThemeData();
  AppColors themeColor() => _getThemeColors();
  var colorScheme = ColorSchemes.primaryColorScheme;

  ThemeData _getThemeData() {
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: appColors.black900)),
      ),
      textTheme: TextThemes.textTheme(colorScheme),
      scaffoldBackgroundColor: colorScheme.primary,
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(color: appColors.red, width: 1.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.h),
          ),
          padding: EdgeInsets.all(8.h),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.h),
          ),
          padding: EdgeInsets.all(8.h),
        ),
      ),
      radioTheme: RadioThemeData(
          fillColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return colorScheme.primary;
            }
            return colorScheme.onSurface;
          }),
          visualDensity: const VisualDensity(
            vertical: -4,
            horizontal: -4,
          )),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: appColors.blueGray700,
      ),
      dividerTheme: DividerThemeData(
          thickness: 2, space: 2, color: colorScheme.secondaryContainer),
    );
  }

  AppColors _getThemeColors() {
    return AppColors();
  }
}

class TextThemes {
  static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
        bodyLarge: TextStyle(
          color: appColors.blueGray400,
          fontSize: 16.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          color: colorScheme.primary,
          fontSize: 14.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          color: colorScheme.primary,
          fontSize: 12.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),
        displayMedium: TextStyle(
          color: colorScheme.primary,
          fontSize: 40.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
        ),
        displaySmall: TextStyle(
          color: colorScheme.primary,
          fontSize: 36.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
        headlineLarge: TextStyle(
          color: appColors.deepPurpleA200,
          fontSize: 32.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
        ),
        headlineSmall: TextStyle(
          color: appColors.deepPurpleA200,
          fontSize: 24.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
        ),
        labelLarge: TextStyle(
          color: appColors.black90001,
          fontSize: 12.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          color: appColors.blueGray400,
          fontSize: 10.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
        titleLarge: TextStyle(
          color: appColors.black90001,
          fontSize: 20.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: colorScheme.primary,
          fontSize: 16.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          color: appColors.deepPurpleA200,
          fontSize: 14.sp,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
        ),
      );
}

class ColorSchemes {
  static const primaryColorScheme = ColorScheme.light(
    primary: Color(0XFFFFFFFF),
    primaryContainer: Color(0XFF5934E3),
    secondaryContainer: Color(0XFFF9F7FE),
    errorContainer: Color(0XFFA793F0),
    onPrimary: Color(0XFF2F2E32),
    onPrimaryContainer: Color(0X00080808),
  );
}
