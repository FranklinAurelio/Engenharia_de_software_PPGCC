import 'package:shared_preferences/shared_preferences.dart';

Future<void> insertData(int type, String key, dynamic value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  switch (type) {
    case 0:
      await prefs.setInt(key, value);
      break;
    case 1:
      await prefs.setBool(key, value);
      break;
    case 2:
      await prefs.setDouble(key, value);
      break;
    case 3:
      await prefs.setString(key, value);
      break;
    default:
  }
}

Future<dynamic> readData(String key, int type) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var datapersist;
  switch (type) {
    case 0:
      return datapersist = prefs.getInt(key);

    case 1:
      return datapersist = prefs.getBool(key);

    case 2:
      return datapersist = prefs.getDouble(key);

    case 3:
      return datapersist = prefs.getString(key);

    default:
  }
}
