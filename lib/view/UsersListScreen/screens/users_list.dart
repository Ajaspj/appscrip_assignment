import 'package:appscrip_assignment/view/UsersListScreen/widgets/custom_card.dart';
import 'package:appscrip_assignment/view/UsersListScreen/widgets/custom_searchbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appscrip_assignment/controller/usercontroller.dart';
import 'package:appscrip_assignment/view/UsersDetailsScreen/screens/userdetail_screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  UserListScreenState createState() => UserListScreenState();
}

class UserListScreenState extends State<UserListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users List'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBarWidget(
              searchController: searchController,
              onChanged: (value) {
                userProvider.searchUsers(value);
              },
            ),
          ),
        ),
      ),
      body: userProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : userProvider.errorMessage.isNotEmpty
              ? Center(child: Text(userProvider.errorMessage))
              : RefreshIndicator(
                  onRefresh: () => userProvider.fetchUsers(),
                  child: ListView.builder(
                    itemCount: userProvider.users.length,
                    itemBuilder: (context, index) {
                      final user = userProvider.users[index];
                      return UserCardWidget(
                        user: user,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  UserDetailsScreen(user: user),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
    );
  }
}
