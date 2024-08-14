import 'package:memecity/navigation_bar_screens/calls_screen.dart';
import 'package:memecity/navigation_bar_screens/vc_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallingScreen extends StatelessWidget {
  const CallingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 50,
          toolbarHeight: 50,
          elevation: 0.01,
          backgroundColor: Colors.blueGrey,
          title: const Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  '           Calling...',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(35.0),
                child: Text(
                  'End to End Encrypted🔒',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              )
            ],
          ),
          centerTitle: true,
          leading: IconButton(
            iconSize: 35,
            style: IconButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 98, 116, 124),
            ),
            icon: const Icon(
              Icons.close_fullscreen_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            IconButton(
              iconSize: 35,
              style: IconButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 98, 116, 124),
              ),
              onPressed: () {
                Get.to(() => const CallScreen());
              },
              icon: const Icon(
                Icons.add_ic_call_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
        // ElevatedButton(
        //   //   color: Colors.white,
        //   onPressed: () {
        //     Get.back();
        //   },
        //   child: const Icon(
        //     Icons.close_fullscreen_rounded,
        //     size: 30,
        //     color: Colors.white,
        //   ),
        // ),
        // ElevatedButton(
        //   onPressed: () {},
        //   child: const Icon(
        //     Icons.add_ic_call_outlined,
        //   ),
        // ),

        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/image7.jpg',
                      ),
                      backgroundColor: Colors.blue,
                      radius: 100,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        backgroundColor: Colors.blueGrey,
        bottomNavigationBar: BottomAppBar(
          color: const Color.fromARGB(255, 98, 116, 124),
          elevation: 0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  iconSize: 35,
                  onPressed: () {
                    Get.to(() => const CameraScreen());
                  },
                  icon: const Icon(
                    Icons.videocam_outlined,
                    color: Colors.white,
                  )),
              IconButton(
                iconSize: 35,
                onPressed: () {},
                icon: const Icon(
                  Icons.mic_off_outlined,
                  color: Colors.white,
                ),
              ),
              IconButton(
                  iconSize: 35,
                  isSelected: true,
                  onPressed: () {},
                  icon: const Icon(
                    Icons.volume_up_outlined,
                    color: Colors.white,
                  )),
              IconButton(
                iconSize: 35,
                style: IconButton.styleFrom(
                  backgroundColor: Colors.red,
                  elevation: 0.1,
                ),
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.call_end_outlined,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        // bottomSheet: BottomSheet(onClosing: () {
        //   print('Bottom Sheet closed');
        // }, builder: (BuildContext context) {
        //   return Container(height: 20);
        // }),
        // floatingActionButton: Stack(
        //   children: [
        //     Align(
        //       alignment: Alignment.topLeft,
        //       child: FloatingActionButton(
        //         onPressed: () {
        //           Get.back();
        //         },
        //         backgroundColor: Colors.red,
        //         child: const Icon(
        //           Icons.call_end,
        //           color: Colors.white,
        //         ),
        //       ),
        //     ),
        //     Align(
        //       alignment: Alignment.topRight,
        //       child: FloatingActionButton(
        //         onPressed: () {},
        //         backgroundColor: Colors.blue,
        //         child: const Icon(
        //           Icons.add_call,
        //           color: Colors.white,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
