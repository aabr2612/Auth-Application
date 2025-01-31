import 'User.dart';

class UserManager {
  static final UserManager _instance = UserManager._internal();

  factory UserManager() => _instance;

  UserManager._internal();

  List<User> users = [];

  void addUser(String username, String password) {
    if (!userExists(username)) {
      users.add(User(username, password));
    }
  }

  bool userExists(String username) {
    return users.any((user) => user.username == username);
  }

  bool authenticateUser(String username, String password) {
    return users
        .any((user) => user.username == username && user.password == password);
  }
}
