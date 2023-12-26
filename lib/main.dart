import 'package:attendance_tracker/models/app_state.dart';
import 'package:attendance_tracker/pages/home/main.dart';
import 'package:attendance_tracker/reducers/app_state_reducer.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

void main() {
  runApp(MyApp(
    store: Store<AppState>(
      appReducer,
      initialState: AppState.loading(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.store});

  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
          title: 'Attendance Tracker',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple, brightness: Brightness.dark),
            useMaterial3: true,
            fontFamily: "Montserrat",
          ),
          home: const MyHomePage(title: 'Attendance Tracker Home'),
        ));
  }
}
