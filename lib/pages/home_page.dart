import 'package:chatezy/services/alert_service.dart';
import 'package:chatezy/services/auth_service.dart';
import 'package:chatezy/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GetIt _getIt = GetIt.instance;
  late AuthService _authService;
  late NavigationService _navigationService;
  late AlertService _alertService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authService = _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>();
    _alertService = _getIt.get<AlertService>();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            "Messages",
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              bool result = await _authService.logout();
              if(result){
                _alertService.showToast(
                  text: "Logged Out!",
                  icon: Icons.check_circle,
                );
                _navigationService.pushReplacementNamed('/login');
              }
            },
            color: Colors.red,
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
      ),
    );
  }
}
