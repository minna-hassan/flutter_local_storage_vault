import 'package:flutter/material.dart';
import 'package:flutter_database_assignment/services/password_hasher_service.dart';
import 'package:flutter_database_assignment/services/secure_storage_service.dart';
import 'package:flutter_database_assignment/services/sharedpref_service.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool biometricEnabled = false;
  bool notificationsEnabled = true;

  String autoLockTime = 'Immediately';

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final lockTime = await SharedprefService.getAutoLockTime();
    final notifs = await SharedprefService.getNotifications();
    final biometric = await SharedprefService.getBiometric();
    {
      setState(() {
        autoLockTime = lockTime;
        notificationsEnabled = notifs;
        biometricEnabled = biometric;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 249, 251),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        surfaceTintColor: Color.fromARGB(0, 0, 0, 0),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Color.fromARGB(255, 255, 255, 255),
            size: 20,
          ),
          onPressed: () => context.go('/home'),
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.045,
            vertical: screenHeight * 0.025,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ACCOUNT',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 17, 17, 17),
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: screenHeight * 0.012),
              settingsCard(
                children: [
                  settingsItem(
                    icon: Icons.email_outlined,
                    title: 'Email Address',
                    subtitle: 'user@example.com',
                    trailing: Icons.chevron_right,
                  ),
                  divider(),
                  settingsItem(
                    icon: Icons.lock_outline,
                    title: 'Change Master Password',
                    subtitle: 'Change your vault password',
                    trailing: Icons.chevron_right,
                    onTap: () {
                      showChangePasswordDialog();
                    },
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),

              Text(
                'SECURITY',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 17, 17, 17),
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: screenHeight * 0.012),
              settingsCard(
                children: [
                  settingsItem(
                    icon: Icons.fingerprint,
                    title: 'Biometric Unlock',
                    subtitle: 'Use TouchID / FaceID',
                    trailingWidget: Transform.scale(
                      scale: 0.85,
                      child: Switch(
                        value: biometricEnabled,
                        activeColor: Color.fromARGB(255, 255, 255, 255),
                        activeTrackColor: Color.fromARGB(255, 0, 0, 0),
                        inactiveThumbColor: Color.fromARGB(255, 255, 255, 255),
                        inactiveTrackColor: Color.fromARGB(255, 224, 224, 224),
                        onChanged: (value) async {
                          setState(() {
                            biometricEnabled = value;
                          });
                          await SharedprefService.saveBiometric(value);
                        },
                      ),
                    ),
                  ),
                  divider(),
                  settingsItem(
                    icon: Icons.timer_outlined,
                    title: 'Auto-lock Timer',
                    subtitle: autoLockTime,
                    trailing: Icons.chevron_right,
                    onTap: () {
                      showAutoLockDialog();
                    },
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),

              Text(
                'PREFERENCES',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 17, 17, 17),
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: screenHeight * 0.012),
              settingsCard(
                children: [
                  settingsItem(
                    icon: Icons.palette_outlined,
                    title: 'Appearance',
                    subtitle: 'System Default',
                    trailing: Icons.chevron_right,
                  ),
                  divider(),
                  settingsItem(
                    icon: Icons.notifications_none,
                    title: 'Notifications',
                    subtitle: 'Security alerts and reminders',
                    trailingWidget: Transform.scale(
                      scale: 0.85,
                      child: Switch(
                        value: notificationsEnabled,
                        activeColor: Color.fromARGB(255, 255, 255, 255),
                        activeTrackColor: Color.fromARGB(255, 0, 0, 0),
                        inactiveThumbColor: Color.fromARGB(255, 255, 255, 255),
                        inactiveTrackColor: Color.fromARGB(255, 224, 224, 224),
                        onChanged: (value) async {
                          setState(() {
                            notificationsEnabled = value;
                          });
                          await SharedprefService.saveNotifications(value);
                        },
                      ),
                    ),
                    trailing: null,
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),

              Text(
                'ABOUT',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 17, 17, 17),
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: screenHeight * 0.012),
              settingsCard(
                children: [
                  settingsItem(
                    icon: Icons.info_outline,
                    title: 'Version',
                    subtitle: 'v1.0.0',
                    trailing: null,
                    trailingWidget: null,
                    onTap: () {},
                  ),
                  divider(),
                  settingsItem(
                    icon: Icons.gavel_outlined,
                    title: 'Legal & Privacy',
                    trailing: Icons.chevron_right,
                    subtitle: '',
                    trailingWidget: null,
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget settingsCard({required List<Widget> children}) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        border: Border.all(color: Color.fromARGB(255, 216, 216, 216)),
        borderRadius: BorderRadius.circular(screenWidth * 0.03),
      ),
      child: Column(children: children),
    );
  }

  Widget settingsItem({
    required IconData icon,
    required String title,
    String? subtitle,
    IconData? trailing,
    Widget? trailingWidget,
    VoidCallback? onTap,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: Color.fromARGB(222, 0, 0, 0), size: 24),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 34, 34, 34),
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 158, 158, 158),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailingWidget != null) trailingWidget,
            if (trailing != null)
              Icon(
                trailing,
                color: Color.fromARGB(255, 158, 158, 158),
                size: 22,
              ),
          ],
        ),
      ),
    );
  }

  Widget divider() {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
        left: screenWidth * 0.165,
        right: screenWidth * 0.04,
      ),
      child: Container(height: 1, color: Color.fromARGB(255, 238, 238, 238)),
    );
  }

  void showChangePasswordDialog() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    showDialog(
      context: context,
      builder: (context) {
        final oldController = TextEditingController();
        final newController = TextEditingController();

        return Dialog(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          insetPadding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.045,
            vertical: screenHeight * 0.025,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.025),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Color.fromARGB(255, 0, 0, 0),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.018,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Change Password',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: screenWidth * 0.038,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close_rounded,
                        color: Color.fromARGB(255, 255, 255, 255),
                        size: screenWidth * 0.05,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.045,
                  vertical: screenHeight * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'OLD MASTER PASSWORD',
                      style: TextStyle(
                        fontSize: screenWidth * 0.029,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 51, 51, 51),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.006),
                    TextFormField(
                      controller: oldController,
                      obscureText: true,
                      style: TextStyle(fontSize: screenWidth * 0.032),
                      decoration: InputDecoration(
                        hintText: 'Enter old password',
                        hintStyle: TextStyle(
                          fontSize: screenWidth * 0.03,
                          color: Color.fromARGB(255, 170, 170, 170),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            screenWidth * 0.038,
                          ),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 216, 216, 216),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            screenWidth * 0.038,
                          ),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Text(
                      'NEW MASTER PASSWORD',
                      style: TextStyle(
                        fontSize: screenWidth * 0.029,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 51, 51, 51),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.006),
                    TextFormField(
                      controller: newController,
                      obscureText: true,
                      style: TextStyle(fontSize: screenWidth * 0.032),
                      decoration: InputDecoration(
                        hintText: 'Enter new password',
                        hintStyle: TextStyle(
                          fontSize: screenWidth * 0.03,
                          color: Color.fromARGB(255, 170, 170, 170),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            screenWidth * 0.038,
                          ),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 216, 216, 216),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            screenWidth * 0.038,
                          ),
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.025),

                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: screenHeight * 0.05,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(
                                  255,
                                  233,
                                  235,
                                  238,
                                ),
                                foregroundColor: Color.fromARGB(
                                  255,
                                  17,
                                  17,
                                  17,
                                ),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    screenWidth * 0.025,
                                  ),
                                ),
                              ),
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.035,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.025),
                        Expanded(
                          child: SizedBox(
                            height: screenHeight * 0.05,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 0, 0, 0),
                                foregroundColor: Color.fromARGB(
                                  255,
                                  255,
                                  255,
                                  255,
                                ),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    screenWidth * 0.025,
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                if (oldController.text.isNotEmpty &&
                                    newController.text.isNotEmpty) {
                                  final secureStorage = SecureStorageService();
                                  final hashService = HashService();
                                  final storedHash = await secureStorage
                                      .getData("master_key");
                                  if (hashService.passwordHasher(
                                        oldController.text,
                                      ) ==
                                      storedHash) {
                                    await secureStorage.saveData(
                                      "master_key",
                                      hashService.passwordHasher(
                                        newController.text,
                                      ),
                                    );
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Master password updated successfully!',
                                          ),
                                        ),
                                      );
                                    }
                                  } else {
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Incorrect old password.',
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                }
                              },
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.035,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showAutoLockDialog() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          insetPadding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.045,
            vertical: screenHeight * 0.025,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.025),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Color.fromARGB(255, 0, 0, 0),
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.018,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Auto-lock Timer',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: screenWidth * 0.038,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close_rounded,
                        color: Color.fromARGB(255, 255, 255, 255),
                        size: screenWidth * 0.05,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                child: Column(
                  children: [
                    autoLockOption('Immediately'),
                    autoLockOption('1 minute'),
                    autoLockOption('5 minutes'),
                    autoLockOption('15 minutes'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget autoLockOption(String value) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () async {
        setState(() {
          autoLockTime = value;
        });
        await SharedprefService.saveAutoLockTime(value);
        if (context.mounted) Navigator.pop(context);
      },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.06,
          vertical: screenHeight * 0.014,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 34, 34, 34),
              ),
            ),
            if (autoLockTime == value)
              Icon(
                Icons.check_circle_rounded,
                color: Color.fromARGB(255, 0, 0, 0),
                size: screenWidth * 0.05,
              ),
          ],
        ),
      ),
    );
  }
}
