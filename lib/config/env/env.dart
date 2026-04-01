import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static String get anonKey => dotenv.env['ANON_KEY']!;
  static String get url => dotenv.env['URL']!;
}
