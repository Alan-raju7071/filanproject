
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Utilits/constants/colorconstant.dart';
import 'package:flutter_application_1/Utilits/constants/text_constants.dart';
import 'package:flutter_application_1/view/Search_Book/Search_Book.dart';
import 'package:flutter_application_1/view/login_screen/Login_screen.dart';
import 'package:flutter_application_1/widgets/Appbar_title.dart';
import 'package:flutter_application_1/widgets/BannerCarousel.dart';
import 'package:flutter_application_1/widgets/DashboardIconButton.dart';
import 'package:flutter_application_1/widgets/StatusItem.dart';
import 'package:flutter_application_1/widgets/custom_button.dart';
import 'package:flutter_application_1/widgets/location_banner_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Dashboaerd_Homescreen extends StatefulWidget {
  const Dashboaerd_Homescreen({super.key});

  @override
  State<Dashboaerd_Homescreen> createState() => _Dashboaerd_HomescreenState();
}

class _Dashboaerd_HomescreenState extends State<Dashboaerd_Homescreen> {
  String selectedLocation = 'Ernakulam';

List<Map<String, String>> locationBasedBanners = [];
String? userName;
@override
void initState() {
  super.initState();
  fetchUserName();
  updateLocationBanners(selectedLocation);
}

void updateLocationBanners(String location) {
  setState(() {
    locationBasedBanners = locationBannerMap[location] ?? [];
  });
}
Future<void> _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}
 Future<void> fetchUserName() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) {
        debugPrint(" User UID is null");
        return;
      }
  final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
if (!mounted) return;
 if (doc.exists && doc.data()!.containsKey('name')) {
        final name = doc['name'];
        debugPrint(" Fetched user name: $name");
        setState(() {
          userName = name;
        });
      } else {
        debugPrint(" Document missing or name not found for UID: $uid");
      }
    } catch (e) {
      debugPrint(" Error fetching username: $e");
    }
  }
 String getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 17) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }
Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
if (!context.mounted) return;
Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colorconstants.primarywhite,
        elevation: 0,
        title: AppbarTitle(userName: userName ?? ""),
        actions: [ CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.notifications, color: Colors.white),
                ),],
      ),
      body: Stack(
  children: [
    SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Padding(
  padding: const EdgeInsets.only(bottom: 12.0),
  child: DropdownButton<String>(
    value: selectedLocation,
    onChanged: (String? newValue) {
      if (newValue != null) {
        setState(() {
          selectedLocation = newValue;
          updateLocationBanners(newValue);
        });
      }
    },
    items: locationBannerMap.keys.map((String location) {
      return DropdownMenuItem<String>(
        value: location,
        child: Text(location),
      );
    }).toList(),
  ),
),
 Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: BannerCarousel(
  banners: locationBasedBanners,
  height: MediaQuery.of(context).size.height * 0.25,
),
),
         if (userName != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                child: Text(
                  "${getGreetingMessage()}, $userName ",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
        Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16.0),
  child: Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          StatusItem(
            icon: Icons.account_balance_wallet,
            label: 'Wallet',
            value: '₹500',
          ),
          StatusItem(
            icon: Icons.star,
            label: 'Credits',
            value: '10',
            iconColor: Colorconstants.gold,
          ),
          StatusItem(
            icon: Icons.check_circle,
            label: 'Tasks',
            value: '15',
          ),
        ],
      ),
    ),
  ),
),
Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Card(
                elevation: 3,
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                     DashboardIconButton(
  icon: Icons.add_task,
  label: 'New Task',
  onTap: () => debugPrint('New Task tapped'),
),
DashboardIconButton(
  icon: Icons.card_giftcard,
  label: 'Invite & Earn',
  onTap: () => debugPrint('Invite tapped'),
  iconColor: Colors.purple,
),
DashboardIconButton(
  icon: Icons.account_balance_wallet_outlined,
  label: 'Wallet',
  onTap: () => debugPrint('Wallet tapped'),
  iconColor: Colors.green,
),
DashboardIconButton(
  icon: Icons.history,
  label: 'Task History',
  onTap: () => debugPrint('History tapped'),
  iconColor: Colors.orange,
),

                    ],
                  ),
                ),
              ),
            ),
         Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: BannerCarousel(
  banners: locationBasedBanners,
  height: MediaQuery.of(context).size.height * 0.20,
),
),
            const SizedBox(height: 20),
            InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchBook(),));
            },
            child: CustomButton(text: TextConstants.continu, color: Colorconstants.primaryblue))
          ],
        ),
      ),
    ),
Positioned(
      top: 0,
      right: 5,
      child: IconButton(
        icon: const Icon(Icons.logout, color: Colors.red, size: 28),
        onPressed: () => _logout(context),
        tooltip: 'Logout',
      ),
    ),
  ],
),
);
  }
 }
