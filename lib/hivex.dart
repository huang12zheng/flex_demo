import 'shared/services/theme_service_hive.dart';

extension EnDe on ThemeServiceHive {
  Map<dynamic, dynamic> toMap() {
    return hiveBox.toMap();
  }

  void fromMap(Map<dynamic, dynamic> kvPairs) {
    hiveBox.putAll(kvPairs);
  }
}
