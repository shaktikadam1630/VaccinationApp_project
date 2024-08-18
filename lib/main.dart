import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vaccination/bloc/Userbloc/userbloc_bloc.dart';
import 'package:vaccination/bloc/auth_bloc/cubit/authcubit_cubit.dart';
import 'package:vaccination/bloc/auth_bloc/cubit/authcubit_state.dart';
import 'package:vaccination/bloc/schedulebloc/bloc/schedule_bloc.dart';
import 'package:vaccination/screen/home/homepage.dart';
import 'package:vaccination/services/getuser.dart';
import 'package:vaccination/services/notification_servce.dart';
import 'package:vaccination/widgets/bottom_nav.dart';

import 'screen/login/welcome_page.dart';



void main() async {
  
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDa76JREmLIt9mulxmUWnfuKNcKfem1SHI",
      appId: "1:475729654953:android:ae916e2dc0518e4ccbe5b8",
      storageBucket:"vaccinationapp-bd2d9.appspot.com",
      messagingSenderId: '475729654953',
      projectId: "vaccinationapp-bd2d9",
    ),
  );
//await NotificationService.initialize();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<ScheduleBloc>(
          create: (context) => ScheduleBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().checkUserStatus();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
              backgroundColor: Colors.black,
            );
          } else if (state is AuthCheckExists) {
            return FutureBuilder<Map<String, dynamic>?>(
              future: ActiveUser.getUserData(state.userId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(child: Text('Error fetching data')),
                  );
                } else if (snapshot.hasData) {
                  final userData = snapshot.data!;
                  if (userData['birthdate'] is Timestamp) {
                    userData['birthdate'] = (userData['birthdate'] as Timestamp).toDate();
                  }

                  return bottomNavigationBar();
                } else {
                  return WelcomeScreen();
                }
              },
            );
          } else {
            return WelcomeScreen(); // Handle other states if needed
          }
        },
      ),
      title: "Vaccination App",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}