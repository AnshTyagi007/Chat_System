import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewGroup extends StatefulWidget {
  const NewGroup({super.key});

  @override
  State<NewGroup> createState() => _NewGroupState();
}

class _NewGroupState extends State<NewGroup> {
  int listViewItemCount=1;
  int gridViewItemCount=10;
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_sharp,color: Theme.of(context).splashColor,),
        ),
        title: AutoSizeText('Create Group',
          style: GoogleFonts.lato(fontSize:size.width*0.05,fontWeight:FontWeight.bold,color: Theme.of(context).splashColor),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: size.width*0.9,
          height: size.height*0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: size.height*0.15,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AutoSizeText('Group Description',
                      style: GoogleFonts.lato(fontSize:size.width*0.04,color:Theme.of(context).dividerColor,),
                      maxLines: 1,
                    ),
                    AutoSizeText('Make Group\nfor Team Work',
                      style: GoogleFonts.lato(fontSize:size.width*0.08,fontWeight:FontWeight.bold,color: Theme.of(context).splashColor),
                    )
                  ],
                )
              ),
              SizedBox(
                  height: size.height*0.13,
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText('Group Admin',
                        style: GoogleFonts.lato(fontSize:size.width*0.04,color:Theme.of(context).dividerColor,),
                        maxLines: 1,
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).splashColor,
                          radius: size.width*0.06,
                        ),
                        title: AutoSizeText('Admin Name',
                          style: GoogleFonts.lato(fontSize:size.width*0.04,fontWeight:FontWeight.bold,color: Theme.of(context).splashColor),
                          maxLines: 1,
                        ),
                        subtitle: AutoSizeText('Group Admin',
                          style: GoogleFonts.lato(fontSize:size.width*0.035,color:Theme.of(context).dividerColor,),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  )
              ),
              SizedBox(
                  height: size.height*0.37,
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText('Group Members',
                        style: GoogleFonts.lato(fontSize:size.width*0.04,color:Theme.of(context).dividerColor,),
                        maxLines: 1,
                      ),
                      SizedBox(
                        height:size.height*0.33,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height:size.height*0.1,
                              child: ListView.builder(
                                  itemCount:listViewItemCount,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (BuildContext context, int index){
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const SizedBox(),
                                        (index==0)? Padding(
                                          padding: EdgeInsets.only(left:size.width*0.02,right: size.width*0.05),
                                          child: CircleAvatar(
                                            backgroundColor: Theme.of(context).splashColor,
                                            radius: size.width*0.07,
                                          ),
                                        ): SizedBox(
                                          width: size.width*0.2,
                                          child: InkWell(
                                            onTap:(){
                                              setState(() {
                                                listViewItemCount-=1;
                                                gridViewItemCount+=1;
                                              });
                                            },
                                            child: Stack(
                                                children:[
                                                  CircleAvatar(
                                                    backgroundColor: Theme.of(context).splashColor,
                                                    radius: size.width*0.07,
                                                  ),
                                                  Positioned(
                                                      bottom:1,
                                                      right:20,
                                                      child: CircleAvatar(
                                                        backgroundColor: Theme.of(context).splashColor,
                                                        radius: size.width*0.024,
                                                        child: Text('-',style: GoogleFonts.lato(color: Theme.of(context).primaryColorLight),),
                                                      )
                                                  )
                                                ]
                                            ),
                                          ),
                                        ),
                                        AutoSizeText((index==0)?'You':'Name',
                                          style: GoogleFonts.lato(fontSize:size.width*0.035,fontWeight:FontWeight.bold,color: Theme.of(context).splashColor),
                                        ),
                                        const SizedBox(),
                                      ],
                                    );;
                                  }
                              ),
                            ),
                            Divider(
                              height: 0,
                              color: Theme.of(context).dividerColor,
                              thickness: size.width*0.002,
                            ),
                            const SizedBox(),
                            SizedBox(
                              height: size.height*0.2,
                              child: GridView.builder(
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      mainAxisSpacing: size.width*0.015
                                  ),
                                  scrollDirection: Axis.vertical,
                                  itemCount: gridViewItemCount,
                                  itemBuilder: (BuildContext context, int index){
                                    return Column(
                                      children: [
                                        const SizedBox(),
                                        SizedBox(
                                          width: size.width*0.2,
                                          child: InkWell(
                                            onTap:(){
                                              setState(() {
                                                gridViewItemCount-=1;
                                                listViewItemCount+=1;
                                              });
                                            },
                                            child: Stack(
                                                children:[
                                                  CircleAvatar(
                                                    backgroundColor: Theme.of(context).splashColor,
                                                    radius: size.width*0.07,
                                                  ),
                                                  Positioned(
                                                      bottom:1,
                                                      right:20,
                                                      child: CircleAvatar(
                                                        backgroundColor: Theme.of(context).splashColor,
                                                        radius: size.width*0.024,
                                                        child: Text('+',style:GoogleFonts.lato(color: Theme.of(context).primaryColorLight),),
                                                      )
                                                  )
                                                ]
                                            ),
                                          ),
                                        ),
                                        AutoSizeText('Name',
                                          style: GoogleFonts.lato(fontSize:size.width*0.035,fontWeight:FontWeight.bold,color: Theme.of(context).splashColor),
                                        ),
                                        const SizedBox(),
                                      ],
                                    );
                                  }
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              ),
              InkWell(
                onTap: (){},
                child: Container(
                  height: size.height*0.06,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(32, 160, 144, 1),
                    borderRadius: BorderRadius.circular(size.width*0.025)
                  ),
                  child: Center(
                    child: AutoSizeText('Create',
                      style: GoogleFonts.lato(fontSize:size.width*0.05,fontWeight:FontWeight.w600,color:Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
