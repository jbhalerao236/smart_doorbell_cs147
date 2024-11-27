import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Background message received: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notifications Test App',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FirebaseMessaging messaging;

  @override
  void initState() {
    super.initState();
    setupFirebaseMessaging();
  }

  void setupFirebaseMessaging() async {
    try {
      messaging = FirebaseMessaging.instance;

      NotificationSettings settings = await messaging.requestPermission();
      print('Permission granted: ${settings.authorizationStatus}');

      String? token = await messaging.getToken();
      if (token != null) {
        print('FCM Token: $token');
      } else {
        print('Failed to get FCM token.');
      }

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Message received: ${message.notification?.title}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message.notification?.title ?? "No title")),
        );
      });
    } catch (e) {
      print('Error setting up Firebase Messaging: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications Test App')),
      body: Center(
        child: Text('Push Notifications Setup', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
