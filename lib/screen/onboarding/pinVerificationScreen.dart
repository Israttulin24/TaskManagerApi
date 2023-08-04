import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:projecttaskmanager/api/apiClient.dart';
import 'package:projecttaskmanager/style/style.dart';
import 'package:projecttaskmanager/utility/utility.dart';

class pinVerificationScreen extends StatefulWidget {
  const pinVerificationScreen({Key? key}) : super(key: key);

  @override
  State<pinVerificationScreen> createState() => _pinVerificationScreenState();
}

class _pinVerificationScreenState extends State<pinVerificationScreen> {

  Map<String,String> FormValues = {"OTP":""};
  bool loading = false;

  InputOnChange(Mapkey, Textvalue){
    setState((){
      FormValues.update(Mapkey, (value) => Textvalue);
    });
  }

  FormOnSubmit() async{
    if(FormValues['OTP']!.length==6) {
      ErrorToast("PIN Required!");
    }

    else{
      setState((){loading = true;});
      String? emailAddress = await ReadUserData('EmailVerification');
      bool res = await VerifyOTPRequest(emailAddress,FormValues['OTP']);
      if(res == true){
        Navigator.pushNamed(context, "/setPassword",);
      }

      else {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ScreenBackground(context),
          Container(
            alignment: Alignment.center,
            child: loading?(Center(child: CircularProgressIndicator(),)):(SingleChildScrollView(
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("PIN verification", style: Head1Text(colorDarkBlue),),
                  SizedBox(
                    height: 10,
                  ),
                  Text("A 6 digit pin has been send to your mobile number", style: Head6Text(colorLightGray),),
                  SizedBox(
                    height: 20,
                  ),
                  PinCodeTextField(
                    appContext: context,
                    length: 6,
                    pinTheme: AppOTPStyle(),
                    animationType: AnimationType.fade,
                    animationDuration: Duration(milliseconds: 300),
                    enableActiveFill: true,
                    onCompleted: (v){

                    },
                    onChanged: (value){
                      InputOnChange("OTP", value);
                    },
                  ),
                  Container(
                    child: ElevatedButton(
                      style: AppButtonStyle(),
                      child: SuccessButtonChild('Verify'),
                      onPressed: (){
                        FormOnSubmit();
                      },
                    ),
                  )
                ],

              ),
            ))
          ),
        ],
      ),
    );
  }
}
