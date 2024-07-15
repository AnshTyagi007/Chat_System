import 'package:auto_size_text/auto_size_text.dart';
import 'package:chat_system/userdetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ChatRoom.dart';
import 'Profile/ProfilePage.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearchedOpen=false;
  TextEditingController searchController=TextEditingController();
  List<dynamic> searchResults=[];
  List<String> recentChats=[];
  List<String> userNames=[];
  List<String> lastMessage=[];
  List<String> timeStamp=[];
  late String person2Uid;
  late String uid;
  late String docId;
  Future<void> searchUsername(String query) async{
    QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection('Users').orderBy('username').startAt([query]).endAt(['$query\uf8ff']).get();
    setState(() {
      searchResults = querySnapshot.docs.map((doc) => doc['username']).toList();
    });
  }
  Future<void> getPerson2Uid(String username) async{
    QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection('Users').where('username', isEqualTo: username).get();
    person2Uid=querySnapshot.docs.first.id;
  }
  Future<void> recentChat() async{
    QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection('Conversation').orderBy('timestamp', descending: true).get();
    List<String> tempRecentChats= [];
    List<String> tempUserNames= [];
    List<String> tempLastMessage= [];
    List<String> tempTimeStamp= [];
    DateTime dateTime;
    for(var doc in querySnapshot.docs){
      String user1id=doc['user1id'];
      String user2id=doc['user2id'];
      String lastMsg=doc['lastMessage'];
      Timestamp tStamp=doc['timestamp'];
      if (user1id == uid || user2id == uid) {
        String otherUserId=(user1id == uid)?user2id:user1id;
        if(!tempRecentChats.contains(otherUserId)) {
          tempRecentChats.add(otherUserId);
          tempLastMessage.add(lastMsg);
          dateTime= tStamp.toDate();
          tempTimeStamp.add(formatTimestamp(tStamp));
        }
      }
    }
    recentChats=tempRecentChats;
    timeStamp=tempTimeStamp;
    lastMessage=tempLastMessage;
    for(String userid in recentChats){
      UserDetails userDetails=UserDetails(userid);
      await userDetails.fetchUserDetails();
      tempUserNames.add(userDetails.name);
    }
    userNames=tempUserNames;
  }
  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime yesterday = today.subtract(const Duration(days: 1));

    if (dateTime.isAfter(today)) {
      return DateFormat('HH:mm').format(dateTime);
    } else if (dateTime.isAfter(yesterday)) {
      return 'Yesterday';
    } else {
      return DateFormat('dd MMM, HH:mm').format(dateTime);
    }
  }
  Future<void> conversationDocId(String otherParticipant)async{
    if(uid.compareTo(otherParticipant) < 0) {
      docId='$uid$otherParticipant';
    }
    else{
      docId='$otherParticipant$uid';
    }
  }
  @override
  void initState() {
    super.initState();
    uid=FirebaseAuth.instance.currentUser!.uid;
    recentChat().then((_){
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height*0.9,
      child: Column(
        children: [
          SizedBox(
            height: size.height*0.01,
          ),
          SizedBox(
            height: size.height*0.1,
            child: (isSearchedOpen)?Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width*0.05,vertical: size.height*0.02),
              child: SearchBar(
                controller: searchController,
                onChanged: (value) => {
                  setState(() {
                    value.isNotEmpty?searchUsername(value):(searchResults=[]);
                  })
                },
                leading: IconButton(
                  onPressed: (){
                    setState(() {
                      isSearchedOpen=false;
                      searchResults=[];
                      searchController.clear();
                    });
                  },
                  icon: const Icon(Icons.arrow_back_sharp)
                ),
                trailing: [
                  IconButton(
                    onPressed:(){
                      setState(() {
                        searchController.clear();
                        searchResults=[];
                      });
                    },
                    icon: const Icon(Icons.close)
                  ),
                ],
                hintText: 'Search...',
                hintStyle: WidgetStateProperty.all(GoogleFonts.lato(fontSize:size.width*0.035,color:Colors.black),),

              ),
            ):Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: (){
                    setState(() {
                      isSearchedOpen=true;
                    });
                  },
                  icon: Icon(Icons.search, color: Theme.of(context).splashColor,),
                  iconSize: size.width*0.07,
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(CircleBorder(
                      side: BorderSide(
                        width: size.width*0.005,
                      )
                    ))
                  ),
                ),
                SizedBox(
                  width: size.width*0.15,
                ),
                AutoSizeText('Home',
                  style: GoogleFonts.lato(fontSize:size.width*0.06,color:Theme.of(context).splashColor,fontWeight:FontWeight.bold),
                ),
                SizedBox(
                  width: size.width*0.15,
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfilePage())
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).splashColor,
                    radius: size.width*0.06,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height*0.2,
            child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index){
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(),
                      (index==0)? SizedBox(
                        width: size.width*0.2,
                        child: Stack(
                            children:[
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: size.width*0.005,
                                    color: Theme.of(context).splashColor
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
                      ): Container(
                        width: size.width*0.2,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: size.width*0.005,
                            color: Theme.of(context).splashColor
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
                      AutoSizeText((index==0)?'My Status':'Status',
                        style: GoogleFonts.lato(fontSize:size.width*0.035,fontWeight:FontWeight.bold,color: Theme.of(context).splashColor),
                      ),
                      const SizedBox(),
                    ],
                  );
                }),
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
                  child: (searchResults.isNotEmpty)?ListView.builder(
                    padding: EdgeInsets.only(top: size.height*0.04),
                    itemCount: searchResults.length,
                    itemBuilder: (BuildContext context, int index){
                      return SizedBox(
                        height: size.height*0.1,
                        child: Center(
                          child: ListTile(
                            onTap: () async{
                              await getPerson2Uid(searchResults[index]);
                              await conversationDocId(person2Uid);
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => ChatRoom(docId, uid, person2Uid))
                              );
                              setState(() {
                                isSearchedOpen=false;
                                searchController.clear();
                                searchResults=[];
                              });
                            },
                            leading: SizedBox(
                              width:size.width*0.15,
                              child: Stack(
                                  children:[
                                    CircleAvatar(
                                      backgroundColor: Theme.of(context).splashColor,
                                      radius: size.width*0.07,
                                    ),
                                    Positioned(
                                      bottom: size.height*0.001,
                                      left: size.width*0.1,
                                      child: CircleAvatar(
                                        backgroundColor: Colors.green,
                                        radius: size.width*0.012,
                                      ),
                                    )
                                  ]
                              ),
                            ),
                            title: AutoSizeText(searchResults[index],
                              style: GoogleFonts.lato(fontSize:size.width*0.055,fontWeight:FontWeight.bold,color: Theme.of(context).splashColor),
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
                            subtitle: AutoSizeText('Last Message',
                              style: GoogleFonts.lato(fontSize:size.width*0.035,color:Theme.of(context).dividerColor),
                            ),
                          ),
                        ),
                      );
                    },
                  ):FutureBuilder(
                    future: recentChat(),
                    builder: (context, snapshot){
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator()); // Show a loading indicator while fetching data
                      } else {
                        return ListView.builder(
                          padding: EdgeInsets.only(top: size.height*0.04),
                          itemCount: recentChats.length,
                          itemBuilder: (BuildContext context, int index){
                            return SizedBox(
                              height: size.height*0.1,
                              child: Center(
                                child: ListTile(
                                  onTap: () async{
                                    await conversationDocId(recentChats[index]);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => ChatRoom(docId,uid,recentChats[index]))
                                    );
                                  },
                                  leading: SizedBox(
                                    width:size.width*0.15,
                                    child: Stack(
                                        children:[
                                          CircleAvatar(
                                            backgroundColor: Theme.of(context).splashColor,
                                            radius: size.width*0.07,
                                          ),
                                          Positioned(
                                            bottom: size.height*0.001,
                                            left: size.width*0.1,
                                            child: CircleAvatar(
                                              backgroundColor: Colors.green,
                                              radius: size.width*0.012,
                                            ),
                                          )
                                        ]
                                    ),
                                  ),
                                  title: AutoSizeText(userNames[index],
                                    style: GoogleFonts.lato(fontSize:size.width*0.055,color:Theme.of(context).splashColor,fontWeight:FontWeight.bold),
                                  ),
                                  trailing: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      AutoSizeText(timeStamp[index],
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
                                  subtitle: AutoSizeText(lastMessage[index],
                                    style: GoogleFonts.lato(fontSize:size.width*0.035,color:Theme.of(context).dividerColor),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
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