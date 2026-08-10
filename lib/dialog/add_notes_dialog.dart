import 'package:flutter/material.dart';
import 'package:flutter_database_assignment/services/hive_service.dart';

class AddNoteDialog extends StatefulWidget {
  const AddNoteDialog({super.key});

  @override
  State<AddNoteDialog> createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends State<AddNoteDialog> {
  final titleController = TextEditingController();
  final noteContentController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    noteContentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.widthOf(context);
    final screenHeight = MediaQuery.heightOf(context);

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
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.016,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.description_rounded,
                        color: Color.fromARGB(255, 255, 255, 255),
                        size: screenWidth * 0.05,
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Text(
                        'Add Secure Note',
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
                    'TITLE *',
                    style: TextStyle(
                      fontSize: screenWidth * 0.028,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 51, 51, 51),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.006),

                  TextFormField(
                    controller: titleController,
                    style: TextStyle(fontSize: screenWidth * 0.032),
                    decoration: InputDecoration(
                      hintText: 'e.g. WiFi Password, Recovery Key, Pin',
                      hintStyle: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: Color.fromARGB(255, 170, 170, 170),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 216, 216, 216),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.015),

                  Text(
                    'NOTE CONTENT',
                    style: TextStyle(
                      fontSize: screenWidth * 0.028,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 51, 51, 51),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.006),

                  TextFormField(
                    controller: noteContentController,
                    maxLines: 5,
                    style: TextStyle(fontSize: screenWidth * 0.032),
                    decoration: InputDecoration(
                      hintText: 'Enter secure note details...',
                      hintStyle: TextStyle(
                        fontSize: screenWidth * 0.03,
                        color: Color.fromARGB(255, 170, 170, 170),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 216, 216, 216),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
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
                                borderRadius: BorderRadius.circular(
                                  screenWidth * 0.02,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              if (titleController.text.isNotEmpty &&
                                  noteContentController.text.isNotEmpty) {
                                await HiveService.addNote(
                                  content: noteContentController.text.trim(),
                                  title: titleController.text.trim(),
                                );
                              }
                              Navigator.pop(context);
                            },
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
                                borderRadius: BorderRadius.circular(
                                  screenWidth * 0.02,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              if (titleController.text.isNotEmpty &&
                                  noteContentController.text.isNotEmpty) {
                                await HiveService.addNote(
                                  title: titleController.text.trim(),
                                  content: noteContentController.text.trim(),
                                );
                              }
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.check_rounded,
                              size: screenWidth * 0.04,
                            ),
                            label: Text(
                              'Save Note',
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
