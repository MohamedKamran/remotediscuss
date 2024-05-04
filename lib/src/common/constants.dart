import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class AppConstants {
  static String endpoint =
      dotenv.get("APPWRITE_ENDPOINT", fallback: "http://localhost:4000");
  static String projectId =
      dotenv.get("APPWRITE_PROJECT", fallback: "PROJECT_ID");
}
