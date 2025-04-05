import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          'About Us'.tr,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              Container(

                margin: const EdgeInsets.only(top: 20),
                height: 100,
                width: 100,
                decoration: BoxDecoration(

                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    image: AssetImage('assets/logo.png'), // Replace with your app's logo
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // App Name
              Text(
                "Ganto",
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 10),
              // Tagline
              Text(
                "Your one-stop solution for eCommerce, Dropshipping, and Network Marketing!".tr,

                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              // About Section
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About Ganto".tr,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Ganto is a revolutionary eCommerce platform that combines the power of dropshipping and network marketing. We aim to empower individuals and businesses by providing a seamless shopping experience and opportunities to grow your network while earning rewards.".tr,
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Our mission is to create a platform where innovation meets convenience, enabling users to explore millions of products, sell with ease, and build a network that thrives on shared success.".tr,
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Features Section
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Why Choose Us".tr+"?",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _buildFeature(
                        "Wide Range of Products".tr,
                        "Explore millions of products across various categories, tailored to your needs.".tr,
                        Icons.shopping_cart_outlined,
                      ),
                      _buildFeature(
                        "Effortless Dropshipping".tr,
                        "Start your dropshipping business with no inventory hassle and easy order management.".tr,
                        Icons.local_shipping_outlined,
                      ),
                      _buildFeature(
                        "Network Marketing".tr,
                        "Earn rewards by building and growing your network. Share success with your connections!".tr,
                        Icons.people_outline,
                      ),
                      _buildFeature(
                        "Secure and Fast Transactions".tr,
                        "Enjoy safe and speedy payments with our trusted payment gateways.".tr,
                        Icons.lock_outline,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Footer
              Text(
                "© 2025 Ganto. All rights reserved.".tr,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Feature Widget
  Widget _buildFeature(String title, String description, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blueAccent, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
