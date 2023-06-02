import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/cubit/tasksstates.dart';
import 'package:todoapp/database/locasql.dart';
import 'package:todoapp/models/taskmodel.dart';

class TasksCbit extends Cubit<TasksStates> {
  TasksCbit() : super(TasksInitialStates());
  List<Todo> todos = [];
  List<bool> isTaskChecked = [];
  static TasksCbit get(context) => BlocProvider.of(context);
  bool? ischecked = false;
  var db = DatabaseConnect();
  void changeCheckbox(bool val, int index) {
    isTaskChecked[index] = val;
    emit(TasksChangechekedboxStates());
  }

  void gettasks() {
    db.getTodo().then((value) {
      todos = value;
      isTaskChecked = List.generate(todos.length, (index) => false);
      emit(TasksgetsucsessStates());
    }).catchError((error) {
      emit(TasksgeterrorStates());
    });
  }

  void inserttasks(Todo todo) {
    todos.add(todo);
    db.insertTodo(todo).then((value) {
      gettasks();
      emit(TaskinsertionsucsessStates());
    }).catchError((error) {
      emit(TaskinsertionerrorStates());
    });
  }

  void deletetasks(Todo todo) {
    db.deleteTodo(todo).then((value) {
      emit(TasksdeletesucsessStates());
    }).catchError((error) {
      emit(TaskdeleteerrorStates());
    });
  }
}
