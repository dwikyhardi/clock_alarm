import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'src/app.dart';
import 'src/core/di/injection_container.dart' as di;
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'src/core/notification/notification.dart' as notif;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'Clock_notification_channel',
  'ClockAlarm',
  description: 'ClockAlarm notification channel',
  importance: Importance.max,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  di
      .sl<FlutterLocalNotificationsPlugin>()
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  di.sl<notif.Notification>().initializing();

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  runApp(
    DevicePreview(
      builder: (BuildContext context) => MyApp(
        settingsController: settingsController,
      ),
      // enabled: !kReleaseMode,
      enabled: false,
    ),
  );
}
