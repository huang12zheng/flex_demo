/// source from https://stackoverflow.com/questions/66529944/encode-map-with-enum-to-json#:~:text=The%20problem%20is%20that%20enum%20is%20not%20defined,if%20calling%20toString%20%28%29%20on%20a%20enum%20value.
import 'dart:convert';

import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class JsonConverterWithEnumSupport {
  final String magicString;
  final Set<Object> allEnumValues = {};
  final Map<String, Object> enumStringToEnumValue = {};

  JsonConverterWithEnumSupport(
    List<List<Object>>? enumsValues, {
    this.magicString = "DART_ENUM:",
  }) {
    enumsValues?.forEach(addEnumValues);
    allEnumValues.add(Color);
    allEnumValues.add(MaterialColor);
  }

  void addEnumValues(List<Object> enumValues) {
    for (final enumValue in enumValues) {
      enumStringToEnumValue[enumValue.toString()] = enumValue;
      allEnumValues.add(enumValue);
    }
  }

  String _addMagic(dynamic enumValue) {
    return '$magicString$enumValue';
  }

  String _removeMagic(String string) => string.substring(magicString.length);

  String encode(Object? value) =>
      json.encode(value, toEncodable: (dynamic object) {
        if (object is Map) {
          return object.map<dynamic, dynamic>((dynamic key, dynamic value) =>
              MapEntry<dynamic, dynamic>(
                  allEnumValues.contains(key) ? _addMagic(key) : key,
                  allEnumValues.contains(value) ? _addMagic(value) : value));
        }

        if (object is List) {
          return object.map<dynamic>(
              (dynamic e) => allEnumValues.contains(e) ? _addMagic(e) : e);
        }

        if (allEnumValues.contains(object)) {
          return _addMagic(object);
        }

        if (allEnumValues.contains(object.runtimeType)) {
          return _addMagic(object);
        }

        return object;
      });

  dynamic decode(String source) => json.decode(source, reviver: (key, value) {
        if (value is String && value.startsWith(magicString)) {
          var _v = _removeMagic(value);
          if (_v.startsWith('Color')) {
            // 0123456789012345678
            // Color(0xfff44336)
            return Color(int.parse(_v.substring(6, 16)));
          }
          // if (_v.startsWith('MaterialColor')) {
          //   return int.tryParse(_v.substring(6,16));
          // }
          return enumStringToEnumValue[_v];
        }

        if (value is Map) {
          return value.map<dynamic, dynamic>((dynamic key, dynamic value) =>
              MapEntry<dynamic, dynamic>(
                  (key is String) && key.startsWith(magicString)
                      ? enumStringToEnumValue[_removeMagic(key)]
                      : key,
                  value));
        }

        return value;
      });
}

/// by set(['FlexSystemNavBarStyle', 'FlexInputBorderType', 'Color', 'FlexScheme', 'ThemeMode', 'FlexAppBarStyle?', 'FlexSurfaceMode', 'SchemeColor?', 'NavigationDestinationLabelBehavior', 'NavigationRailLabelType', 'Color?', 'FlexTabBarStyle'])
/// result: {"isLargeGridView":true,"schemeIndex":37,"sysNavBarStyle":"DART_ENUM:FlexSystemNavBarStyle.background","useFlexColorScheme":true,"useMaterial3":true,"viewIndex":8}
/// result: {"1":"DART_ENUM:MaterialColor(primary value: Color(0xfff44336))"}
JsonConverterWithEnumSupport getConverter() {
  return JsonConverterWithEnumSupport([
    FlexSystemNavBarStyle.values,
    FlexInputBorderType.values,
    FlexScheme.values,
    ThemeMode.values,
    FlexAppBarStyle.values,
    FlexSurfaceMode.values,
    SchemeColor.values,
    NavigationDestinationLabelBehavior.values,
    NavigationRailLabelType.values,
    FlexTabBarStyle.values,
  ]);
}

/// can't work due to Color
// enum MyFirstEnum { first1, first2 }
// enum MySecondEnum { second1, second2 }
// void main() {
//   final converter =
//       JsonConverterWithEnumSupport([MyFirstEnum.values, MySecondEnum.values]);

//   final jsonString = converter.encode({
//     MyFirstEnum.first1: [MySecondEnum.second2, MySecondEnum.second1],
//     'test': {MyFirstEnum.first2: 5}
//   });

//   print(jsonString);
//   // {"DART_ENUM:MyFirstEnum.first1":["DART_ENUM:MySecondEnum.second2","DART_ENUM:MySecondEnum.second1"],"test":{"DART_ENUM:MyFirstEnum.first2":5}}
//   print(converter.decode(jsonString));
//   // {MyFirstEnum.first1: [MySecondEnum.second2, MySecondEnum.second1], test: {MyFirstEnum.first2: 5}}
// }
