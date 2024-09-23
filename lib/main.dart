import 'package:appscrip_assignment/controller/user_controller.dart';
import 'package:appscrip_assignment/view/UsersListScreen/screens/users_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserController()..fetchUsers(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'User List App',
        home: UserListScreen(),
      ),
    );
  }
}
