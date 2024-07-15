import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Signin.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController usernameController=TextEditingController();
  bool isUsernameFocused=false;
  bool isNameFocused=false;
  bool isEmailFocused=false;
  bool isPasswordFocused=false;
  bool passwordVisible=false;
  
  Future<bool> isDuplicateUserName(String username) async{
    QuerySnapshot query = await FirebaseFirestore.instance.collection('Users').where('username', isEqualTo:username).get();
    return query.docs.isNotEmpty;
  }

  Future<void> setUserDetails(String userId, String username, String name, String email) async{
    try{
      await FirebaseFirestore.instance.collection('Users').doc(userId).set({
        'userId':userId,
        'name':name,
        'username':username,
        'email':email
      });
    }catch(e){
      debugPrint("Failed to store User Details:$e");
    }
  }

  Future<void> signUp(String username, String name,String email, String password) async {
    if(await isDuplicateUserName(username)){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('This User Name is already taken.'),
          behavior:SnackBarBehavior.floating,
          margin: EdgeInsets.only(
              bottom:MediaQuery.of(context).size.height * 0.85
          ),
        ),
      );
    }
    else{
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String? userId= credential.user?.uid;
        await setUserDetails(userId!, username, name, email);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          debugPrint('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          debugPrint('The account already exists for that email.');
        }
      } catch (e) {
        debugPrint(e as String?);
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
          isUsernameFocused=false;
          isNameFocused=false;
          isEmailFocused=false;
          isPasswordFocused=false;
        });
      },
      child: Scaffold(
          body:SingleChildScrollView(
            child: Container(
                color: const Color.fromRGBO(207, 226, 238, 1),
                width:size.width,
                height:size.height,
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: size.height*0.2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              height:size.height*0.025
                          ),
                          AutoSizeText('Create Account',
                            style:GoogleFonts.lato(fontSize:size.width*0.06,fontWeight:FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AutoSizeText('on ',
                                style:GoogleFonts.lato(fontSize:size.width*0.06,fontWeight:FontWeight.bold),
                              ),
                              AutoSizeText('Chatify',
                                  style:GoogleFonts.lato(fontSize:size.width*0.075,fontWeight:FontWeight.bold,color:const Color.fromARGB(255, 39, 84, 121)),
                                  textAlign:TextAlign.start
                              ),
                            ],
                          ),
                          SizedBox(
                            height:size.height*0.015
                          ),
                          AutoSizeText('Fill your information below or register\nwith your social account.',
                            style:GoogleFonts.lato(fontSize:size.width*0.035,fontWeight:FontWeight.bold,color:const Color.fromARGB(255, 70, 70, 70)),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width*0.85,
                      height: size.height*0.7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: isUsernameFocused?Colors.white: const Color.fromRGBO(235, 232, 241, 1),
                                borderRadius: BorderRadius.all(Radius.circular(size.width*0.01)),
                                border: Border.all(width: size.width*0.002)
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: size.width*0.17,
                                right:size.width*0.05
                              ),
                              child: TextField(
                                onTap: (){
                                  setState(() {
                                    isUsernameFocused=true;
                                    isNameFocused=false;
                                    isEmailFocused=false;
                                    isPasswordFocused=false;
                                  });
                                },
                                controller: usernameController,
                                onChanged: (value){
                                  setState(() {});
                                },
                                maxLines: 1,
                                cursorColor: Colors.black,
                                style: GoogleFonts.lato(fontSize:size.width*0.035),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: size.height*0.015),
                                    labelText: 'User Name',
                                    labelStyle: GoogleFonts.lato(fontSize:size.width*0.035,color:isUsernameFocused?Colors.deepPurple:Colors.black),
                                    enabledBorder: InputBorder.none,
                                    suffixIcon: IconButton(
                                        onPressed: (){
                                          setState(() {
                                            usernameController.clear();
                                          });
                                        },
                                        icon: Icon(usernameController.text.isNotEmpty?Icons.close:null)
                                    )
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: isNameFocused?Colors.white: const Color.fromRGBO(235, 232, 241, 1),
                              borderRadius: BorderRadius.all(Radius.circular(size.width*0.01)),
                              border: Border.all(width: size.width*0.002)
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal:size.width*0.05),
                              child: TextField(
                                onTap: (){
                                  setState(() {
                                    isNameFocused=true;
                                    isUsernameFocused=false;
                                    isEmailFocused=false;
                                    isPasswordFocused=false;
                                  });
                                },
                                controller: nameController,
                                onChanged: (value){
                                  setState(() {});
                                },
                                keyboardType: TextInputType.name,
                                maxLines: 1,
                                cursorColor: Colors.black,
                                style: GoogleFonts.lato(fontSize:size.width*0.035),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: size.height*0.015),
                                    labelText: 'Display Name',
                                    labelStyle: GoogleFonts.lato(fontSize:size.width*0.035,color:isNameFocused?Colors.deepPurple:Colors.black),
                                    enabledBorder: InputBorder.none,
                                    prefixIcon: const Icon(Icons.person_outline),
                                    suffixIcon: IconButton(
                                        onPressed: (){
                                          setState(() {
                                            nameController.clear();
                                          });
                                        },
                                        icon: Icon(nameController.text.isNotEmpty?Icons.close:null)
                                    )
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: isEmailFocused?Colors.white: const Color.fromRGBO(235, 232, 241, 1),
                              borderRadius: BorderRadius.all(Radius.circular(size.width*0.01)),
                              border: Border.all(width: size.width*0.002)
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal:size.width*0.05),
                              child: TextField(
                                onTap: (){
                                  setState(() {
                                    isEmailFocused=true;
                                    isUsernameFocused=false;
                                    isNameFocused=false;
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
                                    contentPadding: EdgeInsets.symmetric(vertical: size.height*0.015),
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
                          Container(
                            decoration: BoxDecoration(
                              color: isPasswordFocused?Colors.white: const Color.fromRGBO(235, 232, 241, 1),
                              borderRadius: BorderRadius.all(Radius.circular(size.width*0.01)),
                              border: Border.all(width: size.width*0.002)
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal:size.width*0.05),
                              child: TextField(
                                onTap: (){
                                  setState(() {
                                    isNameFocused=false;
                                    isUsernameFocused=false;
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
                                    contentPadding: EdgeInsets.symmetric(vertical: size.height*0.015),
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
                          ),
                          const SizedBox(),
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
                                signUp(usernameController.text.trim(), nameController.text.trim(),emailController.text.trim(), passwordController.text.trim());
                              },
                              child: Center(
                                child: AutoSizeText('Sign Up',
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
                              AutoSizeText('Already have an account? ',
                                style: GoogleFonts.lato(fontSize:size.width*0.035,color:Colors.black),
                              ),
                              TextButton(
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                                      minimumSize: MaterialStateProperty.all(const Size(0,0))
                                  ),
                                  onPressed: (){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignIn()));
                                  },
                                  child: AutoSizeText('Sign In',
                                    style: GoogleFonts.lato(fontSize:size.width*0.035,fontWeight:FontWeight.bold,color:Colors.deepPurple),
                                  )
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )
            ),
          )
      ),
    );
  }
}
