import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:remotediscuss/src/appwrite/appwrite.dart';
import 'package:remotediscuss/src/auth_notifier/auth_notifier.dart';
import 'package:remotediscuss/src/auth_notifier/auth_state.dart';

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  () => AuthNotifier(GetIt.I.get<Appwrite>().account),
);
