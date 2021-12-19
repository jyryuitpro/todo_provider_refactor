import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider_refactor/pages/todos_page.dart';
import 'package:todo_provider_refactor/providers/active_todo_count.dart';
import 'package:todo_provider_refactor/providers/filtered_todos.dart';
import 'package:todo_provider_refactor/providers/todo_filter.dart';
import 'package:todo_provider_refactor/providers/todo_list.dart';
import 'package:todo_provider_refactor/providers/todo_search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoFilter>(
          create: (context) => TodoFilter(),
        ),
        ChangeNotifierProvider<TodoSearch>(
          create: (context) => TodoSearch(),
        ),
        ChangeNotifierProvider<TodoList>(
          create: (context) => TodoList(),
        ),
        ProxyProvider<TodoList, ActiveTodoCount>(
          update: (
            BuildContext context,
            TodoList todoList,
            ActiveTodoCount? _,
          ) =>
              ActiveTodoCount(todoList: todoList),
        ),
        ProxyProvider3<TodoFilter, TodoSearch, TodoList,
            FilteredTodos>(
          update: (BuildContext context,
                  TodoFilter todoFilter,
                  TodoSearch todoSearch,
                  TodoList todoList,
                  FilteredTodos? _) =>
              FilteredTodos(todoFilter: todoFilter, todoSearch: todoSearch, todoList: todoList),
        ),
      ],
      child: MaterialApp(
        title: 'ToDo Provider',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TodosPage(),
      ),
    );
  }
}
