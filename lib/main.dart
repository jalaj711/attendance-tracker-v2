import 'package:attendance_tracker/models/app_state.dart';
import 'package:attendance_tracker/pages/calendar.dart';
import 'package:attendance_tracker/pages/home.dart';
import 'package:attendance_tracker/reducers/app_state_reducer.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final persistor = Persistor<AppState>(
    storage: FlutterStorage(location: FlutterSaveLocation.sharedPreferences),
    serializer: JsonSerializer<AppState>(AppState.fromJson),
  );

  // Load initial state
  final initialState = await persistor.load();
  final store = Store<AppState>(
    appReducer,
    initialState: initialState ?? AppState(),
    middleware: [persistor.createMiddleware()],
  );

  runApp(MyApp(
    store: store
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
          routes: {
            MyHomePage.routeName: (context) => const MyHomePage(),
            SubjectCalendarScreen.routeName: (context) => const SubjectCalendarScreen(),
          },
        ));
  }
}
