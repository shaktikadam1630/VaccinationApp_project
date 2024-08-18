// import 'dart:convert';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:http/http.dart' as http;

// class NotificationService {
//   static Future<void> initialize() async {
//     try {
//       NotificationSettings settings =
//           await FirebaseMessaging.instance.requestPermission();

//       if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//         print("Notifications Initialized!");

//         // Retrieve the FCM token
//         String? token = await FirebaseMessaging.instance.getToken();
//         print("FCM Token: $token");

//         // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
//         FirebaseMessaging.onMessage.listen(foregroundHandler);
//       } else {
//         print("User declined permission for notifications");
//       }
//     } catch (e) {
//       print("Error initializing notifications: $e");
//     }
//   }

//   static Future<void> backgroundHandler(RemoteMessage message) async {
//     if (message.notification != null) {
//       print("Background message received! ${message.notification!.title}");
//     }
//   }

//   static Future<void> foregroundHandler(RemoteMessage message) async {
//     print("foreground message received! ${message.notification!.title}");
//   }

//   static void subscribeToUserTopic(String userId) {
//     FirebaseMessaging.instance.subscribeToTopic(userId);
//   }

//   static void unsubscribeFromUserTopic(String userId) {
//     FirebaseMessaging.instance.unsubscribeFromTopic(userId);
//   }

//   static Future<void> sendNotificationToUser(
//       String userId, String notifytitle, String notifybody) async {
//     // Send notification to the topic associated with the user
//     final String serverKey =
//         'ya29.c.c0ASRK0GaI85FlM_ieSGKRxuJUbyudZPLTSTbWXvSQKucfQDmmuMwet58nTUfhoikDbA5cUIo5PZhjdnyNhUYtb_jMUxpkySJnpgxov5WgL_nSERRxKG85Gx5ULZwJCl8gFY405H4SGzLg7d2YWCQDsdkhmnih-iu2EC12Faiwk5eqcYnipDwUbtjbSxnG-a9KOFILcw_xCp7bYxhvRjGtqW88NcpcF5GtLCwKwpGrxJVPpcOvbU3KKLdxBaoGFLw0fyg0QFaRsuDoZN1uc89gSHXI5gm7b9XEaUCwp-Mlg6dv1mDjOxFmAWIz0Dn7MXZJx-U3HSd9mumlKLgiYx5k6q8W0eSvYbP5efALLrllWWJzbJGWfKlOMaI60icL388AQWJJ4zB4lohX-I19tgJaRqyc1xWkVqg2-w61t74J6c03J2uz6V3uSFqddWkpe-wbjlwjvdJWfBxhRM9u-l44vmgb8kcnmOSXrZB9Jpvj2Q3yRqoy-fz3cj9qq6i5S_gRUuvFMltmRQlYwve15sia1xwyq-Y7gQYmawVXqBe1Rypl8I21U869j9sBpa5ZWxwWOl_Ia8RVeQ6e3gFmjnq1kgk1b9uks8g-vgpuq_fUMfev_FwM_qnvRwIzOV_Oeh8zgmrkOmidMpybQxbsF-Ig51uO113r-bj1nx1MMxqz_xgqcov4-sulMaXeuqYoY0as_sfskSXq3s7ZhJb9jaIjoa2yOf-jFnegSqsnbq43VIOt3_UqndkWdOq1nkoFM5bi9ewwnFXOlJ4upSu2iX42hdwqmVSBOx4eygfQW4YIdI-xMRx8zpXw8oQQM7bi6r9QqYsZ88xMYlVlOx6s_fyypQouJ2I-u5cdWBhfxVq6cVrb_e5qadWbSQ9gzVx06juc0U6m0qQ57bkMyhOUxaMcFc2tgrQ-yJnJt8MWBYYznUlVJ9Wbs1jJbpZa0cIW88sQ0FgqyrgZ16qrpsYb7t4IJs0Bf-7p-rZynIu8dapWOpf-';

//     final String url = 'https://fcm.googleapis.com/fcm/send';

//     final headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'key=$serverKey',
//     };

//     final payload = {
//       'to': '/topics/$userId',
//       'notification': {
//         'title': notifytitle,
//         'body': notifybody,
//       },
//     };
//   }
// }
