import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotification {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  LocalNotification() {
    //General notification settings for ios and android
    var initialzationSettingsAndroid =
        new AndroidInitializationSettings('alarm');
    var initilazationSettingsIos = new IOSInitializationSettings();

    var initializationSettings = new InitializationSettings(
        android: initialzationSettingsAndroid, iOS: initilazationSettingsIos);

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  sendNow(String title, String body, String payLoad) async {
    //It is the method used to send notifications immediately.
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channelIdx',
      'channelNamxex',
      'channelDescrxiptioxn',
      importance: Importance.max,
      priority: Priority.max,
      //vibrationPattern: vibrationPattern,
      sound: RawResourceAndroidNotificationSound('alarmsound'),
      enableVibration: true,

      ticker: 'tickers',
    );

    var iOsPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifcs = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOsPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifcs, payload: payLoad);
  }

  Future setDailyNotication(
      // method used for scheduled notifications
      int id,
      String title,
      String body,
      String dateTime,
      String channelId,
      String channelName,
      String channelDesc,
      bool enableVibration,
      bool playSound) async {
    tz.initializeTimeZones(); //

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        //Allows the change of vibration, sound and significance in a notification scheduled for android
        channelId,
        channelName,
        channelDesc,
        importance: Importance.max,
        priority: Priority.max,
        ticker: 'ticker',
        enableVibration: enableVibration,
        playSound: playSound);
    var iosPlatformChannelSpecifics =
        IOSNotificationDetails(); //ios general setting
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iosPlatformChannelSpecifics);

    tz.TZDateTime.parse(tz.local, dateTime);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        //It is the method that sorts a notification according to the given date and performs the notification when the time comes.
        id,
        title,
        body,

        // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 15)),
        tz.TZDateTime.parse(tz.local,
            dateTime), //It ensures that the zonedSchedule method is converted to the desired date format.
        platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        payload: 'payload');
  }

  Future<void> deleteNotificationPlan(int id) async {
    //Notification is canceled according to the given id.
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  void deleteAllNotificationPlan() {
    //delete all notifications
    flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<List<ActiveNotification>> activeNotifications() async {
    //list active notifications
    return await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.getActiveNotifications();
  }

  Future<List<PendingNotificationRequest>> showNotificationPlans() async {
    var pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return pendingNotificationRequests;
  }

  Future<List<PendingNotificationRequest>> showNotificationPlansFromQuery(
      //lists notification based on specific query
      String title,
      String body) async {
    var pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return pendingNotificationRequests
        .where((element) => element.title == title && element.body == body)
        .toList();
  }
}
