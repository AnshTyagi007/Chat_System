import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Theme.of(context).primaryColorLight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: size.height*0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_outlined,color: Theme.of(context).splashColor,size: size.width*0.07,)
                  ),
                ),
                AutoSizeText('About',
                  style: GoogleFonts.lato(fontSize: size.width*0.06,fontWeight: FontWeight.w600,color: Theme.of(context).splashColor),
                ),
                SizedBox(width: size.width*0.5,),
                IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.more_vert,color: Theme.of(context).splashColor,size: size.width*0.07,)
                ),
              ],
            ),
            const SizedBox(),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: size.width*0.05,),
                    AutoSizeText('Currently set to',
                      style: GoogleFonts.lato(fontSize: size.width*0.04,fontWeight: FontWeight.w600,color: Theme.of(context).dividerColor),
                    ),
                  ],
                ),
                SizedBox(height: size.height*0.01,),
                ListTile(
                  onTap: (){},
                  title: AutoSizeText('About',
                    style: GoogleFonts.lato(fontSize:size.width*0.045,color:Theme.of(context).splashColor,fontWeight: FontWeight.w600),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                  trailing: Icon(Icons.mode_edit_outline_outlined, color: Theme.of(context).splashColor,),
                ),
              ],
            ),
            const SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: size.width*0.05,),
                AutoSizeText('Select About',
                  style: GoogleFonts.lato(fontSize: size.width*0.04,fontWeight: FontWeight.w600,color: Theme.of(context).dividerColor),
                ),
              ],
            ),
            SizedBox(
              height: size.height*0.7,
              child: ListView.builder(
                itemCount: 8,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    onTap: (){},
                    title: AutoSizeText('About',
                      style: GoogleFonts.lato(fontSize:size.width*0.045,color:Theme.of(context).splashColor,fontWeight: FontWeight.w600),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
