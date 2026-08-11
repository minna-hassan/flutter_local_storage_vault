import 'package:flutter/material.dart';
import 'package:flutter_database_assignment/dialog/add_notes_dialog.dart';
import 'package:flutter_database_assignment/dialog/add_password_dialog.dart';
import 'package:flutter_database_assignment/services/hive_service.dart';
import 'package:flutter_database_assignment/widget/empty_state_container.dart';
import 'package:flutter_database_assignment/widget/favourites_container.dart';
import 'package:flutter_database_assignment/widget/notes_container.dart';
import 'package:flutter_database_assignment/widget/password_container.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedCardIndex = 1;
  int selectedBottomIndex = 0;

  void openAddDialog() {
    showDialog(
      context: context,
      builder: (context) {
        if (selectedCardIndex == 2) {
          return AddNoteDialog();
        }

        return AddPasswordDialog();
      },
    );
  }

  Widget buildFloatingActionButton() {
    final screenWidth = MediaQuery.of(context).size.width;

    if (selectedCardIndex == 0) {
      if (HiveService.getPasswordCount() != 0 ||
          HiveService.getNotesCount() != 0) {
        return FloatingActionButton(
          onPressed: openAddDialog,
          backgroundColor: Colors.black,
          shape: CircleBorder(),
          child: Icon(Icons.add, color: Colors.white, size: screenWidth * 0.06),
        );
      }
    } else if (selectedCardIndex == 1) {
      if (HiveService.getPasswordCount() != 0) {
        return FloatingActionButton(
          onPressed: openAddDialog,
          backgroundColor: Colors.black,
          shape: CircleBorder(),
          child: Icon(Icons.add, color: Colors.white, size: screenWidth * 0.06),
        );
      }
    } else if (selectedCardIndex == 2) {
      if (HiveService.getNotesCount() != 0) {
        return FloatingActionButton(
          onPressed: openAddDialog,
          backgroundColor: Colors.black,
          shape: CircleBorder(),
          child: Icon(Icons.add, color: Colors.white, size: screenWidth * 0.06),
        );
      }
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    String sectionTitle = 'PASSWORDS';

    if (selectedCardIndex == 0) {
      sectionTitle = 'TOTAL RECORDS';
    } else if (selectedCardIndex == 2) {
      sectionTitle = 'NOTES';
    } else if (selectedCardIndex == 3) {
      sectionTitle = 'FAVORITES';
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 248, 249, 250),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: screenHeight * 0.065,
        titleSpacing: screenWidth * 0.045,
        title: Image.asset(
          "assets/images/combination_logo_black.png",
          height: screenHeight * 0.028,
          fit: BoxFit.contain,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.015),
            child: IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.black,
                size: screenWidth * 0.055,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),

      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.045,
            vertical: screenHeight * 0.012,
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: screenHeight * 0.052,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(screenWidth * 0.06),
                    border: Border.all(
                      color: Color.fromARGB(255, 235, 236, 239),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.035,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Color.fromARGB(255, 85, 85, 85),
                        size: screenWidth * 0.048,
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search by title, username or notes...',
                            hintStyle: TextStyle(
                              color: Color.fromARGB(255, 158, 158, 158),
                              fontSize: screenWidth * 0.032,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenHeight * 0.022),

                Text(
                  "Category",
                  style: TextStyle(
                    fontSize: screenWidth * 0.034,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: screenHeight * 0.012),

                ValueListenableBuilder(
                  valueListenable: HiveService.getPasswordListenable(),
                  builder: (context, pwdBox, pwdChild) {
                    return ValueListenableBuilder(
                      valueListenable: HiveService.getNotesListenable(),
                      builder: (context, noteBox, noteChild) {
                        final totalCount =
                            HiveService.getPasswordCount() +
                            HiveService.getNotesCount();

                        final pwdCount = HiveService.getPasswordCount();

                        final notesCount = HiveService.getNotesCount();

                        return Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: buildCategoryCard(
                                    index: 0,
                                    icon: Icons.grid_view_rounded,
                                    title: 'TOTAL',
                                    count: totalCount.toString(),
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.025),
                                Expanded(
                                  child: buildCategoryCard(
                                    index: 1,
                                    icon: Icons.key_rounded,
                                    title: 'PASSWORDS',
                                    count: pwdCount.toString(),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: screenHeight * 0.012),

                            Row(
                              children: [
                                Expanded(
                                  child: buildCategoryCard(
                                    index: 2,
                                    icon: Icons.description_outlined,
                                    title: 'NOTES',
                                    count: notesCount.toString(),
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.025),
                                Expanded(
                                  child: buildCategoryCard(
                                    index: 3,
                                    icon: Icons.star_border_rounded,
                                    title: 'FAVORITES',
                                    count: (HiveService.getPasswords().where((p) => p.isFavorite).length + HiveService.getNotes().where((n) => n.isFavorite).length).toString(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),

                SizedBox(height: screenHeight * 0.022),

                Text(
                  sectionTitle,
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    letterSpacing: 0.5,
                  ),
                ),

                SizedBox(height: screenHeight * 0.012),

                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: selectedCardIndex == 0
                        ? ValueListenableBuilder(
                            valueListenable:
                                HiveService.getPasswordListenable(),
                            builder: (context, pwdValue, pwdChild) {
                              return ValueListenableBuilder(
                                valueListenable:
                                    HiveService.getNotesListenable(),
                                builder: (context, noteValue, noteChild) {
                                  final passwords = HiveService.getPasswords();
                                  final notes = HiveService.getNotes();

                                  if (passwords.isEmpty && notes.isEmpty) {
                                    return EmptyStateContainer(
                                      onPress: openAddDialog,
                                    );
                                  }

                                  return SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        if (passwords.isNotEmpty)
                                          PasswordsContainer(
                                            passwordsList: passwords,
                                            onAddItemPressed: openAddDialog,
                                          ),
                                        if (passwords.isNotEmpty &&
                                            notes.isNotEmpty)
                                          SizedBox(
                                            height: screenHeight * 0.015,
                                          ),
                                        if (notes.isNotEmpty)
                                          NotesContainer(
                                            notesList: notes,
                                            onAddItemPressed: openAddDialog,
                                          ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          )
                        : selectedCardIndex == 1
                        ? ValueListenableBuilder(
                            valueListenable:
                                HiveService.getPasswordListenable(),
                            builder: (context, pwdValue, pwdChild) {
                              final passwords = HiveService.getPasswords();

                              if (passwords.isEmpty) {
                                return EmptyStateContainer(
                                  onPress: openAddDialog,
                                );
                              }

                              return PasswordsContainer(
                                passwordsList: passwords,
                                onAddItemPressed: openAddDialog,
                              );
                            },
                          )
                        : selectedCardIndex == 2
                        ? ValueListenableBuilder(
                            valueListenable: HiveService.getNotesListenable(),
                            builder: (context, noteValue, noteChild) {
                              final notes = HiveService.getNotes();

                              if (notes.isEmpty) {
                                return EmptyStateContainer(
                                  onPress: openAddDialog,
                                );
                              }

                              return NotesContainer(
                                notesList: notes,
                                onAddItemPressed: openAddDialog,
                              );
                            },
                          )
                        : ValueListenableBuilder(
                            valueListenable: HiveService.getPasswordListenable(),
                            builder: (context, pwdValue, pwdChild) {
                              return ValueListenableBuilder(
                                valueListenable: HiveService.getNotesListenable(),
                                builder: (context, noteValue, noteChild) {
                                  final favPasswords = HiveService.getPasswords().where((p) => p.isFavorite).toList();
                                  final favNotes = HiveService.getNotes().where((n) => n.isFavorite).toList();
                                  final List<dynamic> favoritesList = [...favPasswords, ...favNotes];

                                  return FavoritesContainer(
                                    favoritesList: favoritesList,
                                    onAddItemPressed: openAddDialog,
                                  );
                                },
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: Container(
        height: screenHeight * 0.08,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Color.fromARGB(255, 235, 236, 239)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavItem(
              index: 0,
              iconWidget: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.035,
                  vertical: screenHeight * 0.004,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(screenWidth * 0.025),
                ),
                child: Icon(
                  Icons.key,
                  color: Colors.white,
                  size: screenWidth * 0.045,
                ),
              ),
              label: 'Vault',
              isSelected: selectedBottomIndex == 0,
            ),

            buildNavItem(
              index: 1,
              iconWidget: Icon(
                Icons.settings,
                color: Color.fromARGB(255, 158, 158, 158),
                size: screenWidth * 0.055,
              ),
              label: 'Setting',
              isSelected: selectedBottomIndex == 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryCard({
    required int index,
    required IconData icon,
    required String title,
    required String count,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final isSelected = selectedCardIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCardIndex = index;
        });
      },
      child: Container(
        height: screenHeight * 0.14,
        padding: EdgeInsets.all(screenWidth * 0.035),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(screenWidth * 0.05),
          border: Border.all(
            color: isSelected
                ? Colors.black
                : Color.fromARGB(255, 235, 236, 239),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(screenWidth * 0.018),
              decoration: BoxDecoration(
                color: isSelected
                    ? Color.fromARGB(255, 255, 255, 255)
                    : Color.fromARGB(255, 240, 241, 243),
                borderRadius: BorderRadius.circular(screenWidth * 0.025),
              ),
              child: Icon(icon, size: screenWidth * 0.045, color: Colors.black),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: screenWidth * 0.025,
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? Colors.white.withOpacity(0.8)
                        : Color.fromARGB(255, 102, 102, 102),
                    letterSpacing: 0.5,
                  ),
                ),

                SizedBox(height: screenHeight * 0.001),

                Text(
                  count,
                  style: TextStyle(
                    fontSize: screenWidth * 0.055,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNavItem({
    required int index,
    required Widget iconWidget,
    required String label,
    required bool isSelected,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedBottomIndex = index;
        });

        if (index == 1) {
          setState(() {
            selectedBottomIndex = 0;
          });

          context.go('/settings');
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconWidget,

          SizedBox(height: screenHeight * 0.004),

          Text(
            label,
            style: TextStyle(
              fontSize: screenWidth * 0.026,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected
                  ? Colors.black
                  : Color.fromARGB(255, 158, 158, 158),
            ),
          ),
        ],
      ),
    );
  }
}
