import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class ChatRoom extends StatefulWidget {
  final String conversationDocId;
  final String user1id;
  final String user2id;
  const ChatRoom(this.conversationDocId, this.user1id, this.user2id, {super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  TextEditingController messageController=TextEditingController();
  bool isFocused=false;
  final int pageSize=50;
  DocumentSnapshot? lastVisibleMessage;
  List<dynamic> messages=[];
  List<dynamic> senderId=[];
  late ScrollController scrollController;
  bool isLoading=false;
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>> conversationSubscription;

  String generateMessageId(){
    String uuid=const Uuid().v4();
    int timestamp= DateTime.now().millisecondsSinceEpoch;
    return '$timestamp-$uuid';
  }

  void _scrollListener() {
    if (scrollController.offset >=
        scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (!isLoading) {
        loadMessages();
      }
    }
  }
  
  Future<void> loadMessages() async{
    setState(() {
      isLoading=true;
    });
    try{
      QuerySnapshot querySnapshot;
      if(lastVisibleMessage == null){
        querySnapshot= await FirebaseFirestore.instance
          .collection('Conversation').doc(widget.conversationDocId)
          .collection('Messages').orderBy('timestamp', descending: true).limit(pageSize).get();
      }
      else{
        querySnapshot= await FirebaseFirestore.instance
          .collection('Conversation').doc(widget.conversationDocId)
          .collection('Messages').orderBy('timestamp', descending: true)
          .startAfterDocument(lastVisibleMessage!).limit(pageSize).get();
      }
      lastVisibleMessage=querySnapshot.docs.last;
      List<dynamic> newMessages=querySnapshot.docs.map((doc) =>doc['content']).toList();
      List<dynamic> newSenderId=querySnapshot.docs.map((doc) =>doc['senderId']).toList();
      setState(() {
        messages.addAll(newMessages);
        senderId.addAll(newSenderId);
        isLoading=false;
      });
    }catch(e){
      debugPrint('Error loading messages: $e');
      setState(() {
        isLoading=false;
      });
    }
  }

  Future<void> setConversationDetails(String message)async{
    DocumentReference conversationRef=FirebaseFirestore.instance.collection('Conversation').doc(widget.conversationDocId);
    DocumentSnapshot conversationSnapshot=await conversationRef.get();
    if(!conversationSnapshot.exists){
      String user1id,user2id;
      if(widget.user1id.compareTo(widget.user2id) < 0){
        user1id=widget.user1id;
        user2id=widget.user2id;
      }
      else{
        user2id=widget.user1id;
        user1id=widget.user2id;
      }
      try {
        await FirebaseFirestore.instance.collection('Conversation').doc(
            widget.conversationDocId).set({
          'user1id': user1id,
          'user2id': user2id,
          'lastMessage': message,
          'timestamp': Timestamp.now(),
        });
      }catch (e) {
        debugPrint('Error updating conversation collection: $e');
      }
      setState(() {
        messages.insert(0, message);
        senderId.insert(0, widget.user1id);
      });
      lastVisibleMessage=null;
    }
    else{
      try {
        await FirebaseFirestore.instance.collection('Conversation').doc(
            widget.conversationDocId).update({
          'lastMessage': message,
          'timestamp': Timestamp.now(),
        });
      }catch (e) {
        debugPrint('Error updating conversation collection: $e');
      }
    }
    try{
      await FirebaseFirestore.instance.collection('Conversation').doc(widget.conversationDocId)
          .collection('Messages').doc(generateMessageId()).set({
        'senderId':widget.user1id,
        'receiverId':widget.user2id,
        'content':message,
        'timestamp':Timestamp.now()
      });
    }catch (e) {
      debugPrint('Error updating messages collection: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    conversationSubscription=FirebaseFirestore.instance.collection('Conversation').doc(widget.conversationDocId).collection("Messages").snapshots().listen((event) {
      print("mine");
      print(event.docChanges[0].doc.data());

      if(messages.isNotEmpty && mounted){
        lastVisibleMessage=event.docChanges[0].doc;
        final msg = event.docChanges[0].doc.data()!["content"];
        final sender = event.docChanges[0].doc.data()!["senderId"];
        print(msg+"msg");
        print("sender $sender");
        if(msg != messages[0]){
          setState(() {
            messages.insert(0, msg);
            senderId.insert(0, sender);
            print(messages);
          });
        }
      }

    });
    lastVisibleMessage=null;
    scrollController=ScrollController();
    scrollController.addListener(_scrollListener);
    loadMessages();
  }
  // @override
  // void dispose() {
  //   conversationSubscription.cancel();
  //   scrollController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context){
    Size size=MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
        setState(() {
          isFocused=false;
        });
      },
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          elevation: 10,
          shadowColor: Theme.of(context).splashColor,
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_sharp, color: Theme.of(context).splashColor,),
          ),
          title: SizedBox(
            width: size.width*0.6,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).splashColor,
                  radius: size.width*0.06,
                ),
                SizedBox(
                  width: size.width*0.03,
                ),
                AutoSizeText('Name',
                  style: GoogleFonts.lato(fontSize:size.width*0.06,fontWeight:FontWeight.bold,color:Theme.of(context).splashColor),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.call, color: Theme.of(context).dividerColor,),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.videocam_rounded, color: Theme.of(context).dividerColor,),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Theme.of(context).primaryColorLight,
            child: Column(
              children: [
                SizedBox(
                  height: size.height*0.78,
                  child: ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    itemCount:messages.length + (isLoading? 1:0),
                    controller: scrollController,
                    itemBuilder: (BuildContext context, int index){
                      if(index < messages.length) {
                        return Padding(
                        padding: EdgeInsets.all(size.width*0.05),
                        child: (widget.user1id == senderId[index])?Row(
                          children: [
                            const Expanded(child:SizedBox()),
                            (messages[index].length <= 'A'.length*38)?Container(
                              constraints: const BoxConstraints(
                                minWidth: 'A'.length*1,
                              ),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).focusColor,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(size.width*0.05),
                                      bottomLeft: Radius.circular(size.width*0.04),
                                      bottomRight: Radius.circular(size.width*0.04)
                                  )
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(size.width*0.03),
                                child: Center(
                                  child: AutoSizeText(messages[index],
                                    style: GoogleFonts.lato(fontSize:size.width*0.035,fontWeight:FontWeight.bold,color:Theme.of(context).splashColor),
                                    softWrap: true,
                                    maxLines: null,
                                  ),
                                ),
                              ),
                            ):SizedBox(
                              width:size.width*0.7,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).focusColor,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(size.width*0.05),
                                    bottomLeft: Radius.circular(size.width*0.04),
                                    bottomRight: Radius.circular(size.width*0.04)
                                  )
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(size.width*0.03),
                                  child: Center(
                                    child: AutoSizeText(messages[index],
                                      style: GoogleFonts.lato(fontSize:size.width*0.035,fontWeight:FontWeight.bold,color:Theme.of(context).splashColor),
                                      softWrap: true,
                                      maxLines: null,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ):Row(
                          children: [
                            (messages[index].length <= 'A'.length*38)?Container(
                              constraints: const BoxConstraints(
                                minWidth: 'A'.length*1,
                              ),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).dividerColor,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(size.width*0.05),
                                      bottomLeft: Radius.circular(size.width*0.04),
                                      bottomRight: Radius.circular(size.width*0.04)
                                  )
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(size.width*0.03),
                                child: Center(
                                  child: AutoSizeText(messages[index],
                                    style: GoogleFonts.lato(fontSize:size.width*0.035,fontWeight:FontWeight.bold,color:Theme.of(context).splashColor),
                                    softWrap: true,
                                    maxLines: null,
                                  ),
                                ),
                              ),
                            ):SizedBox(
                              width:size.width*0.7,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).dividerColor,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(size.width*0.05),
                                        bottomLeft: Radius.circular(size.width*0.04),
                                        bottomRight: Radius.circular(size.width*0.04)
                                    )
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(size.width*0.03),
                                  child: Center(
                                    child: AutoSizeText(messages[index],
                                      style: GoogleFonts.lato(fontSize:size.width*0.035,fontWeight:FontWeight.bold,color:Theme.of(context).splashColor),
                                      softWrap: true,
                                      maxLines: null,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Expanded(child:SizedBox()),
                          ],
                        ),
                      );
                      }
                      else{
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }
                  ),
                ),
                SizedBox(
                  height: size.height*0.1,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.attach_file, color: Theme.of(context).dividerColor,),
                      ),
                      SizedBox(
                        width: size.width*0.7,
                        child: TextField(
                          onTap: (){
                            setState(() {
                              isFocused=true;
                            });
                          },
                          controller: messageController,
                          maxLines: 1,
                          cursorColor: Theme.of(context).splashColor,
                          style: GoogleFonts.lato(fontSize:size.width*0.035,color: Theme.of(context).splashColor),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).dividerColor
                              )
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(size.width*0.01),
                                borderSide: BorderSide(
                                  width: size.width*0.01,
                                )
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: size.height*0.02,horizontal: size.width*0.05),
                            hintText: 'Write your message',
                            hintStyle: GoogleFonts.lato(fontSize:size.width*0.035,color: Theme.of(context).dividerColor),
                          ),
                        ),
                      ),
                      (isFocused)?IconButton(
                        onPressed: () {
                          setState(() {
                            setConversationDetails(messageController.text.trim());
                          });
                          messageController.clear();
                        },
                        icon: Icon(Icons.send,size: size.width*0.07,color:Theme.of(context).dividerColor),
                      ):IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.keyboard_voice,size: size.width*0.07,color:Theme.of(context).dividerColor),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}