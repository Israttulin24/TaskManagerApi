import 'package:flutter/material.dart';
import 'package:projecttaskmanager/api/apiClient.dart';
import 'package:projecttaskmanager/style/style.dart';

class registrationScreen extends StatefulWidget {
  const registrationScreen({Key? key}) : super(key: key);

  @override
  State<registrationScreen> createState() => _registrationScreenState();
}

class _registrationScreenState extends State<registrationScreen> {

  Map<String,String> FormValues = {"email":"","firstName":"","lastName":"","mobile":"","password":"","photo":"","cpassword":"",};
  bool loading = false;

  InputOnChange(Mapkey, Textvalue){
    setState((){
      FormValues.update(Mapkey, (value) => Textvalue);
    });
  }

  FormOnSubmit() async{

    if(FormValues['email']!.length==0){
      ErrorToast("Email Required!");
    }

    else if(FormValues['firstName']!.length==0){
      ErrorToast("First Name Required!");
    }

    else if(FormValues['lastName']!.length==0){
      ErrorToast("Last Name Required!");
    }

    else if(FormValues['mobile']!.length==0){
      ErrorToast("Mobile No. Required!");
    }

    else if(FormValues['password']!.length==0){
      ErrorToast("Password Required!");
    }

    else if(FormValues['password']!=FormValues['cpassword']){
      ErrorToast("Confirm password should be same!");
    }

    else{
      setState((){
        loading = true;
      });
      bool res = await RegistrationRequest(FormValues);
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
          SingleChildScrollView(
            child: loading?(
                Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height/1.3,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                )
            ):(
                Container(
                  margin: EdgeInsets.fromLTRB(30, 70, 30, 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Join With Us", style: Head1Text(colorDarkBlue),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Text('Learn with Rabbil Hasan',style: Head6Text(colorLightGray),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: AppInputDecoration('Email'),
                        onChanged: (Textvalue){
                          InputOnChange("email", Textvalue);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: AppInputDecoration('First Name'),
                        onChanged: (Textvalue){
                          InputOnChange("firstName", Textvalue);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: AppInputDecoration('Last Name'),
                        onChanged: (Textvalue){
                          InputOnChange("lastName", Textvalue);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: AppInputDecoration('Mobile'),
                        onChanged: (Textvalue){
                          InputOnChange("mobile", Textvalue);
                        },
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
                        decoration: AppInputDecoration('Confrim Password'),
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
                          child: SuccessButtonChild('Registration'),
                          onPressed: (){
                            FormOnSubmit();//
                          },
                        ),
                      )

                    ],
                  ),
                )
            )
          )

        ],
      ),

    );
  }
}
