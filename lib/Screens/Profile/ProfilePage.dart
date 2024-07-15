import 'package:auto_size_text/auto_size_text.dart';
import 'package:chat_system/Authentication/Signin.dart';
import 'package:chat_system/userdetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'About.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String currentUser=FirebaseAuth.instance.currentUser!.uid;
  late UserDetails userDetails;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    userDetails=UserDetails(currentUser);
    userDetails.fetchUserDetails().then((_){
      setState(() {
        isLoading=false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Scaffold(
      body: (isLoading) ? const Center(child: CircularProgressIndicator())
      :Container(
        height: size.height,
        width: size.width,
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            SizedBox(
              height:size.height*0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: size.height*0.05,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_outlined,color: Theme.of(context).splashColor,size: size.width*0.07,)
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Theme.of(context).splashColor,
                    radius: size.width*0.12,
                  ),
                  AutoSizeText(userDetails.username,
                    style: GoogleFonts.lato(fontSize:size.width*0.06,fontWeight:FontWeight.bold,color: Theme.of(context).splashColor),
                  ),
                  SizedBox(
                    height: size.height*0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.chat_rounded,size: size.width*0.07,color: Theme.of(context).primaryColorLight),
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Theme.of(context).dividerColor),
                          shape: MaterialStateProperty.all(const CircleBorder())
                        ),
                      ),
                      IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.videocam,size: size.width*0.07,color: Theme.of(context).primaryColorLight,),
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Theme.of(context).dividerColor),
                          shape: MaterialStateProperty.all(const CircleBorder())
                        ),
                      ),
                      IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.call,size: size.width*0.07,color: Theme.of(context).primaryColorLight),
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Theme.of(context).dividerColor),
                          shape: MaterialStateProperty.all(const CircleBorder())
                        ),
                      ),
                      IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.more_horiz,size: size.width*0.07,color: Theme.of(context).primaryColorLight),
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Theme.of(context).dividerColor),
                          shape: MaterialStateProperty.all(const CircleBorder())
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height*0.03,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(size.width*0.1),
                    topLeft: Radius.circular(size.width*0.1),
                  ),
                  border: Border(
                      top: BorderSide(
                          width: size.width*0.005
                      ),
                      left: BorderSide(
                          width: size.width*0.005
                      ),
                      right: BorderSide(
                          width: size.width*0.005
                      )
                  ),
                ),
                child: Center(
                  child: SizedBox(
                    width: size.width*0.9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: size.height*0.05,
                        ),
                        ListTile(
                          onTap: (){},
                          leading: Icon(Icons.person_outline,color:Theme.of(context).dividerColor,size: size.width*0.07,),
                          title: AutoSizeText('Display Name',
                            style: GoogleFonts.lato(fontSize:size.width*0.04,color:Theme.of(context).dividerColor),
                          ),
                          subtitle: AutoSizeText(userDetails.name,
                            style: GoogleFonts.lato(fontSize:size.width*0.05,color:Theme.of(context).splashColor,fontWeight:FontWeight.bold),
                          ),
                          trailing: Icon(Icons.mode_edit_outline_outlined,color: Theme.of(context).splashColor,),
                        ),
                        Divider(
                          height: 0,
                          color: Theme.of(context).splashColor,
                          thickness: size.width*0.003,
                        ),
                        ListTile(
                          leading: Icon(Icons.email_outlined,color:Theme.of(context).dividerColor,size: size.width*0.07,),
                          title: AutoSizeText('Email Address',
                            style: GoogleFonts.lato(fontSize:size.width*0.04,color:Theme.of(context).dividerColor),
                          ),
                          subtitle: AutoSizeText(userDetails.email,
                            style: GoogleFonts.lato(fontSize:size.width*0.05,color:Theme.of(context).splashColor,fontWeight:FontWeight.bold),
                          ),
                        ),
                        Divider(
                          height: 0,
                          color: Theme.of(context).splashColor,
                          thickness: size.width*0.003,
                        ),
                        ListTile(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const About()));
                          },
                          leading: Icon(Icons.info_outline,color:Theme.of(context).dividerColor,size: size.width*0.07,),
                          title: AutoSizeText('About',
                            style: GoogleFonts.lato(fontSize:size.width*0.04,color:Theme.of(context).dividerColor),
                          ),
                          subtitle: AutoSizeText('About',
                            style: GoogleFonts.lato(fontSize:size.width*0.05,color:Theme.of(context).splashColor,fontWeight:FontWeight.bold),
                          ),
                          trailing: Icon(Icons.mode_edit_outline_outlined, color: Theme.of(context).splashColor,),
                        ),
                        Divider(
                          height: 0,
                          color: Theme.of(context).splashColor,
                          thickness: size.width*0.003,
                        ),
                        SizedBox(
                          height: size.height*0.02,
                        ),
                        TextButton(
                          onPressed: () async{
                            await FirebaseAuth.instance.signOut();
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignIn()));
                          },
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                            minimumSize: MaterialStateProperty.all(const Size(0,0))
                          ),
                          child: AutoSizeText('Sign Out',
                            style: GoogleFonts.lato(fontSize:size.width*0.06,fontWeight:FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: size.height*0.12,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}