import 'package:flutter/material.dart';
import 'package:flutter_application_1/Utilits/constants/colorconstant.dart';
import 'package:flutter_application_1/Utilits/constants/text_constants.dart';
import 'package:flutter_application_1/widgets/Secondcustom_image_container.dart';
import 'package:flutter_application_1/widgets/custom_button.dart';


class PasswordResetSuccessfull extends StatelessWidget {
  const PasswordResetSuccessfull({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(TextConstants.resetpasssucces,
                style: TextStyle(
                  color: Colorconstants.bluegreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),),
                SizedBox(height: 30,),
                seconcustomimage_container(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(TextConstants.havesucces),
                ),
                CustomButton(text: TextConstants.login, color:  Colorconstants.primaryblue)
          ],
        ),
      ),
    );
  }
}