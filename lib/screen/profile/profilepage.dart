import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:vaccination/bloc/auth_bloc/cubit/authcubit_state.dart';
import 'package:vaccination/screen/login/welcome_page.dart';
import 'package:vaccination/services/getuser.dart';

import '../../bloc/auth_bloc/cubit/authcubit_cubit.dart';
import '../../model/user_model.dart';

class ChildProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Users currentUser = ActiveUser.currentuser;

    final Map<String, IconData> childProfile = {
      'Full Name': Icons.person,
      'Date of Birth': Icons.cake,
      'Mother\'s Aadhar': Icons.credit_card,
      'Child\'s Aadhar': Icons.credit_card,
      'Parent Email': Icons.email,
      'Phone Number': Icons.phone,
    };

    final Map<String, String> childProfileValues = {
      'Full Name': currentUser.fullname ?? 'Not provided',
      'Date of Birth': currentUser.birthdate != null ? DateFormat('dd/MM/yyyy').format(currentUser.birthdate!) : 'Not provided',
      'Mother\'s Aadhar': currentUser.motherAadharNo ?? 'Not provided',
      'Child\'s Aadhar': currentUser.childAadharNo ?? 'Not provided',
      'Parent Email': currentUser.parentemail ?? 'Not provided',
      'Phone Number': currentUser.loginValue ?? 'Not provided',
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Child Profile', style: TextStyle(fontFamily: 'Raleway', fontSize: 24)),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: Icon(Icons.edit,color: Colors.black),
            onPressed: () {
              // Add edit functionality here
            },
          ),
        ],
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedOutState) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => WelcomeScreen()),
              (Route<dynamic> route) => false,
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            backgroundColor: Colors.transparent,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.93,
                              height: MediaQuery.of(context).size.height * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: currentUser.profilePics != null && currentUser.profilePics!.isNotEmpty
                                      ? Image.network(currentUser.profilePics!.first, fit: BoxFit.cover)
                                      : Image.asset('assets/profiles.jpg', fit: BoxFit.cover),
                                ),
                              ), 
                            ),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: currentUser.profilePics != null && currentUser.profilePics!.isNotEmpty
                            ? NetworkImage(currentUser.profilePics!.first)
                            : AssetImage('assets/profiles.jpg') as ImageProvider,
                        backgroundColor: Colors.purple,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      currentUser.userId ?? 'Not provided',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: childProfile.entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Icon(entry.value, color: Colors.purple),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      entry.key,
                                      style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      childProfileValues[entry.key] ?? 'Not provided',
                                      style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AuthCubit>(context).logOut();
                  },
                  child: Text('Logout', style: TextStyle(fontFamily: 'Raleway', fontSize: 18,color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
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
