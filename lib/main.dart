import 'dart:async';
import 'package:believe_app/pages/tabs/dashboard_menu.dart';
import 'package:believe_app/pages/event_news/event_and_news_screen.dart';
import 'package:believe_app/pages/tabs/home.dart';
import 'package:believe_app/pages/login/login_with_mobile_screen.dart';
import 'package:believe_app/pages/leave/my_leave_screen.dart';
import 'package:believe_app/pages/task/my_task_list_screen.dart';
import 'package:believe_app/push_notification/PushNotificationService.dart';
import 'package:believe_app/utils/TextChanger.dart';
import 'package:believe_app/utils/app_utils.dart';
import 'package:believe_app/utils/session_manager.dart';
import 'package:believe_app/utils/session_manager_new.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'constant/colors.dart';
import 'constant/global_context.dart';


@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.data.toString()}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SessionManagerNew.init();
  PaintingBinding.instance.imageCache.maximumSizeBytes = 2000 << 40; // for increase the cache memory

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null)
  {
    //App received a notification when it was killed
    print("@@@@@@@@Main Dart@@@@@@@@" + initialMessage.data.toString());
    NavigationService.notif_type = initialMessage.data['content_type'];
    NavigationService.notif_content_id = initialMessage.data['id'];
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
  await PushNotificationService().setupInteractedMessage();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) => runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TextChanger()),
        ],
        child: const MyApp(),
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Believe App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.workSansTextTheme(
            Theme.of(context).textTheme,
          ).apply(),
          primarySwatch: createMaterialColor(white),
          platform: TargetPlatform.iOS,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: white,
            contentPadding: const EdgeInsets.only(left: 12, right: 12, top: 15, bottom: 15),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kEditTextCornerRadius),
                borderSide: const BorderSide(width: 0.5, style: BorderStyle.solid, color: button_bg)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kEditTextCornerRadius),
                borderSide: const BorderSide(width: 0.5, style: BorderStyle.solid, color: button_bg)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kEditTextCornerRadius), borderSide: const BorderSide(width: 0.5, color: button_bg)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kEditTextCornerRadius), borderSide: const BorderSide(width: 0.5, color: button_bg)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kEditTextCornerRadius),
                borderSide: const BorderSide(width: 0.5, style: BorderStyle.solid, color: button_bg)),
            labelStyle: const TextStyle(
              color: black,
              fontSize: 16,
              fontFamily: otherFont,
              fontWeight: FontWeight.w500,
            ),
            hintStyle: const TextStyle(color: black, fontSize: 16, fontFamily: otherFont, fontWeight: FontWeight.w400),
          )),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoggedIn = false;
  SessionManager sessionManager = SessionManager();

  @override
  void initState() {
    super.initState();
    doSomeAsyncStuff();
  }

  Future<void> doSomeAsyncStuff() async {
    try {
      isLoggedIn = sessionManager.checkIsLoggedIn() ?? false;
       if (isLoggedIn) {

        if (NavigationService.notif_content_id != null)
        {
          if (NavigationService.notif_content_id.toString().isNotEmpty)
          {
            if(NavigationService.notif_type == "new_task" ||
                NavigationService.notif_type == "remove_from_task")
            {
              Timer(
                  const Duration(seconds: 1),
                      () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                           MyTaskListScreen(isFromNotification: true)), (Route<dynamic> route) => false));
            }
            else  if(NavigationService.notif_type == "new_event" || NavigationService.notif_type == "new_news")
            {
              Timer(
                  const Duration(seconds: 1),
                      () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                           EventScreen(isFromNotification: true)), (Route<dynamic> route) => false));
            }
            else if(NavigationService.notif_type == "leave_approved" || NavigationService.notif_type == "leave_rejected")
            {
              Timer(
                  const Duration(seconds: 1),
                      () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                           LeavesScreen(isFromNotification: true)), (Route<dynamic> route) => false));
            }
            else
            {
              Timer(
                  const Duration(seconds:1),
                      () => Navigator.of(context)
                      .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const DashboardWithMenuScreen()), (Route<dynamic> route) => false));
            }
          }
          else
          {
            Timer(
                const Duration(seconds:1),
                    () => Navigator.of(context)
                    .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const DashboardWithMenuScreen()), (Route<dynamic> route) => false));
          }
        }
        else
        {
          Timer(
              const Duration(seconds:1),
                  () => Navigator.of(context)
                  .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const DashboardWithMenuScreen()), (Route<dynamic> route) => false));
        }
      } else {
        Timer(
            const Duration(seconds: 1),
                () => Navigator.of(context)
                .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginWithMobileScreen()), (Route<dynamic> route) => false));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: appBg,
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.dark,
    ));

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Colors.transparent,
            // Status bar brightness (optional)
            statusBarIconBrightness: Brightness.light,
            // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Image.asset(
                'assets/images/ic_login_bg.png',
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              Center(
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset('assets/images/ic_login_logo.png', height: 250, width: 250),
                ),
              ),
              Positioned(
                bottom: 30,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 50, right: 50),
                  child: Image.asset('assets/images/ic_login_text.png', fit : BoxFit.contain ,height: 80, width: 320,alignment: Alignment.center,),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 12,
                  width: MediaQuery.of(context).size.width,
                  color: orange,
                ),
              ),
              Positioned(
                bottom: 12,
                child: Container(
                  height: 12,
                  width: MediaQuery.of(context).size.width,
                  color: button_bg,
                ),
              ),
            ],
          ),
        ));
  }
}
