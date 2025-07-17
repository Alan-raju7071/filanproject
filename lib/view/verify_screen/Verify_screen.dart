import 'package:flutter/material.dart';
import 'package:flutter_application_1/Utilits/constants/colorconstant.dart';
import 'package:flutter_application_1/Utilits/constants/text_constants.dart';
import 'package:flutter_application_1/view/login_screen/Login_screen.dart';
import 'package:flutter_application_1/widgets/custom_button.dart';


class VerifyScreen extends StatelessWidget {
  const VerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TextConstants.verify),
      ),
      body: Column(
        children: [
          Spacer(),
          InkWell(
             onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: CustomButton(text: TextConstants.continu, color: Colorconstants.primaryblue))
        ],
      ),
    );
  }
}