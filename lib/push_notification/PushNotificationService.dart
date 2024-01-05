import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../constant/global_context.dart';
import '../pages/tabs/dashboard_menu.dart';
import '../pages/event_news/event_and_news_screen.dart';
import '../pages/leave/my_leave_screen.dart';
import '../pages/task/my_task_list_screen.dart';
import '../utils/session_manager.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PushNotificationService {
  Future<void> setupInteractedMessage() async {
    if (kIsWeb) {
      await Firebase.initializeApp(
        name: "Jindal World",
        options: const FirebaseOptions(
          apiKey: "AIzaSyA2GIssNLcetXVngOSsM_skQtHeB2SPn1c",
          appId: "1:1074098588756:web:b20e714cfdb5e29444b1c1",
          messagingSenderId: "1074098588756",
          projectId: "jspl-connect",
        ),
      );
    }
    else
    {
      await Firebase.initializeApp();
    }

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      var messageData = "";
      var contentType = "";
      var contentId = "";
      var image = "";
      var title = "";

      message.data.forEach((key, value)
      {
        if (key == "message") {
          messageData = value;
        }

        if (key == "content_type") {
          contentType = value;
        }

        if (key == "id") {
          contentId = value;
        }

        if (key == "image") {
          image = value;
        }

        if (key == "title") {
          title = value;
        }

      });

      print('<><> onMessage messageData PUSH OPEN--->' + messageData);
      print('<><> onMessage contentType PUSH OPEN--->' + contentType);
      print('<><> onMessage contentId PUSH OPEN --->' + contentId);
      print('<><> onMessage image PUSH OPEN--->' + image);
      openPage(contentId,contentType);
    });

    await enableIOSNotifications();
    await registerNotificationListeners();
  }

  enableIOSNotifications() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true);
  }

  registerNotificationListeners() async {
    AndroidNotificationChannel channel = androidNotificationChannel();
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    var androidSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');

    var iOSSettings = const DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,);

    var initSettings = InitializationSettings(android: androidSettings, iOS: iOSSettings);

    flutterLocalNotificationsPlugin.initialize(initSettings, onDidReceiveNotificationResponse: (payload) {
      // This function handles the click in the notification when the app is in background
      // Get.toNamed(NOTIFICATIOINS_ROUTE);
      try {
        print('<><> TAP onMessage PUSH:' + payload.toString() + "  <><>");
        var data = payload.toString().split("|");
        var contentId = data[0];
        var contentType = data[1];
        openPage(contentId,contentType);
      } catch (e) {
        print(e);
      }
    });

    // onMessage is called when the app is in foreground and a notification is received
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
      print('onMessage Notification Payload:${message?.notification!.toMap().toString()}');
      print('onMessage Data Payload:${message?.data.toString()}');
      RemoteNotification? notification = message?.notification;
      AndroidNotification? android = message?.notification?.android;
      AppleNotification? appleNotification = message?.notification?.apple;
      SessionManager sessionManager = SessionManager();
      var isLoggedIn = sessionManager.checkIsLoggedIn() ?? false;

      if (notification != null && isLoggedIn)
      {
       
        var messageData = "";
        var contentType = "";
        var contentId = "";
        var image = "";
        var title = "";

        message?.data.forEach((key, value)
        {
          if (key == "message") {
            messageData = value;
          }

          if (key == "content_type") {
            contentType = value;
          }

          if (key == "id") {
            contentId = value;
          }

          if (key == "image") {
            image = value;
          }

          if (key == "title") {
            title = value;
          }

        });

        print('<><> onMessage messageData PUSH--->' + messageData);
        print('<><> onMessage contentType PUSH --->' + contentType);
        print('<><> onMessage contentId PUSH --->' + contentId);
        print('<><> onMessage image PUSH --->' + image);

        if (image != null)
        {
          if (image.toString().isNotEmpty)
          {
            print("Image Notification ==== $image");
            String largeIconPath = await _downloadAndSaveFile(image.toString().replaceAll(" ", "%20"), 'largeIcon');
            String bigPicturePath = await _downloadAndSaveFile(image.toString().replaceAll(" ", "%20"), 'bigPicture');
            final BigPictureStyleInformation bigPictureStyleInformation = BigPictureStyleInformation(
                FilePathAndroidBitmap(bigPicturePath),
                largeIcon: FilePathAndroidBitmap(largeIconPath),
                contentTitle: title, //"<b>$title</b>"
                htmlFormatContentTitle: true,
                summaryText: '',
                htmlFormatSummaryText: true
            );
            final DarwinNotificationDetails iOSPlatformChannelSpecifics = DarwinNotificationDetails(
                presentSound: true, presentAlert: true,
                categoryIdentifier: "myNotificationCategory",
                threadIdentifier: "myNotificationCategory",
                attachments: <DarwinNotificationAttachment>[
                  DarwinNotificationAttachment(
                    bigPicturePath,
                  )
                ]);
            print("object------->$bigPicturePath**************");
            flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                  android: AndroidNotificationDetails(
                      'BelieveApp',
                      'BelieveApp',
                      channelDescription: channel.description,
                      icon: android!.smallIcon,
                      playSound: true,
                      styleInformation: bigPictureStyleInformation,
                      importance: Importance.max,
                      priority: Priority.high),
                  iOS: iOSPlatformChannelSpecifics),
              payload: "$contentId|$contentType",
            );
          }
          else
          {
            const DarwinNotificationDetails iOSPlatformChannelSpecifics = DarwinNotificationDetails(presentSound: true, presentAlert: true,);
            flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                  android: AndroidNotificationDetails(
                      'BelieveApp',
                      'BelieveApp',
                      channelDescription: channel.description,
                      icon: android!.smallIcon,
                      playSound: true,
                      importance: Importance.max,
                      priority: Priority.high),
                  iOS: iOSPlatformChannelSpecifics),
              payload: "$contentId|$contentType",
            );
          }
        }
        else
        {
          const DarwinNotificationDetails iOSPlatformChannelSpecifics = DarwinNotificationDetails(presentSound: true, presentAlert: true,);
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                    'BelieveApp',
                    'BelieveApp',
                    channelDescription: channel.description,
                    icon: android!.smallIcon,
                    playSound: true,
                    importance: Importance.max,
                    priority: Priority.high),
                iOS: iOSPlatformChannelSpecifics),
            payload: "$contentId|$contentType",
          );
        }
      }
      else
      {
        print("<><> CHECK DATA : " + " <><>");
      }

      getUnReadCount();
    });
  }

  androidNotificationChannel() => const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description: 'This channel is used for important notifications.', // description
        importance: Importance.max,
        playSound: true,
        sound: RawResourceAndroidNotificationSound('notification_sound_tone.mp3'),
      );

  void openPage(String contentId,String contentType) {
    if (contentId != null)
    {
      NavigationService.notif_type = contentType;
      NavigationService.notif_content_id = contentId;
      if (contentId.toString().isNotEmpty)
      {
        if(contentType == "new_task" || contentType == "remove_from_task")
        {
          NavigationService.navigatorKey.currentState!.push(
            MaterialPageRoute(builder: (context) =>  MyTaskListScreen(isFromNotification: true)),
          );
        }
        else  if(contentType == "new_event" || contentType == "new_news")
        {
          NavigationService.navigatorKey.currentState!.push(
            MaterialPageRoute(builder: (context) =>  EventScreen(isFromNotification: true)),
          );
        }
        else  if(contentType == "leave_approved" || contentType == "leave_rejected")
        {
          NavigationService.navigatorKey.currentState!.push(
            MaterialPageRoute(builder: (context) =>  LeavesScreen(isFromNotification: true)),
          );
        }
        else
        {
          NavigationService.navigatorKey.currentState!.push(
            MaterialPageRoute(builder: (context) => const DashboardWithMenuScreen()),
          );
        }
      }
      else
      {
        NavigationService.navigatorKey.currentState!.push(
          MaterialPageRoute(builder: (context) => const DashboardWithMenuScreen()),
        );
      }
    }
    else
    {
      NavigationService.navigatorKey.currentState!.push(
        MaterialPageRoute(builder: (context) => const  DashboardWithMenuScreen()),
      );
    }
  }

  getUnReadCount() async {
    /*HttpWithMiddleware http = HttpWithMiddleware.build(middlewares: [
      HttpLogger(logLevel: LogLevel.BODY),
    ]);

    final url = Uri.parse(API_URL + notificationsCount);


    Map<String, String> jsonBody = {};

    var sessionManager = SessionManager();
    final response = await http.post(url, body: jsonBody, headers: {
      "Authorization": sessionManager.getAccessToken().toString(),
    });

    final statusCode = response.statusCode;
    final body = response.body;
    Map<String, dynamic> apiResponse = jsonDecode(body);
    var dataResponse = NotificationCount.fromJson(apiResponse);
    if (statusCode == 200 && dataResponse.success == 1)
    {
      if (dataResponse.count != null)
      {
        if (int.parse(checkValidString(dataResponse.count)) > 0)
        {
          sessionManager.setUnreadNotificationCount(int.parse(checkValidString(dataResponse.count)));
        }
        else
        {
          sessionManager.setUnreadNotificationCount(0);
        }
      }
      else
      {
        sessionManager.setUnreadNotificationCount(0);
      }
    }
    else
    {
      sessionManager.setUnreadNotificationCount(0);
    }*/
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    print("<><><><><><>$filePath<><><><><><>");
    return filePath;
  }

}
