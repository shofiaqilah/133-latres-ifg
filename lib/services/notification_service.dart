import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/*
  bikin object olugin notifikasi. 
  panggil service ini tanpa harus bikin object baru
 */
class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  // FUNGSI PERTAMA
  /* 
  dipanggil di main.dart saat aplikasi pertama jalan
  fungsinya untuk nyiapin sistem notifikasi
   */
  static Future<void> init() async {
    // ini setting untuk android
    const AndroidInitializationSettings androidSettings =
        // incon notifikasi di android pake icon launcher app
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // ini setting buat iOS
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          // minta izin notif agar bisa tampil alert, badge, dan suara
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    // ini setting andro dan ios digabung
    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    // aktifkan plugin notifikasi
    await _notifications.initialize(settings: settings);

    // Request permissions for Android 13+
    final androidPlugin = _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await androidPlugin?.requestNotificationsPermission();
  }

  // FUNGSI KEDUA
  /*
  menampilan notifikasi ketika spell dihapus dari favorite
  parameter String = spellName
   */
  static Future<void> showDeleteNotification(String spellName) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'favorite_channel', // id channel notif
          'Favorite Spells', // nama channel
          channelDescription: 'Notifications for favorite spell actions',
          importance: Importance.high,
          priority: Priority.high,
        );

    // gabungin detail andro dan ios
    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    // nampilin notifikasi
    await _notifications.show(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: 'Delete notification',
      body: 'You deleted $spellName from your fav list!',
      notificationDetails: details,
    );
  }
}
