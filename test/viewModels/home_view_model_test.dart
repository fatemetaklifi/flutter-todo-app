import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/repositories/task_repository.dart';
import 'package:todo_app/viewModels/home_view_model.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main(){

  late MockTaskRepository repository;
  late HomeViewModel homeViewModel;
  late List<Task> fakeTasks;
  
  setUp((){
    repository = MockTaskRepository();
    homeViewModel = HomeViewModel(repository);

    fakeTasks = [
      Task(
        id: '1',
        title: 'task1',
        priority: TaskPriority.high,
        status: TaskStatus.completed,
        createdAt: DateTime.now(),
      ),
      Task(
        id: '2',
        title: 'task2',
        priority: TaskPriority.medium,
        status: TaskStatus.todo,
        createdAt: DateTime.now(),
      ),
      Task(
        id: '3',
        title: 'task3',
        priority: TaskPriority.low,
        status: TaskStatus.completed,
        createdAt: DateTime.now(),
      ),
      Task(
        id: '4',
        title: 'task4',
        priority: TaskPriority.none,
        status: TaskStatus.todo,
        createdAt: DateTime.now(),
      ),
    ];
  });

  test('loadTasks loads tasks successfully', () async{

    when(() => repository.getTasks()).thenAnswer((_) async => fakeTasks);

    await homeViewModel.loadTasks();

    expect(homeViewModel.tasks, fakeTasks);
    expect(homeViewModel.state, HomeState.loaded);
  });

  test('loadTasks error occurs', () async{

    when(() => repository.getTasks()).thenThrow(Exception('Failed to load tasks'));

    await homeViewModel.loadTasks();

    expect(homeViewModel.state, HomeState.error);
  });

  test('addTask', () async{

    final task = Task(
      id: '5',
      title: 'task5',
      priority: TaskPriority.high,
      status: TaskStatus.todo,
      createdAt: DateTime.now(),
    );
    when(() => repository.addTask(task)).thenAnswer((_) async {});

    await homeViewModel.addTask(task);

    expect(homeViewModel.tasks, contains(task));
    verify(() => repository.addTask(task)).called(1);
  });

  test('remove task', () async{

    final task = Task(
      id: '4',
      title: 'task4',
      priority: TaskPriority.none,
      status: TaskStatus.todo,
      createdAt: DateTime.now(),
    );
    final id = '4';
    when(() => repository.getTasks()).thenAnswer((_) async => fakeTasks);
    when(() => repository.deleteTask(id)).thenAnswer((_) async => {});

    await homeViewModel.loadTasks();
    await homeViewModel.removeTask(id);

    expect(homeViewModel.tasks, isNot(contains(task)));
    verify(() => repository.deleteTask(id)).called(1);
  });

  test('update task', () async{

    final updatedTask = Task(
      id: '2',
      title: 'task22',
      priority: TaskPriority.low,
      status: TaskStatus.todo,
      createdAt: DateTime.now(),
    );
    when(() => repository.getTasks()).thenAnswer((_) async => fakeTasks);
    when(() => repository.updateTask(updatedTask)).thenAnswer((_) async => {});

    await homeViewModel.loadTasks();
    await homeViewModel.updateTask(updatedTask);

    expect(homeViewModel.tasks, contains(updatedTask));
    verify(() => repository.updateTask(updatedTask)).called(1);
  });

  test('change filter', () async {
    when(() => repository.getTasks()).thenAnswer((_) async => fakeTasks);
    await homeViewModel.loadTasks();

    homeViewModel.changeFilter(StatusFilter.completed);
    expect(homeViewModel.filteredTasks.every((task) => task.status == TaskStatus.completed,), true);

    homeViewModel.changeFilter(StatusFilter.todo);
    expect(homeViewModel.filteredTasks.every((task) => task.status == TaskStatus.todo,), true);
  });

}