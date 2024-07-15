import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../ChatRoom.dart';
import 'NewGroup.dart';

class Groups extends StatefulWidget {
  const Groups({super.key});

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height*0.9,
      child: Column(
        children: [
          SizedBox(
              height: size.height*0.2,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(),
                  SizedBox(
                    width: size.width*0.2,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const NewGroup())
                        );
                      },
                      child: Stack(
                          children:[
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: size.width*0.005
                                ),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(size.width*0.007),
                                  child: CircleAvatar(
                                    backgroundColor: Theme.of(context).splashColor,
                                    radius: size.width*0.07,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                bottom:2,
                                right:4,
                                child: CircleAvatar(
                                  backgroundColor: Theme.of(context).splashColor,
                                  radius: size.width*0.024,
                                  child: Text('+',style: GoogleFonts.lato(color: Theme.of(context).primaryColorLight),),
                                )
                            )
                          ]
                      ),
                    ),
                  ),
                  AutoSizeText('Create Group',
                    style: GoogleFonts.lato(fontSize:size.width*0.035,fontWeight:FontWeight.bold,color: Theme.of(context).splashColor),
                  ),
                  const SizedBox(),
                ],
              )
          ),
          Expanded(
            child: Container(
              decoration:BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
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
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(size.width*0.1),topRight: Radius.circular(size.width*0.1))
              ),
              child: Center(
                child: SizedBox(
                  width: size.width*0.9,
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: size.height*0.04),
                    itemCount: 7,
                    itemBuilder: (BuildContext context, int index){
                      return SizedBox(
                        height: size.height*0.1,
                        child: Center(
                          child: ListTile(
                            onTap: (){},
                            leading: SizedBox(
                              width:size.width*0.15,
                              child: CircleAvatar(
                                backgroundColor: Theme.of(context).splashColor,
                                radius: size.width*0.07,
                              ),
                            ),
                            title: AutoSizeText('Group Name',
                              style: GoogleFonts.lato(fontSize:size.width*0.055,fontWeight:FontWeight.bold,color: Theme.of(context).splashColor),
                              maxLines: 1,
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                AutoSizeText('Last msg time',
                                  style: GoogleFonts.lato(fontSize:size.width*0.035,color:Theme.of(context).dividerColor),
                                ),
                                CircleAvatar(
                                  backgroundColor: Theme.of(context).disabledColor,
                                  radius: size.width*0.027,
                                  child: AutoSizeText('1',
                                    style: TextStyle(color: Theme.of(context).primaryColorLight),
                                  ),
                                )
                              ],
                            ),
                            subtitle: AutoSizeText('Person Name: Last Message',
                              style: GoogleFonts.lato(fontSize:size.width*0.035,color:Theme.of(context).dividerColor),
                              maxLines: 1,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}