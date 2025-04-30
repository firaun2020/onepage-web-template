import 'package:flutter/material.dart';

String getContentForMenu(String item) {
  switch (item) {
    case "Home":
      return "Welcome to ANØM Web!";
    case "About":
      return "We are a secure communication platform.";
    case "Services":
      return "We provide encrypted messaging services.";
    case "Contact":
      return "Get in touch with us through email!";
    default:
      return "Select a menu item.";
  }
}

Widget gettingContent(String item) {
  switch (item) {
    case "Home":
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your conversations. Your privacy. Your rules.",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              "We’re tired of tech giants selling your data, banning your voice, and locking you out of your digital life.\n"
              "ANØM CHAT is here to change that — forever.",
              style: TextStyle(fontSize: 18, height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              "No phone numbers. No emails. No IDs.\n"
              "Create an account anonymously in seconds. Stay anonymous as long as you want.",
              style: TextStyle(fontSize: 18, height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              "Fully encrypted, fully safe.\n"
              "Your messages are broken into pieces, encrypted, and stored in different parts of the world.\n"
              "Nobody — not even us — can see your chats. If one server is compromised, your data stays safe.",
              style: TextStyle(fontSize: 18, height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              "Total control.\n"
              "Delete your account any time. When you wipe it, it’s gone — no backups, no traces, no shadow copies.",
              style: TextStyle(fontSize: 18, height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              "No ads. No selling out.\n"
              "We’re open source. That means no secret trackers, no creepy algorithms, no middlemen making money off your life.",
              style: TextStyle(fontSize: 18, height: 1.5),
            ),
            SizedBox(height: 20),
            Text(
              "Community-powered.\n"
              "Rules aren’t decided in a boardroom. They’re decided by you. Vote, debate, and shape the future of the platform together.",
              style: TextStyle(fontSize: 18, height: 1.5),
            ),
          ],
        ),
      );
    case "About":
      return Text("We are a secure communication platform.");
    case "Services":
      return Text("We provide encrypted messaging services.");
    case "Contact":
      return Text("Get in touch with us through email!");
    default:
      return Text("Select a menu item.");
  }
}
