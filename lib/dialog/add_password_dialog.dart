import 'package:flutter/material.dart';
import 'package:flutter_database_assignment/services/hive_service.dart';
import 'package:flutter_database_assignment/model/password_model.dart';

class AddPasswordDialog extends StatefulWidget {
  const AddPasswordDialog({super.key});

  @override
  State<AddPasswordDialog> createState() => _AddPasswordDialogState();
}

class _AddPasswordDialogState extends State<AddPasswordDialog> {
  final titleController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final websiteController = TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    titleController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    websiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
      child: SingleChildScrollView(
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
                      Icon(
                        Icons.key_rounded,
                        color: Color.fromARGB(255, 255, 255, 255),
                        size: screenWidth * 0.05,
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Text(
                        'Add Password',
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
                  SizedBox(height: screenHeight * 0.015),

                  Text(
                    'TITLE',
                    style: TextStyle(
                      fontSize: screenWidth * 0.029,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 51, 51, 51),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.006),

                  TextFormField(
                    controller: titleController,
                    style: TextStyle(fontSize: screenWidth * 0.032),
                    decoration: InputDecoration(
                      hintText: 'e.g. Netflix, Gmail',
                      hintStyle: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: Color.fromARGB(255, 170, 170, 170),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 216, 216, 216),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.015),

                  Text(
                    'USERNAME / EMAIL',
                    style: TextStyle(
                      fontSize: screenWidth * 0.029,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 51, 51, 51),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.006),

                  TextFormField(
                    controller: usernameController,
                    style: TextStyle(fontSize: screenWidth * 0.032),
                    decoration: InputDecoration(
                      hintText: 'e.g. user@example.com',
                      hintStyle: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: Color.fromARGB(255, 170, 170, 170),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 216, 216, 216),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.015),

                  Text(
                    'PASSWORD',
                    style: TextStyle(
                      fontSize: screenWidth * 0.029,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 51, 51, 51),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.006),

                  TextFormField(
                    controller: passwordController,
                    obscureText: obscurePassword,
                    style: TextStyle(fontSize: screenWidth * 0.032),
                    decoration: InputDecoration(
                      hintText: 'Enter password',
                      hintStyle: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: Color.fromARGB(255, 170, 170, 170),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                        child: Icon(
                          obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: screenWidth * 0.045,
                          color: Color.fromARGB(255, 119, 119, 119),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 216, 216, 216),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
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
                              foregroundColor: Color.fromARGB(255, 17, 17, 17),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Back',
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
                          child: ElevatedButton.icon(
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
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () async {
                              if (usernameController.text.isNotEmpty &&
                                  titleController.text.isNotEmpty &&
                                  passwordController.text.isNotEmpty) {
                                await HiveService.addPassword(
                                  password: passwordController.text.trim(),
                                  title: titleController.text.trim(),
                                  username:
                                      usernameController.text.trim().isNotEmpty
                                      ? usernameController.text.trim()
                                      : 'No username',
                                );
                              }
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.check_rounded,
                              size: screenWidth * 0.04,
                            ),
                            label: Text(
                              'Save Record',
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
      ),
    );
  }
}
