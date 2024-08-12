import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vaccination/bloc/Userbloc/userbloc_bloc.dart';
import 'package:vaccination/bloc/auth_bloc/cubit/authcubit_cubit.dart';
import 'package:vaccination/screen/home/homepage.dart';
import 'package:vaccination/services/getuser.dart';
import 'package:vaccination/utils/utils.dart';
import 'package:vaccination/widgets/custom_button.dart';

import '../../bloc/Userbloc/userbloc_event.dart';
import '../../bloc/auth_bloc/cubit/authcubit_state.dart';

class UserInformationScreen extends StatefulWidget {
  const UserInformationScreen({Key? key}) : super(key: key);

  @override
  State<UserInformationScreen> createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {
  File? image;
  final userIdController = TextEditingController();
  final parentEmailController = TextEditingController();
  final childNameController = TextEditingController();
  final motherAadharController = TextEditingController();
  final childAadharController = TextEditingController();
  final childBirthDateController = TextEditingController();
  DateTime? selectedBirthDate; // Store the selected date

  @override
  void dispose() {
    super.dispose();
    userIdController.dispose();
    parentEmailController.dispose();
    childNameController.dispose();
    motherAadharController.dispose();
    childAadharController.dispose();
    childBirthDateController.dispose();
  }

  // for selecting image
  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  // for selecting date
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedBirthDate = picked; // Store the picked date
        childBirthDateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserEmptyState) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Error"),
                    content: Text("Please fill all the fields"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("OK"),
                      ),
                    ],
                  ),
                );
              } else if (state is UserInvalidIDState) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("User ID Instructions"),
                      content: Text(
                          "Your User ID should be alphanumeric and may contain underscores. Example: user_123 or UserID2024"),
                      actions: [
                        TextButton(
                          child: Text("OK"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              } else if (state is UserExistsState) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Error"),
                    content: Text("User ID already exists"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("OK"),
                      ),
                    ],
                  ),
                );
              } else if (state is UserLoginSuccessState) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => HomePage()),
                );
              } else if (state is UserErrorState) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Error"),
                    content: Text("login"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("OK"),
                      ),
                    ],
                  ),
                );
              }
            },
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 5.0),
                    child: Center(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () => selectImage(),
                            child: image == null
                                ? const CircleAvatar(
                              backgroundColor: Colors.purple,
                              radius: 50,
                              child: Icon(
                                Icons.account_circle,
                                size: 50,
                                color: Colors.white,
                              ),
                            )
                                : CircleAvatar(
                              backgroundImage: FileImage(image!),
                              radius: 50,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                            margin: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                // User ID field
                                textFeld(
                                  hintText: "User ID",
                                  icon: Icons.person,
                                  inputType: TextInputType.text,
                                  maxLines: 1,
                                  controller: userIdController,
                                ),

                                // Parent email
                                textFeld(
                                  hintText: "Parent's Email",
                                  icon: Icons.email,
                                  inputType: TextInputType.emailAddress,
                                  maxLines: 1,
                                  controller: parentEmailController,
                                ),

                                // Child name field
                                textFeld(
                                  hintText: "Child's Full Name",
                                  icon: Icons.child_care,
                                  inputType: TextInputType.name,
                                  maxLines: 1,
                                  controller: childNameController,
                                ),

                                // Mother's Aadhar number
                                textFeld(
                                  hintText: "Mother's Aadhar Number",
                                  icon: Icons.credit_card,
                                  inputType: TextInputType.number,
                                  maxLines: 1,
                                  controller: motherAadharController,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(12), // Limit to 12 digits
                                  ],
                                ),

                                // Child's Aadhar number
                                textFeld(
                                  hintText: "Child's Aadhar Number",
                                  icon: Icons.credit_card,
                                  inputType: TextInputType.number,
                                  maxLines: 1,
                                  controller: childAadharController,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(12), // Limit to 12 digits
                                  ],
                                ),

                                // Child's Birth Date
                                GestureDetector(
                                  onTap: () => _selectDate(context),
                                  child: AbsorbPointer(
                                    child: textFeld(
                                      hintText: "Child's Birth Date (DD/MM/YYYY)",
                                      icon: Icons.calendar_today,
                                      inputType: TextInputType.datetime,
                                      maxLines: 1,
                                      controller: childBirthDateController,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: CustomButton(
                              text: "Continue",
                              onPressed: () async {
                                print(ActiveUser.currentuser.loginValue!);
                                context.read<UserBloc>().add(
                                  UserInformationSaveEvent(
                                    loginValue: ActiveUser.currentuser.loginValue!,
                                    fullname: childNameController.text,
                                    userId: userIdController.text,
                                    parentemail: parentEmailController.text,
                                    motherAadharNo: motherAadharController.text,
                                    childAadharNo: childAadharController.text,
                                    birthdate: selectedBirthDate, // Pass the DateTime object
                                    profilePics: image != null ? [image!.path] : [],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget textFeld({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        cursorColor: Colors.purple,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.purple,
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          border: InputBorder.none,
          fillColor: Colors.purple.shade50,
          filled: true,
        ),
      ),
    );
  }
}
