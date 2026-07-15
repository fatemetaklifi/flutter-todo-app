import 'package:flutter/material.dart';
import 'package:todo_app/repositories/task_repository.dart';
import 'package:todo_app/models/task.dart';
import 'dart:collection';

enum StatusFilter { all, todo, completed }

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._repository);

  Future<void> initialize() async {
    await loadTasks();
  }

  final TaskRepository _repository;
  final List<Task> _tasks = [];
  StatusFilter _selectedStatus = StatusFilter.all;

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);
  StatusFilter get selectedStatus => _selectedStatus;
  List<Task> get filteredTasks {
    if (_selectedStatus == StatusFilter.all) {
      return List.unmodifiable(_tasks);
    }

    return _tasks.where((task) {
      switch (_selectedStatus) {
        case StatusFilter.todo:
          return task.status == TaskStatus.todo;
        case StatusFilter.completed:
          return task.status == TaskStatus.completed;
        default:
          return true;
      }
    }).toList();
  }

  void changeFilter(StatusFilter filter) {
    _selectedStatus = filter;
    notifyListeners();
  }

  Future<void> loadTasks() async {
    final data = await _repository.getTasks();
    _tasks
      ..clear()
      ..addAll(data);
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _repository.addTask(task);
    _tasks.add(task);
    notifyListeners();
  }

  Future<void> removeTask(String id) async {
    await _repository.deleteTask(id);
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  Future<void> changeStatus(Task task) async {
    final updatedTask = task.copyWith(
      status: (task.status == TaskStatus.todo)
          ? TaskStatus.completed
          : TaskStatus.todo,
    );
    await _repository.updateTask(updatedTask);
    final index = _tasks.indexWhere((item) => item.id == task.id);

    if (index != -1) {
      _tasks[index] = updatedTask;
    }

    notifyListeners();
  }

  Future<void> updateTask(Task task) async {

    await _repository.updateTask(task);

    final index = _tasks.indexWhere(
          (t) => t.id == task.id,
    );

    if(index != -1){
      _tasks[index] = task;
    }

    notifyListeners();
  }
}
