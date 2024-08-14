// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';

// class CameraScreen extends StatefulWidget {
//   const CameraScreen({super.key});

//   @override
//   _CameraScreenState createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   CameraController? _controller;
//   Future<void>? _initializeControllerFuture;

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     // Obtain a list of the available cameras on the device.
//     final cameras = await availableCameras();
//     final firstCamera = cameras.first;

//     _controller = CameraController(
//       firstCamera,
//       ResolutionPreset.high,
//     );

//     _initializeControllerFuture = _controller?.initialize();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return CameraPreview(_controller!);
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             return const Center(child:  CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }
// }
import 'package:memecity/navigation_bar_screens/calling_screen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  int _currentCameraIndex = 0;
  FlashMode _flashMode = FlashMode.off;
  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(
      cameras[_currentCameraIndex],
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller?.initialize();
    setState(() {});
  }

  Future<void> _switchCamera() async {
    final cameras = await availableCameras();
    _currentCameraIndex = (_currentCameraIndex + 1) % cameras.length;
    _controller = CameraController(
      cameras[_currentCameraIndex],
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller?.initialize();
    setState(() {});
  }

  void _toggleFlash() async {
    if (_controller != null) {
      FlashMode newFlashMode;
      switch (_flashMode) {
        case FlashMode.off:
          newFlashMode = FlashMode.torch;
          break;
        case FlashMode.torch:
          newFlashMode = FlashMode.auto;
          break;
        case FlashMode.auto:
          newFlashMode = FlashMode.always;
          break;
        case FlashMode.always:
          newFlashMode = FlashMode.off;
          break;
      }

      await _controller!.setFlashMode(newFlashMode);
      setState(() {
        _flashMode = newFlashMode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 50,
        toolbarHeight: 50,
        elevation: 0.0,
        backgroundColor: Colors.blueGrey,
        title: const Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '           Calling...',
                style: TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(25.0),
              child: Text(
                'End to End Encrypted🔒',
                style: TextStyle(fontSize: 10),
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
            onPressed: () {},
            icon: const Icon(
              Icons.add_ic_call_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_controller!);
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/image7.jpg',
                    ),
                    backgroundColor: Colors.blue,
                    radius: 50,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          //    Positioned(
          //       bottom: 80,
          //       left: 0,
          //       right: 0,
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           FloatingActionButton(
          //             onPressed: _switchCamera,
          //             child: const Icon(Icons.switch_camera),
          //           ),
          //           FloatingActionButton(
          //             onPressed: () {
          //               // Hangup action here
          //             },
          //             child: const Icon(Icons.call_end),
          //           ),
          //         ],
          //       ),
          //     ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BottomAppBar(
              color: const Color.fromARGB(255, 98, 116, 124),
              elevation: 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      iconSize: 35,
                      isSelected: true,
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.videocam_off_outlined,
                        color: Colors.white,
                      )),
                  IconButton(
                    iconSize: 35,
                    onPressed: _switchCamera,
                    icon: const Icon(
                      Icons.flip_camera_ios_outlined,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    iconSize: 35,
                    onPressed: _toggleFlash,
                    icon: Icon(
                      _flashMode == FlashMode.off
                          ? Icons.flash_off
                          : Icons.flash_on,
                      color: Colors.white,
                    ),
                  ),
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
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.red,
                      elevation: 0.1,
                    ),
                    onPressed: () {
                      Get.to(() => const CallingScreen());
                    },
                    icon: const Icon(
                      Icons.call_end_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 98, 116, 124),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
