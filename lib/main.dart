import 'package:chat_system/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Authentication/Signin.dart';
import 'Screens/Calls.dart';
import 'Screens/Group/Groups.dart';
import 'Screens/HomeScreen.dart';
import 'Screens/Settings.dart';
import 'package:chat_system/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider= Provider.of<ThemeProvider>(context);
    return MaterialApp(
      themeMode: themeProvider.themeMode,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: (FirebaseAuth.instance.currentUser != null)? const MyHomePage():const SignIn(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex=0;
  bool isSearchedOpen=false;
  late List<Widget> screens;
  late List<String> screenName;

  @override
  void initState(){
    super.initState();
    screens= <Widget>[
      const HomeScreen(),
      const Groups(),
      const Calls(),
      const Settings()
    ];
  }

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: screens[selectedIndex],
      bottomNavigationBar: SizedBox(
        height: size.height*0.1,
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent
          ),
          child: BottomNavigationBar(
            onTap: (index){
              setState(() {
                selectedIndex= index;
              });
            },
            currentIndex: selectedIndex,
            showUnselectedLabels: true,
            selectedFontSize: size.width*0.04,
            unselectedFontSize: size.width*0.04,
            selectedItemColor: Theme.of(context).focusColor,
            unselectedItemColor: Theme.of(context).dividerColor,
            iconSize: size.width*0.07,
            backgroundColor: Theme.of(context).primaryColor,
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.message_rounded,
                  color: (selectedIndex==0)?Theme.of(context).focusColor:Theme.of(context).dividerColor,
                ),
                label: 'Message'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_rounded,
                    color: (selectedIndex==1)?Theme.of(context).focusColor:Theme.of(context).dividerColor,
                  ),
                  label: 'Groups'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.wifi_calling,
                  color:(selectedIndex==2)?Theme.of(context).focusColor:Theme.of(context).dividerColor,
                ),
                label: 'Calls'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings,
                  color: (selectedIndex==3)?Theme.of(context).focusColor:Theme.of(context).dividerColor,
                ),
                label: 'Settings'
              ),
            ]
          ),
        ),
      )
    );
  }
}