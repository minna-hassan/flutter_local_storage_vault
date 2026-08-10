import 'package:flutter/material.dart';
import 'package:flutter_database_assignment/services/password_hasher_service.dart';
import 'package:flutter_database_assignment/services/secure_storage_service.dart';
import 'package:go_router/go_router.dart';

class UnlockVaultScreen extends StatefulWidget {
  const UnlockVaultScreen({super.key});

  @override
  State<UnlockVaultScreen> createState() => _UnlockVaultScreenState();
}

class _UnlockVaultScreenState extends State<UnlockVaultScreen> {
  final passwordhash = HashService();
  final secureStorage = SecureStorageService();

  final masterPasswordController = TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    masterPasswordController.dispose();
    super.dispose();
  }

  Future<void> unlockVault() async {
    final password = masterPasswordController.text;

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your master password.')),
      );
      return;
    }

    final enteredPassword = passwordhash.passwordHasher(password);

    final savedPassword = await secureStorage.getData("master_key");

    if (enteredPassword == savedPassword) {
      context.go('/home');
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Incorrect master password.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.widthOf(context);
    final screenHeight = MediaQuery.heightOf(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),

        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  elevation: 8,
                  margin: EdgeInsets.only(top: screenHeight * 0.15),
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    'assets/images/symbol_logo.jpg',
                    fit: BoxFit.cover,
                    width: screenWidth * 0.22,
                    height: screenHeight * 0.11,
                  ),
                ),

                SizedBox(height: screenHeight * 0.025),

                Text(
                  'Personal Vault',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                ),

                SizedBox(height: screenHeight * 0.01),

                SizedBox(
                  width: screenWidth * 0.77,
                  child: Text(
                    'Enter your master password to unlock\nyour personal and sensitive vault data.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.2,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 117, 117, 117),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.05),

                SizedBox(
                  width: screenWidth * 0.81,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Master Password',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 66, 66, 66),
                          fontSize: 14,
                        ),
                      ),

                      SizedBox(height: 6),

                      TextFormField(
                        controller: masterPasswordController,
                        obscureText: obscurePassword,
                        style: TextStyle(fontSize: 14),

                        onFieldSubmitted: (_) {
                          unlockVault();
                        },

                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: 'Enter master password',
                          filled: true,
                          fillColor: Color.fromARGB(255, 245, 245, 245),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color.fromARGB(0, 0, 0, 0),
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color.fromARGB(0, 0, 0, 0),
                            ),
                          ),

                          suffixIcon: IconButton(
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: 22,
                            ),
                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.025),

                      Container(
                        alignment: AlignmentDirectional.centerStart,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color.fromARGB(255, 255, 253, 245),
                          border: Border.all(
                            color: Color.fromARGB(255, 245, 225, 200),
                            width: 1,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.02,
                          horizontal: screenWidth * 0.032,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              color: Color.fromARGB(255, 255, 185, 64),
                            ),

                            SizedBox(width: screenWidth * 0.01),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Make sure you remember this password.',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 157, 93, 15),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'It cannot be recovered if you forget it.',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 157, 93, 15),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.04),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 0, 0, 0),
                            foregroundColor: Color.fromARGB(255, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),

                          onPressed: unlockVault,

                          child: Text(
                            'Unlock Vault',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
