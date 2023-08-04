import 'package:flutter/material.dart';
import 'package:projecttaskmanager/style/style.dart';
import 'package:projecttaskmanager/utility/utility.dart';
import 'package:projecttaskmanager/api/apiClient.dart';


class setPasswordScreen extends StatefulWidget {
  const setPasswordScreen({Key? key}) : super(key: key);

  @override
  State<setPasswordScreen> createState() => _setPasswordScreenState();
}

class _setPasswordScreenState extends State<setPasswordScreen> {

  Map<String,String> FormValues = {"email":"","OTP":"","password":"","cpassword":"",};
  bool loading = false;

  initState(){
    callStoreData();
    super.initState();
  }

  callStoreData() async{
    String? OTP = await ReadUserData("OTPVerification");
    String? Email = await ReadUserData("EmailVerification");
    InputOnChange("email", Email);
    InputOnChange("OTP", OTP);
  }

  InputOnChange(Mapkey, Textvalue){
    setState((){
      FormValues.update(Mapkey, (value) => Textvalue);
    });
  }

  FormOnSubmit() async{

    if(FormValues['password']!.length==0){
      ErrorToast("Password Required!");
    }

    else if(FormValues['password']!=FormValues['cpassword']){
      ErrorToast("Confirm password should be same!");
    }

    else{
      setState((){
        loading = true;
      });
      bool res = await SetPasswordRequest(FormValues);
      if(res == true){
        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
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
                Text("Set Password", style: Head1Text(colorDarkBlue),
                ),
                SizedBox(
                  height: 1,
                ),
                Text('Minimum length password 8 character with letter and number combination',style: Head6Text(colorLightGray),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: AppInputDecoration('Password'),
                  onChanged: (Textvalue){
                    InputOnChange("password", Textvalue);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: AppInputDecoration('Confirm Password'),
                  onChanged: (Textvalue){ //to collect the input from the textfield
                    InputOnChange("cpassword", Textvalue);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: ElevatedButton(
                    style: AppButtonStyle(),
                    child: SuccessButtonChild('Confirm'),
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
