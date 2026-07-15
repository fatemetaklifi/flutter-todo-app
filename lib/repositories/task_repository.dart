import 'package:todo_app/database/database_helper.dart';

import '../models/task.dart';

class TaskRepository {
  TaskRepository(this._database);

  final DatabaseHelper _database;

  Future<List<Task>> getTasks(){
    return _database.getAllTasks();
  }
  Future<void> addTask(Task task)async{
    await _database.insertTask(task);
  }
  Future<void> updateTask(Task task) async{
    await _database.updateTask(task);
  }
  Future<void> deleteTask(String id) async{
    await _database.deleteTask(id);
  }

}