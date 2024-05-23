import 'dart:io';

import 'package:chatezy/consts.dart';
import 'package:chatezy/services/media_service.dart';
import 'package:chatezy/services/navigation_service.dart';
import 'package:chatezy/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GetIt _getIt = GetIt.instance;
  late MediaService _mediaService;
  late NavigationService _navigationService;
  String? email, password, name;

  @override
  void initState() {
    super.initState();
    _mediaService = _getIt.get<MediaService>();
    _navigationService = _getIt.get<NavigationService>();
  }

  File? selectedImage;
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
            SingleChildScrollView(
              child: _registerForm(),
            ),
             _LoginAccountLink(),
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
              "Let's get going!",
              style: GoogleFonts.roboto(
                fontSize: 32.0,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 255, 243, 25),
              ),
            ),
          ),
          Center(
            child: Text(
              "Registration form ↓",
              style: GoogleFonts.roboto(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 252, 252, 252),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _registerForm() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height * 0.05,
      ),
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _pfpSelectionField(),
            SizedBox(height: 20),
            CustomFormField(
                hintText: "Name",
                height: MediaQuery.sizeOf(context).height * 0.1,
                validationRegEx: NAME_VALIDATION_REGEX,
                onSaved: (value) {
                  setState(() {
                    name = value;
                  });
                }),
            CustomFormField(
                hintText: "E-mail",
                height: MediaQuery.sizeOf(context).height * 0.1,
                validationRegEx: EMAIL_VALIDATION_REGEX,
                onSaved: (value) {
                  setState(() {
                    email = value;
                  });
                }),
            CustomFormField(
                hintText: "Password",
                height: MediaQuery.sizeOf(context).height * 0.1,
                validationRegEx: PASSWORD_VALIDATION_REGEX,
                onSaved: (value) {
                  setState(() {
                    password = value;
                  });
                }),
            SizedBox(height: 20),
            _registerButton()
          ],
        ),
      ),
    );
  }

  Widget _pfpSelectionField() {
    return GestureDetector(
      onTap: () async {
        File? file = await _mediaService.getImageFromGallery();
        if (file != null) {
          setState(() {
            selectedImage = file;
          });
        }
      },
      child: CircleAvatar(
        radius: MediaQuery.of(context).size.width * 0.20,
        backgroundImage: selectedImage != null
            ? FileImage(selectedImage!)
            : AssetImage('assets/images/seb image.png') as ImageProvider,
      ),
    );
  }

  Widget _registerButton() {
    return SizedBox(
      height: 45,
      width: MediaQuery.sizeOf(context).width,
      child: MaterialButton(
        color: Color.fromARGB(255, 252, 180, 85),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: () {},
        child: const Text(
          "SignUP",
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  Widget _LoginAccountLink() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "Do you already have an account?",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color:Color.fromARGB(255, 252, 252, 252),
            ),
          ),
          GestureDetector(
            onTap:(){
              _navigationService.pushReplacementNamed('/login');
            },
            child: Text(
              " Login",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color:  Color.fromARGB(255, 255, 243, 25),
              ),
            ),
          )
        ],
      ),
    );
  }
}
