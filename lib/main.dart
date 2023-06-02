import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/cubit/tasksstates.dart';
import 'package:todoapp/database/locasql.dart';
import 'package:todoapp/features/homepage/homebottomnav.dart';
import 'package:todoapp/models/taskmodel.dart';

import 'cubit/hometaskcubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var db = DatabaseConnect();

  print(await db.getTodo());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TasksCbit()..gettasks(),
      child: BlocConsumer<TasksCbit, TasksStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: HomeBottomNav(),
          );
        },
      ),
    );
  }
}
