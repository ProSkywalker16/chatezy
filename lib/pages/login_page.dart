import 'package:chatezy/consts.dart';
import 'package:chatezy/services/auth_service.dart';
import 'package:chatezy/services/navigation_service.dart';
import 'package:chatezy/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './login_page.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GetIt _getIt = GetIt.instance;

  final GlobalKey<FormState> _loginFormKey = GlobalKey();

  late AuthService _authService;
  late NavigationService _navigationService;



  String? email, password;

  @override
  void initState() {
    
    super.initState();
    _authService = _getIt.get<AuthService>();
    _navigationService = _getIt.get<NavigationService>();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 59, 65, 243),
              Color.fromARGB(255, 107, 235, 235),
            ],
          ),
        ),
        child: _buildUI(),
      ),
    );
  }

  Widget _buildUI() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 20.0,
        ),
        child: Column(
          children: [
            _headerText(),
            _loginForm(),
            _createAnAccountLink(),
          ],
        ),
      ),
    );
  }

  Widget _headerText() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      //height: MediaQuery.sizeOf(context).height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Hello There",
              style: GoogleFonts.roboto(
                fontSize: 32.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          Center(
            child: Text(
              "Welcome back!",
              style: GoogleFonts.roboto(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(246, 193, 206, 93),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginForm() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.40,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height * 0.05,
      ),
      child: SingleChildScrollView(
        child: Form(
          key:_loginFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Theme(
                data: Theme.of(context).copyWith(
                  inputDecorationTheme: InputDecorationTheme(
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    CustomFormField(
                      height: MediaQuery.sizeOf(context).height * 0.1,
                      hintText: "E-mail",
                      validationRegEx: EMAIL_VALIDATION_REGEX,
                      onSaved: (value){
                        setState(() {
                          email=value;
                        });
                      },
                    ),
                    SizedBox(height: 40), // Add vertical space
                    CustomFormField(
                      height: MediaQuery.sizeOf(context).height * 0.1,
                      hintText: "Password",
                      validationRegEx: PASSWORD_VALIDATION_REGEX,
                      obscureText: true,
                      onSaved: (value){
                        setState(() {
                          password=value;
                        });
                      },
                    ),
                    
                    SizedBox(height: 40),
                    _loginButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: MaterialButton(
          onPressed: () async {
            if(_loginFormKey.currentState?.validate() ?? false){
              _loginFormKey.currentState?.save();
              bool result = await _authService.login(email!, password!);
              print(result);
              if(result)
              {
                _navigationService.pushReplacementNamed('/home');
              }else{

              }
              
            }
          },
          color: Color.fromARGB(255, 252, 180, 85),
          child: const Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }

  Widget _createAnAccountLink() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "Don't have an account?",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color.fromARGB(255, 255, 243, 25),
            ),
          ),
          Text(
            " Sign Up",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color.fromARGB(255, 252, 252, 252),
            ),
          )
        ],
      ),
    );
  }
}
