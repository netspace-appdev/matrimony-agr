import 'package:agraseva/modules/login/presentation/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// import your model
import 'data/model/drawerModel.dart';

// ❗ These imports were causing errors because files don't exist
// Uncomment when you create these screens

/*
import '../home/home_screen.dart';
import '../success_story/success_story_list_screen.dart';
import '../gallery/gallery_screen.dart';
import '../payment/payment_screen.dart';
import '../social/social_member_signup_screen.dart';
import '../social/social_member_list_screen.dart';
import '../about/about_agrasewa_screen.dart';
import '../news/news_event_screen.dart';
import '../news/news_event_controller.dart';
import '../account/delete_account_screen.dart';
import '../report/report_user_screen.dart';
import '../contact/contactus_screen.dart';
*/

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  /// Drawer menu list
  List<DrawerModel> drawerItemList = [

    DrawerModel(
        title: 'Home',
        position: '0',
        icon: "assets/images/home_two.png",
        selected: false),

    DrawerModel(
        title: 'Search',
        position: '1',
        icon: "assets/images/search.png",
        selected: false),

    DrawerModel(
        title: 'My Shortlist',
        position: '2',
        icon: "assets/images/my_shortlist.png",
        selected: false),

    DrawerModel(
        title: 'Who visit',
        position: '3',
        icon: "assets/images/who_visit_two.png",
        selected: false),

    DrawerModel(
        title: 'Success Story',
        position: '4',
        icon: "assets/images/success_story.png",
        selected: false),

    DrawerModel(
        title: 'Gallery',
        position: '5',
        icon: "assets/images/gallery.png",
        selected: false),

    DrawerModel(
        title: 'Payment',
        position: '6',
        icon: "assets/images/payment.png",
        selected: false),

    DrawerModel(
        title: 'Social Members',
        position: '7',
        icon: "assets/images/payment.png",
        selected: false),

    DrawerModel(
        title: 'Add Social Member',
        position: '8',
        icon: "assets/images/success_story.png",
        selected: false),

    DrawerModel(
        title: 'About Agraseva',
        position: '9',
        icon: "assets/images/home_two.png",
        selected: false),

    DrawerModel(
        title: 'News & Events',
        position: '10',
        icon: "assets/images/event.png",
        selected: false),
  ];

  /// UI selection flags
  bool isFaq = false;
  bool isContactUs = false;
  bool isPrivacy = false;
  bool isAcDelete = false;
  bool isReportUser = false;

  /// selected item tracking
  Map<int, bool> itemsSelectedValue = {};

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [

          /// Close icon
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.only(
                  left: 20, top: 10, right: 10),
              child: const Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.cancel,
                    color: Colors.black26,
                    size: 25),
              ),
            ),
          ),

          /// Header UI
 /*         Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/images/ractangle_bg_red.png"),
              ),
            ),
            child: const SizedBox(height: 100),
          ),*/

          /// Drawer menu list
          ListView.builder(
            itemCount: drawerItemList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {

              /// normal menu container
              Widget container = Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 20),
                child: Row(
                  children: [

                    Image.asset(
                      drawerItemList[index].icon!,
                      color: Colors.red,
                      height: 20,
                    ),

                    const SizedBox(width: 15),

                    Text(
                      drawerItemList[index].title!,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black),
                    ),
                  ],
                ),
              );

              return GestureDetector(
                onTap: () {

                  /// selection logic
                  setState(() {
                    for (var i = 0;
                    i < drawerItemList.length;
                    i++) {
                      drawerItemList[i].selected =
                          i == index;
                    }
                  });

                  /// Navigation logic

                  if (index == 0) {

                    /// HOME SCREEN
                    /// Navigator.push(context,
                    /// MaterialPageRoute(
                    /// builder: (_) =>
                    /// HomeScreen(FROM:"HOME")));

                  }

                  else if (index == 1) {

                    /// SEARCH SCREEN
                    // Navigator.push(context,
                    // MaterialPageRoute(
                    // builder: (_) =>
                    // HomeScreen(FROM:"SEARCH")));

                  }

                  else if (index == 4) {

                    /// SUCCESS STORY
                    // Get.to(() =>
                    // SuccessStoryListScreen());

                  }

                  else if (index == 5) {

                    /// GALLERY
                    // Get.to(() =>
                    // GalleryScreen());

                  }

                  else if (index == 6) {

                    /// PAYMENT
                    // Get.to(() =>
                    // PaymentScreen());

                  }

                  else if (index == 7) {

                    /// SOCIAL MEMBER LIST
                    // Get.to(() =>
                    // GetsocialMemeberListScreen());

                  }

                  else if (index == 8) {

                    /// SOCIAL MEMBER SIGNUP
                    // Get.to(() =>
                    // SocialMemberSignupScreen());

                  }

                  else if (index == 9) {

                    /// ABOUT AGRASewa
                    // Get.to(() =>
                    // AboutAgraSewaScreen());

                  }

                  else if (index == 10) {

                    /// NEWS EVENT
                    // NewsEventController controller
                    // = Get.put(NewsEventController());
                    //
                    // controller.getNewsAndEventResponse();
                    //
                    // Get.to(() =>
                    // NewAndEventScreen());

                  }

                },
                child: container,
              );
            },
          ),

          const Divider(),

          /// Account section title
          const ListTile(
            title: Text(
              "Account",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
          ),

          /// Account Delete
          GestureDetector(
            onTap: () {

              setState(() {
                isAcDelete = true;
              });

              // Navigator.push(context,
              // MaterialPageRoute(
              // builder: (_) =>
              // DeleteAccountScreen()));

            },
            child: ListTile(
              leading: const Icon(
                  Icons.delete,
                  color: Colors.red),
              title: const Text(
                  "Account Deletion"),
            ),
          ),

          /// Report user
          GestureDetector(
            onTap: () {

              setState(() {
                isReportUser = true;
              });

              // Navigator.push(context,
              // MaterialPageRoute(
              // builder: (_) =>
              // ReportUserScreen()));

            },
            child: const ListTile(
              leading: Icon(
                  Icons.report,
                  color: Colors.red),
              title: Text("Report A User"),
            ),
          ),

          /// Contact us
          GestureDetector(
            onTap: () {

              setState(() {
                isContactUs = true;
              });

              // Navigator.push(context,
              // MaterialPageRoute(
              // builder: (_) =>
              // ContactusScreen()));

            },
            child: const ListTile(
              leading: Icon(
                  Icons.support_agent,
                  color: Colors.red),
              title: Text("Contact Us"),
            ),
          ),

          /// Logout
          ListTile(
            leading: const Icon(
                Icons.logout,
                color: Colors.red),
            title: const Text("Logout"),
            onTap: () {

              /// logout logic
              /// clear storage
              /// navigate login


              GetStorage().erase();

              Get.offAll(() =>
              AuthScreen());


            },
          ),

          /// footer image
          Image.asset(
              "assets/images/drawer_footer.png"),
        ],
      ),
    );
  }
}