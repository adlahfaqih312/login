import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/Controller/db_con.dart';
import 'package:login/View/notes_screen.dart';
import 'package:login/View/signup_screen.dart';
import 'package:login/utils/const_value.dart';
import 'package:login/utils/shared_preferences_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = true;
  bool rememberMe = false;

  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  getData(){
      SharedPreferencesHelper().getPrefBool(key: ConstValue.rememberMe, defaultValue: false);
      if(rememberMe){
        emailController.text=SharedPreferencesHelper().getPrefString(key: ConstValue.email, defaultValue: "");
        passwordController.text=SharedPreferencesHelper().getPrefString(key: ConstValue.password, defaultValue: "");
        setState(() {});
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            Center(
              child: Image.asset("assets/images/Note.jpg",height: 200,width: 200,),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  label: Text(AppLocalizations.of(context)!.email),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16))
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: passwordController,
              obscureText: showPassword,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  suffixIcon: IconButton(onPressed: (){
                    showPassword=!showPassword;
                    setState(() {});
                  }, icon: Icon(showPassword?Icons.visibility:Icons.visibility_off),),
                  label: Text(AppLocalizations.of(context)!.password),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16))
              ),
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Checkbox(value: rememberMe,
                    onChanged: (value){rememberMe=value!;setState(() {});},
                    ),
                Text(AppLocalizations.of(context)!.rememberMe),
              ],
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: () async{
              DbController dbController = DbController();
             bool response= await dbController.login(email: emailController.text, password: passwordController.text);
             if(response){
                if(rememberMe) {
                  SharedPreferencesHelper().savePrefString(key: ConstValue.email, value: emailController.text);
                  SharedPreferencesHelper().savePrefString(key: ConstValue.password, value: passwordController.text);

              }
                else {
                      await SharedPreferencesHelper().remove(key: ConstValue.email);
                      await SharedPreferencesHelper().remove(key: ConstValue.password);
                      }
                  SharedPreferencesHelper().savePrefBool(
                      key: ConstValue.rememberMe, value: rememberMe);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NotesScreen()));
                  setState(() {});
              }
             else{
               showDialog(context: context,
                   builder: (context){
                     return AlertDialog(title: Text(AppLocalizations.of(context)!.error),content: Text(AppLocalizations.of(context)!.emailOrPasswordIsIncorrect),actions: [
                       TextButton(onPressed: (){
                         Navigator.pop(context);
                       }, child: Text(AppLocalizations.of(context)!.ok))
                     ],);
                   });
             }
             }
             ,child: Text(AppLocalizations.of(context)!.login)),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
            }, child: Text(AppLocalizations.of(context)!.register)),
          ],
        ),
        )
      ),
    );
  }
}
