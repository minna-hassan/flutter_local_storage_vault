import 'package:flutter/material.dart';
import 'package:flutter_database_assignment/screens/home_screen.dart';
import 'package:flutter_database_assignment/services/password_hasher_service.dart';
import 'package:flutter_database_assignment/services/secure_storage_service.dart';
import 'package:go_router/go_router.dart';

class VaultSetupScreen extends StatefulWidget {
  const VaultSetupScreen({super.key});

  @override
  State<VaultSetupScreen> createState() => _VaultSetupScreenState();
}

class _VaultSetupScreenState extends State<VaultSetupScreen> {
  final passwordhash = HashService();
  final secureStorage = SecureStorageService();
  final masterPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  void dispose() {
    masterPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void createVault() {
    final password = masterPasswordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please create a master password.')),
      );
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Master password must be at least 6 characters.'),
        ),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Passwords do not match.')));
      return;
    }

    var encryptedPassword = passwordhash.passwordHasher(password);
    secureStorage.saveData("master_key", encryptedPassword);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Vault created successfully!")));
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
                  margin: EdgeInsets.only(top: screenHeight * 0.12),
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

                SizedBox(height: screenHeight * 0.02),

                Text(
                  'Personal Vault',
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),

                SizedBox(height: screenHeight * 0.01),

                SizedBox(
                  width: screenWidth * 0.77,
                  child: Text(
                    'Create a master password to lock and protect\nyour personal and sensitive vault data.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenWidth * 0.032,
                      height: 1.2,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 117, 117, 117),
                    ),
                  ),
                ),

                SizedBox(height: screenHeight * 0.04),

                SizedBox(
                  width: screenWidth * 0.81,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create Master Password',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 66, 66, 66),
                          fontSize: screenWidth * 0.035,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.007),

                      TextFormField(
                        controller: masterPasswordController,
                        obscureText: obscurePassword,
                        style: TextStyle(fontSize: screenWidth * 0.032),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 158, 158, 158),
                            fontSize: screenWidth * 0.03,
                          ),
                          hintText: 'Enter master password',
                          filled: true,
                          fillColor: Color.fromARGB(255, 255, 255, 255),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 224, 224, 224),
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 224, 224, 224),
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 200, 200, 200),
                            ),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                            child: Icon(
                              obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: screenWidth * 0.055,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

                      Text(
                        'Confirm Master Password',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 66, 66, 66),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.007),

                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: obscureConfirmPassword,
                        style: TextStyle(fontSize: screenWidth * 0.032),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 158, 158, 158),
                            fontSize: screenWidth * 0.03,
                          ),
                          hintText: 'Re-enter master password',
                          filled: true,
                          fillColor: Color.fromARGB(255, 255, 255, 255),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 224, 224, 224),
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 224, 224, 224),
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 200, 200, 200),
                            ),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                obscureConfirmPassword =
                                    !obscureConfirmPassword;
                              });
                            },
                            child: Icon(
                              obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: screenWidth * 0.055,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.03),

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
                          vertical: screenHeight * 0.025,
                          horizontal: screenWidth * 0.032,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              color: Color.fromARGB(255, 255, 185, 64),
                              size: screenWidth * 0.05,
                            ),
                            SizedBox(width: screenWidth * 0.01),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Make sure you remember this password.',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.03,
                                      color: Color.fromARGB(255, 157, 93, 15),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'It cannot be recovered if you forget it.',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.03,
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

                      SizedBox(height: screenHeight * 0.07),

                      SizedBox(
                        width: double.infinity,
                        height: screenHeight * 0.06,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 0, 0, 0),
                            foregroundColor: Color.fromARGB(255, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: createVault,
                          child: Text(
                            'Create Vault',
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
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
