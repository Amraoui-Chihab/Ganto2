import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int current_index = 0;
  late PageController _pageController = PageController();

  String currentlanguage = "English";

  //String button_text = "Next".tr;
  @override
  void initState() {
    super.initState();

    _pageController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _pageController.removeListener(_onScroll);
    _pageController.dispose();
    super.dispose();
  }

  void _onScroll() {
    int newPageIndex = _pageController.page!.round();

    if (newPageIndex != current_index) {
      setState(() {
        current_index = newPageIndex; // Update the current page index
      });
    }
  }

  List<String> Onboarding_images = [
    "assets/Onboarding/Onboarding_photo2.png",
    "assets/Onboarding/Onboarding_photo1.png",
    "assets/Onboarding/Onboarding_photo3.png"
  ];
  List<List<String>> quotes = [
    [
      "Shop Effortlessly",
      "Highlight the convenience of shopping for various products in categories like food, fashion, electronics..."
    ],
    [
      "Quick & Easy Checkout",
      "Emphasize the simplicity of the shopping process, from adding products to the cart to completing the purchase"
    ],
    [
      "Earn Rewards on Purchases",
      'Users can invite friends through a personalized link or QR code and earn a 10% commission on their friends\' orders'
    ]
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              width: MediaQuery.of(context).size.width * 90 / 100,
              height: MediaQuery.of(context).size.height * 50 / 100,
              child: PageView.builder(
                physics: ClampingScrollPhysics(),
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    child: FittedBox(
                      child: Image.asset(
                        Onboarding_images[index],
                        fit: BoxFit.cover,
                      ),
                      fit: BoxFit.cover,
                    ),
                  );
                },
                itemCount: Onboarding_images.length,
              ),
            ),
          ),
          Center(
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 37.7 / 100,
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 5 / 100,
                        child: Text(
                          quotes[current_index][0].tr,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 10 / 100,
                          child: Text(
                            quotes[current_index][1].tr,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                color: Colors.grey, fontSize: 15),
                          ),
                          width: MediaQuery.of(context).size.width * 9 / 10,
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 10 / 100,
                        width: MediaQuery.of(context).size.width * 90 / 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: List.generate(
                                  Onboarding_images.length,
                                  (index) {
                                    return Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 5,
                                          backgroundColor:
                                              current_index == index
                                                  ? Colors.blue
                                                  : Colors.grey,
                                        ),
                                        SizedBox(
                                          width: 3,
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ),
                              height:
                                  MediaQuery.of(context).size.height * 5 / 100,
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                backgroundColor:
                                    Colors.blue, // Set background color
                                side: BorderSide.none, // Remove the border
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      5), // Eliminate the border radius
                                ),
                              ),
                              onPressed: () {
                                if (current_index != 2) {
                                  _pageController.animateToPage(
                                    current_index + 1,
                                    duration: Duration(
                                        milliseconds:
                                            300), // Duration of the animation
                                    curve: Curves.easeInOut, // Animation curve
                                  );
                                } else {
                                  Get.toNamed("/intro");
                                }
                              },
                              child: Text(
                                current_index != 2
                                    ? "Next".tr
                                    : "Get started".tr,
                                style: GoogleFonts.poppins(
                                    color: Colors
                                        .white), // Set text color to white
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              width: MediaQuery.of(context).size.width,
            ),
          )
        ],
      ),
      appBar: AppBar(
        centerTitle: true,
        title: DropdownButton<String>(
          value: currentlanguage,

          icon: Icon(Icons.arrow_drop_down, color: Colors.black),
          dropdownColor: Colors.white,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.black),
          underline: SizedBox(), // Remove default underline
          onChanged: (String? newValue) {
            if (newValue == "English") {
              Get.updateLocale(Locale('en'));
            } else {
              Get.updateLocale(Locale('ar'));
            }
            setState(() {
              currentlanguage = newValue!;
            });
            //Navigator.pop(context);
          },
          items: <String>[
            'English',
            'Arabic',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        actions: [
          Container(
            width: 50,
            child: Center(
              child: InkWell(
                child: Text(
                  "Skip".tr,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.blue),
                ),
                onTap: () {
                  Get.toNamed("/intro");
                },
              ),
            ),
            margin: EdgeInsets.only(
                right: 20, left: currentlanguage == "Arabic" ? 20 : 0),
          )
        ],
        backgroundColor: Colors.grey[200],
      ),
    );
  }
}
