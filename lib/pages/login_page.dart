import 'package:chatezy/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './login_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
          children: [_headerText(), _loginForm()],
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
    child: Form(
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
                  height: MediaQuery.sizeOf(context).height*0.1,
                  hintText: "E-mail",
                ),
                SizedBox(height: 50), // Add vertical space
                CustomFormField(
                  height: MediaQuery.sizeOf(context).height*0.1,
                  hintText: "Passcode",
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}
