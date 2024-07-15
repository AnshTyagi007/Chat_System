import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../theme.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  void showCustomDialog(BuildContext context, Size size){
    final themeProvider=Provider.of<ThemeProvider>(context, listen: false);
    bool isDark=themeProvider.isDark;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Theme.of(context).primaryColorLight,
          child: SizedBox(
            width: size.width*0.85,
            height: size.height*0.3,
            child: Center(
              child: SizedBox(
                height: size.height*0.25,
                width: size.width*0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText('Choose theme',
                      style: GoogleFonts.lato(fontWeight: FontWeight.bold,fontSize: size.width*0.06,color: Theme.of(context).splashColor),
                    ),
                    ListTile(
                      onTap: (){
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme(false);
                        setState(() {
                          isDark=false;
                        });
                      },
                      leading:Icon(Icons.adjust_sharp,color: (isDark)?Theme.of(context).dividerColor:Colors.green,),
                      title: AutoSizeText('Light',
                        style: GoogleFonts.lato(fontSize:size.width*0.045,color:Theme.of(context).splashColor,fontWeight: FontWeight.w600),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                    ),
                    ListTile(
                      onTap: (){
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme(true);
                        setState(() {
                          isDark=true;
                        });
                      },
                      leading:Icon(Icons.adjust_sharp,color: (isDark)?Colors.green:Theme.of(context).dividerColor,),
                      title: AutoSizeText('Dark',
                        style: GoogleFonts.lato(fontSize:size.width*0.045,color:Theme.of(context).splashColor,fontWeight: FontWeight.w600),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: AutoSizeText('Cancel',
                            style: GoogleFonts.lato(fontWeight: FontWeight.w500,color: Colors.green,fontSize: size.width*0.045),
                          ),
                        ),
                        TextButton(
                          onPressed: (){
                            Provider.of<ThemeProvider>(context, listen: false)
                                .applyTheme(); // Apply selected theme
                            Navigator.pop(context);
                          },
                          child: AutoSizeText('ok',
                            style: GoogleFonts.lato(fontWeight: FontWeight.w500,color:Colors.green,fontSize: size.width*0.045),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: AutoSizeText('Settings',
          style: GoogleFonts.lato(fontSize: size.width*0.06,color:Theme.of(context).splashColor,fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.search,size: size.width*0.07,color:Theme.of(context).splashColor)
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).primaryColorLight,
        child: Column(
          children: [
            ListTile(
              onTap: (){
                showCustomDialog(context, size);
              },
              leading: Icon(Icons.light_mode,color:Theme.of(context).dividerColor),
              title: AutoSizeText('Theme',
                style: GoogleFonts.lato(fontSize:size.width*0.045,color:Theme.of(context).splashColor,fontWeight: FontWeight.w600),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: size.width*0.05,vertical: size.height*0.005),
            ),
            ListTile(
              onTap: (){},
              leading: Icon(Icons.key_sharp,color:Theme.of(context).dividerColor),
              title: AutoSizeText('Account',
                style: GoogleFonts.lato(fontSize:size.width*0.045,color:Theme.of(context).splashColor,fontWeight: FontWeight.w600),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: size.width*0.05,vertical: size.height*0.005),
            ),
            ListTile(
              onTap: (){},
              leading: Icon(Icons.lock_outline_sharp,color:Theme.of(context).dividerColor),
              title: AutoSizeText('Privacy',
                style: GoogleFonts.lato(fontSize:size.width*0.045,color:Theme.of(context).splashColor,fontWeight: FontWeight.w600),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: size.width*0.05,vertical: size.height*0.005),
            ),
            ListTile(
              onTap: (){},
              leading: Icon(Icons.chat,color:Theme.of(context).dividerColor),
              title: AutoSizeText('Chats',
                style: GoogleFonts.lato(fontSize:size.width*0.045,color:Theme.of(context).splashColor,fontWeight: FontWeight.w600),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: size.width*0.05,vertical: size.height*0.005),
            ),
            ListTile(
              onTap: (){},
              leading: Icon(Icons.notifications_none,color:Theme.of(context).dividerColor),
              title: AutoSizeText('Notifications',
                style: GoogleFonts.lato(fontSize:size.width*0.045,color:Theme.of(context).splashColor,fontWeight: FontWeight.w600),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: size.width*0.05,vertical: size.height*0.005),
            ),
            ListTile(
              onTap: (){},
              leading: Icon(Icons.help_outline,color:Theme.of(context).dividerColor),
              title: AutoSizeText('Help',
                style: GoogleFonts.lato(fontSize:size.width*0.045,color:Theme.of(context).splashColor,fontWeight: FontWeight.w600),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: size.width*0.05,vertical: size.height*0.005),
            ),
          ],
        ),
      ),
    );
  }
}