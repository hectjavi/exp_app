import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import '../core/navigation/navigation_service.dart';

class FirebaseNotificationService {
  final FirebaseMessaging _messaging =
      FirebaseMessaging.instance;

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final FlutterLocalNotificationsPlugin
      _localNotifications =
          FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    try {
      await _initializeLocalNotifications();

      print("===== INICIANDO FCM =====");

      final settings =
          await _messaging.requestPermission();

      print(
        'Permiso: ${settings.authorizationStatus}',
      );

      final token =
          await _messaging.getToken();

      print('FCM TOKEN: $token');

      await _saveToken(token);

      _messaging.onTokenRefresh.listen(
        (newToken) async {
          print(
            'FCM TOKEN ACTUALIZADO: $newToken',
          );

          await _saveToken(newToken);
        },
      );

      // APP ABIERTA
      FirebaseMessaging.onMessage.listen(
        (RemoteMessage message) async {
          print(
            '===== NOTIFICACION RECIBIDA =====',
          );

          print(
            'TITLE: ${message.notification?.title}',
          );

          print(
            'BODY: ${message.notification?.body}',
          );

          print(
            'DATA: ${message.data}',
          );

          await _showNotification(
            message,
          );
        },
      );

      // USUARIO TOCA NOTIFICACION
      FirebaseMessaging.onMessageOpenedApp.listen(
        (RemoteMessage message) {
          print(
            '===== NOTIFICACION PRESIONADA =====',
          );

          print(
            'DATA: ${message.data}',
          );

          final orderId =
              message.data['orderId'];

          if (orderId != null) {
            print(
              'ORDER ID: $orderId',
            );

            // Próximo paso:
            // Navegar a OrderDetailView
            // context.go('/order-detail/$orderId');
          }
        },
      );

      // APP CERRADA Y ABIERTA DESDE PUSH
      final initialMessage =
          await FirebaseMessaging.instance
              .getInitialMessage();

      if (initialMessage != null) {
        print(
          '===== APP ABIERTA DESDE PUSH =====',
        );

        print(
          'DATA: ${initialMessage.data}',
        );

        final orderId =
            initialMessage.data['orderId'];

        if (orderId != null) {
          print(
            'ORDER ID: $orderId',
          );

          // Próximo paso:
          // Navegar a OrderDetailView
        }
      }
    } catch (e) {
      print(
        'Error inicializando notificaciones: $e',
      );
    }
  }

  Future<void> _initializeLocalNotifications() async {

    const androidSettings =
        AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const settings =
        InitializationSettings(
      android: androidSettings,
    );

    await _localNotifications.initialize(
      settings,

      onDidReceiveNotificationResponse:
          (NotificationResponse response) {

        final orderId = response.payload;

       print(
         'NOTIFICACION TOCADA -> $orderId',
       );

       if (orderId != null) {
         navigatorKey.currentContext?.go(
           '/order-detail/$orderId',
         );
       }

      },
    );
  }

  Future<void> _showNotification(
    RemoteMessage message,
  ) async {
    const androidDetails =
        AndroidNotificationDetails(
      'orders_channel',
      'Orders',
      channelDescription:
          'Notificaciones de compras',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails =
        NotificationDetails(
      android: androidDetails,
    );
print('MOSTRANDO NOTIFICACION LOCAL');
    await _localNotifications.show(
      0,
      message.notification?.title ??
          'Nueva notificación',
      message.notification?.body ?? '',
      notificationDetails,
      payload:
          message.data['orderId'],
    );
  }

  Future<void> _saveToken(
    String? token,
  ) async {
    if (token == null) {
      print(
        'No se obtuvo token FCM',
      );
      return;
    }

    final user = _auth.currentUser;

    print(
      'CURRENT USER TOKEN SAVE: $user',
    );

    if (user == null) {
      print(
        'Usuario no autenticado',
      );
      return;
    }

    print(
      'UID A GUARDAR: ${user.uid}',
    );

    print(
      'EMAIL A GUARDAR: ${user.email}',
    );

    try {
      await _firestore
          .collection('tokens')
          .doc(user.uid)
          .set({
        'uid': user.uid,
        'email': user.email,
        'token': token,
        'updatedAt':
            FieldValue.serverTimestamp(),
      });

      print(
        '✅ TOKEN GUARDADO CORRECTAMENTE EN FIRESTORE',
      );
    } catch (e) {
      print(
        '❌ ERROR GUARDANDO TOKEN: $e',
      );
    }
  }
}