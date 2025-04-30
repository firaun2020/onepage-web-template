import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:anomweb/menubar.dart';
import 'package:anomweb/scrollshow.dart';

void main() => runApp(AnomWebApp());

class AnomWebApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ANØM Web',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey servicesKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  bool showBackToTopButton = false;

  final List<String> imageUrls = List.generate(
    24,
    (index) => 'lib/images/${index + 1}.png',
  );

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset > 200 && !showBackToTopButton) {
        setState(() => showBackToTopButton = true);
      } else if (_scrollController.offset <= 200 && showBackToTopButton) {
        setState(() => showBackToTopButton = false);
      }
    });
  }

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  void onMenuItemSelected(String item) {
    if (item == "About") {
      scrollToSection(aboutKey);
    } else if (item == "Services") {
      scrollToSection(servicesKey);
    } else if (item == "Contact") {
      scrollToSection(contactKey);
    } else {
      _scrollController.animateTo(
        0,
        duration: Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Hero Section
                Container(
                  height: screenHeight,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: screenHeight),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 60),
                          Text(
                            "ANØM",
                            style: GoogleFonts.audiowide(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 5,
                            ),
                          ),
                          const SizedBox(height: 30),
                          MenuWidget(onItemSelected: onMenuItemSelected),
                          const SizedBox(height: 40),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Placeholder(
                              color: Colors.deepPurple,
                              strokeWidth: 2,
                              fallbackHeight: 400,
                            ),
                          ),
                          const SizedBox(height: 100),
                          ScrollingImageStrip(imageUrls: imageUrls),
                        ],
                      ),
                    ),
                  ),
                ),

                // About Section
                Container(
                  key: aboutKey,
                  height: screenHeight,
                  width: double.infinity,
                  color: Colors.grey.shade100,
                  child: Center(
                    child: Placeholder(color: Colors.teal, strokeWidth: 2),
                  ),
                ),

                // Services Section
                Container(
                  key: servicesKey,
                  height: screenHeight,
                  width: double.infinity,
                  color: Colors.grey.shade200,
                  child: Center(
                    child: Placeholder(
                      color: Colors.blueAccent,
                      strokeWidth: 2,
                    ),
                  ),
                ),

                // Contact Section
                Container(
                  key: contactKey,
                  height: screenHeight,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                  child: Center(
                    child: Placeholder(color: Colors.orange, strokeWidth: 2),
                  ),
                ),
              ],
            ),
          ),

          // Back to Top Button
          if (showBackToTopButton)
            Positioned(
              bottom: 30,
              right: 30,
              child: FloatingActionButton(
                onPressed: () {
                  _scrollController.animateTo(
                    0,
                    duration: Duration(milliseconds: 600),
                    curve: Curves.easeInOut,
                  );
                },
                backgroundColor: Colors.black,
                child: Icon(Icons.arrow_upward, color: Colors.white),
                tooltip: "Back to Top",
              ),
            ),
        ],
      ),
    );
  }
}
