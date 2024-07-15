import 'package:auto_size_text/auto_size_text.dart';
import 'package:chat_system/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ForgotPassword.dart';
import 'SignUp.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  bool isEmailFocused=false;
  bool isPasswordFocused=false;
  bool passwordVisible=false;

  void signIn(String email, String password) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyHomePage()));
    }
    on FirebaseAuthException catch(e){
      if(e.code == 'User-not-found'){
        debugPrint('No user found for this email');
      }
      else if(e.code == 'Wrong-password'){
        debugPrint('Wrong password provided for that user');
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
        setState(() {
          isEmailFocused=false;
          isPasswordFocused=false;
        });
      },
      child: Scaffold(
        body:Container(
          color: const Color.fromRGBO(199, 230, 255, 1),
          width:size.width,
          height:size.height,
          child:Column(
            children: [
              SizedBox(
                height:size.height*0.4,
                child:Stack(
                  children: [
                    Positioned(
                      left: size.width*0.03,
                      top:size.height*0.01,
                      child: Image.asset('assets/images/SignIn.gif',
                        height:size.height*0.25,
                        fit:BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      left: size.width*0.08,
                      top:size.height*0.285,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeText('Sign In',
                            style:GoogleFonts.lato(fontSize:size.width*0.07,fontWeight:FontWeight.bold),
                          ),
                          SizedBox(
                            width:size.width*0.5,
                            height: size.height*0.05,
                            child: AutoSizeText('Log in to your existing account by entering your details.',
                              style:GoogleFonts.lato(fontSize:size.width*0.035,color:const Color.fromARGB(255, 70, 70, 70)),
                              maxLines: 2,
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      right:size.width*0.01,
                      top:size.height*0.05,
                      child: SizedBox(
                        width:size.width*0.4,
                        height:size.height*0.22,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText('Chatify',
                                style:GoogleFonts.lato(fontSize:size.width*0.07,fontWeight:FontWeight.bold,color:const Color.fromARGB(255, 39, 84, 121)),
                                textAlign:TextAlign.start
                            ),
                            AutoSizeText('Where Conversations Come to Life!',
                              style:GoogleFonts.lato(fontSize:size.width*0.055,color:const Color.fromARGB(255, 101, 151, 193)),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ),
              Expanded(
                child: Container(
                  decoration:BoxDecoration(
                    color: const Color.fromRGBO(207, 226, 238, 1),
                    border: Border.all(
                      width: size.width*0.005
                    ),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(size.width*0.1),topRight: Radius.circular(size.width*0.1))
                  ),
                  child: Center(
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: size.width*0.85,
                        height: size.height*0.6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: size.height*0.01,
                            ),
                            Card(
                              color:const Color.fromARGB(255, 250, 250, 250),
                              elevation: 5,
                              shadowColor: Colors.grey.withOpacity(0.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(size.width*0.02)
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    color: isEmailFocused?Colors.white:Colors.transparent,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal:size.width*0.05),
                                      child: TextField(
                                        onTap: (){
                                          setState(() {
                                            isEmailFocused=true;
                                            isPasswordFocused=false;
                                          });
                                        },
                                        controller: emailController,
                                        onChanged: (value){
                                          setState(() {});
                                        },
                                        keyboardType: TextInputType.emailAddress,
                                        maxLines: 1,
                                        cursorColor: Colors.black,
                                        style: GoogleFonts.lato(fontSize:size.width*0.035),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(vertical: size.height*0.025),
                                          labelText: 'Email Address',
                                          labelStyle: GoogleFonts.lato(fontSize:size.width*0.035,color:isEmailFocused?Colors.deepPurple:Colors.black),
                                          enabledBorder: InputBorder.none,
                                          prefixIcon: const Icon(Icons.email_outlined),
                                          suffixIcon: IconButton(
                                            onPressed: (){
                                              setState(() {
                                                emailController.clear();
                                              });
                                            },
                                            icon: Icon(emailController.text.isNotEmpty?Icons.close:null)
                                          )
                                        ),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    thickness: size.width*0.002,
                                    height: 0,
                                  ),
                                  Container(
                                    color: isPasswordFocused?Colors.white:Colors.transparent,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal:size.width*0.05),
                                      child: TextField(
                                        onTap: (){
                                          setState(() {
                                            isEmailFocused=false;
                                            isPasswordFocused=true;
                                          });
                                        },
                                        controller: passwordController,
                                        keyboardType: TextInputType.visiblePassword,
                                        maxLines: 1,
                                        obscureText: !passwordVisible,
                                        cursorColor: Colors.black,
                                        style: GoogleFonts.lato(fontSize:size.width*0.035),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(vertical: size.height*0.025),
                                          labelText: 'Password',
                                          labelStyle: GoogleFonts.lato(fontSize:size.width*0.035,color:isPasswordFocused?Colors.deepPurple:Colors.black),
                                          enabledBorder: InputBorder.none,
                                          prefixIcon: const Icon(Icons.lock_outline),
                                          suffixIcon: IconButton(
                                            onPressed: (){
                                              setState(() {
                                                passwordVisible=!passwordVisible;
                                              });
                                            },
                                            icon: Icon(passwordVisible?Icons.visibility_off:Icons.visibility)
                                          )
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            TextButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(EdgeInsets.zero),
                                minimumSize: MaterialStateProperty.all(const Size(0,0))
                              ),
                              onPressed: (){
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(builder: (context) => const ForgotPassword())
                                );
                              },
                              child: AutoSizeText('Forgot Password',
                                style: GoogleFonts.lato(fontSize:size.width*0.035,fontWeight:FontWeight.bold,color:Colors.deepPurple),
                              )
                            ),
                            Container(
                              height: size.height*0.07,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: <Color>[
                                    Color.fromRGBO(117, 75, 225, 1),
                                    Color.fromRGBO(48, 77, 251, 1),
                                  ],
                                  begin: Alignment.topLeft,
                                  end:Alignment.bottomLeft,
                                  stops: [0, 1],
                                ),
                                borderRadius: BorderRadius.circular(size.width*0.025)
                              ),
                              child: InkWell(
                                onTap: (){
                                  signIn(emailController.text.trim(), passwordController.text.trim());
                                },
                                child: Center(
                                  child: AutoSizeText('Sign In',
                                    style: GoogleFonts.lato(fontSize:size.width*0.05,fontWeight:FontWeight.bold,color:Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            AutoSizeText('or Sign in with',
                              style: GoogleFonts.lato(fontSize:size.width*0.035,color:Colors.black),
                            ),
                            Container(
                              height: size.height*0.07,
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: <Color>[
                                      Color.fromRGBO(117, 75, 225, 1),
                                      Color.fromRGBO(48, 77, 251, 1),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomLeft,
                                    stops: [0, 1]
                                  ),
                                  borderRadius: BorderRadius.circular(size.width*0.025)
                              ),
                              child: InkWell(
                                onTap: (){},
                                child: Center(
                                  child: AutoSizeText('Sign up with google',
                                    style: GoogleFonts.lato(fontSize:size.width*0.045,fontWeight:FontWeight.bold,color:Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AutoSizeText('Don''t have an account? Let''s ',
                                  style: GoogleFonts.lato(fontSize:size.width*0.035,color:Colors.black),
                                ),
                                TextButton(
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                                    minimumSize: MaterialStateProperty.all(const Size(0,0))
                                  ),
                                  onPressed: (){
                                    Navigator.pushReplacement(
                                      context, MaterialPageRoute(builder: (context) => const SignUp())
                                    );
                                  },
                                  child: AutoSizeText('Sign Up',
                                    style: GoogleFonts.lato(fontSize:size.width*0.035,fontWeight:FontWeight.bold,color:Colors.deepPurple),
                                  )
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height*0.05,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        )
      ),
    );
  }
}