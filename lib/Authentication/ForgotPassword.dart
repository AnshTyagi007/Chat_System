import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController=TextEditingController();
  bool isEmailFocused=false;

  @override
  void dispose() {
    emailController.dispose();
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
        });
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(207, 226, 238, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(207, 226, 238, 1),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_sharp),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: size.width*0.85,
              height: size.height*0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: size.height*0.2,
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText('Forgot Password',
                          style:GoogleFonts.lato(fontSize:size.width*0.07,fontWeight:FontWeight.bold),
                        ),
                        SizedBox(
                          width:size.width*0.6,
                          height: size.height*0.1,
                          child: Center(
                            child: AutoSizeText('Enter the email address to recover your password.',
                              style:GoogleFonts.lato(fontSize:size.width*0.035,color:const Color.fromARGB(255, 70, 70, 70)),
                              maxLines: 3,
                            ),
                          ),
                        )
                      ],
                    )
                  ),
                  Card(
                    elevation: 5,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    color: const Color.fromRGBO(255, 250, 250, 250),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size.width*0.02)
                    ),
                    child: Container(
                      color: isEmailFocused?Colors.white:Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                        child: TextField(
                          onTap: (){
                            setState(() {
                              isEmailFocused=true;
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
                      onTap: (){},
                      child: Center(
                        child: AutoSizeText('Send Password',
                          style: GoogleFonts.lato(fontSize:size.width*0.05,fontWeight:FontWeight.bold,color:Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.4,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
