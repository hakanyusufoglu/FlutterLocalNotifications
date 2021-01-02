# How to use Notification in flutter_local_notification?

### Tasks of methods in local_notification.dart
1. **```sendNow(...)```** method; It is the method used to send notifications immediately.

2. **```Future setDailyNotication(...)```** method; channelId must be different for each notification.

3. **```Future<void> deleteNotificationPlan(int id)```** method; Notification is canceled according to the given id.
  
4. **```void deleteAllNotificationPlan()```** method; Delete all notifications.

5. **```Future<List<ActiveNotification>> activeNotifications()```** method; List active notifications.
  
6. **```Future<List<PendingNotificationRequest>> showNotificationPlansFromQuery(string title, String body)```** method; Performs a notification search based on title and body.

### Requirements (pubspec.yaml)
```
flutter_local_notifications: ^3.0.1+4
timezone: ^0.5.9
```

### This sites was built using 
- [pub.dev Pages](https://pub.dev/packages/flutter_local_notifications).
- [GitHub Pages](https://github.com/MaikuB/flutter_local_notifications).
