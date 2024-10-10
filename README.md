# Vaccination App

## 📲 Overview

The **Vaccination App** is a mobile application designed to help parents manage their child's vaccination schedules with ease. The app allows users to register, input the child's details, and track upcoming and completed vaccinations based on the child's birth date. With timely reminders, this app ensures that no vaccination is missed, providing a reliable and user-friendly experience for parents.

## ✨ Features

- **User Registration**: Secure authentication with email and mobile number.
- **Child Profile Management**: Store details like child’s full name, birthdate, Aadhar number, and parent email.
- **Personalized Vaccination Schedule**: Automatically generates a vaccination schedule based on the child’s birthdate.
- **Schedule Tracking**: View completed, pending, and upcoming vaccinations in an intuitive list.
- **Timely Notifications**: Get reminders on the vaccination due date to ensure vaccinations are completed on time.
- **Customizable Notifications**: Mark vaccinations as completed or snooze reminders if necessary.
- **Data Security**: Ensures secure storage of user and child data using Firebase.

## 🛠️ Tech Stack

- **Flutter**: For building a cross-platform mobile app with a beautiful UI.
- **Firebase**: Backend services including Firestore for database, Firebase Authentication, and Firebase Cloud Messaging for notifications.
- **Bloc Pattern**: State management using the Bloc library for efficient data handling and reactive UI updates.
- **Dart**: Programming language used for Flutter app development.

## 🧠 Architecture

The app follows a **Bloc architecture** to separate business logic from the UI. This makes the app scalable and maintainable, ensuring that data and state changes are handled efficiently throughout the user journey.

- **State Management**: Uses Bloc to handle user authentication, fetching vaccination schedules, and updating the state based on user actions.
- **Firestore Database**: Stores user data and vaccination schedules for easy retrieval and updates.
- **Firebase Cloud Messaging**: Used to send timely reminders and notifications to users regarding upcoming vaccinations.

## 🚀 Getting Started

Follow these steps to set up the app locally:

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) installed.
- [Firebase account](https://firebase.google.com/) set up with a Firestore database.
- Clone the repository:
  ```bash
  git clone https://github.com/shaktikadam1630/VaccinationApp_project
