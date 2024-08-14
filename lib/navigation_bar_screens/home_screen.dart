import 'dart:io';
import 'package:memecity/databases/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:audiofileplayer/audiofileplayer.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:like_button/like_button.dart';

final box = GetStorage();
void savetheme(bool isDarkMode) {
  box.write('isDarkMode', isDarkMode);
}

bool loadTheme() {
  return box.read('isDarkMode') ?? false;
}

bool isDarkMode = loadTheme();

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Post> posts = [];
  List<Post> archivedPosts = [];
  final TextEditingController _textController = TextEditingController();
  bool isFabOpen = false;
  File? image;

  void _addTextPost(String text) {
    setState(() {
      posts.add(Post(text: text));
      _textController.clear();
    });
  }

  void _addImagePost(String? imagePath) {
    setState(() {
      posts.add(Post(imagePath: imagePath));
    });
  }

  void _addVideoPost(String? videoPath) {
    setState(() {
      posts.add(Post(videoPath: videoPath));
    });
  }

  void _toggleFab() {
    setState(() {
      isFabOpen = !isFabOpen;
    });
  }

  void _likePost(Post post) {
    setState(() {
      post.isLiked = !post.isLiked;
      post.likeCount += post.isLiked ? 1 : -1;
    });

    // Play like sound
    Audio.load('assets/like_sound.mp3')
      ..play()
      ..dispose();
  }

  void _commentOnPost(Post post, String comment) {
    setState(() {
      post.comments.add(comment);
    });
  }

  void _deletePost(Post post) {
    setState(() {
      posts.remove(post);
    });
  }

  void _archivePost(Post post) {
    setState(() {
      posts.remove(post);
      archivedPosts.add(post);
    });
  }

  // posts_screen.dart

  // void _savePost(BuildContext context, String text, Uint8List? imageBytes,
  //     String? videoPath, Uint8List? voiceBytes) async {
  //   await Provider.of<PostProvider>(context, listen: false).addPost(
  //     text,
  //     imageBytes,
  //     videoPath,
  //     voiceBytes,
  //   );
  //   Get.snackbar('Action Successful', 'Post Saved');
  // }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _addImagePost(pickedFile.path);
    }
  }

  Future<void> _pickVideo() async {
    final pickedFile =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      _addVideoPost(pickedFile.path);
    }
  }

  Future<void> _pickCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _addImagePost(pickedFile.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profilePicture =
        Provider.of<ProfilePictureProvider>(context).profilePicture;
    //  final postProvider = Provider.of<PostProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: 'What\'s on your mind?',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor:
                      isDarkMode ? Colors.white : Colors.blueGrey.shade100,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: _textController.text.isEmpty
                          ? IconButton(
                              onPressed: () {
                                Get.snackbar('Nothing to post', 'Add Text');
                              },
                              icon: const Icon(Icons.send_outlined))
                          : IconButton(
                              onPressed: () async {
                                // String text =
                                //     'Post text'; // Replace with actual text data
                                // Uint8List?
                                //     imageBytes; // Replace with actual image data
                                // String?
                                //     videoPath; // Replace with actual video path
                                // Uint8List?
                                //     voiceBytes; // Replace with actual voice data

                                // _savePost(context, text, imageBytes, videoPath,
                                //     voiceBytes);
                                _addTextPost(_textController.text);
                                print(
                                    "Send Button pressed with text: ${_textController.text}");
                              },
                              icon: const Icon(
                                Icons.send,
                                color: Colors.teal,
                              ))),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: profilePicture != null
                        ? CircleAvatar(
                            radius: 18,
                            backgroundImage: MemoryImage(profilePicture))
                        : const Text('No image'),
                  ),
                ),
                onChanged: (text) => {setState(() {})},
                onTapOutside: (event) {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                cursorHeight: BorderSide.strokeAlignCenter,
              ),
            ),
            // ElevatedButton(
            //   onPressed: () => _addTextPost(_textController.text),
            //   child: const Text('Post'),
            // ),
            ...posts.map(
              (post) => PostWidget(
                post: post,
                onLike: () => _likePost(post),
                onComment: (comment) => _commentOnPost(post, comment),
                onDelete: () => _deletePost(post),
                onArchive: () => _archivePost(post),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: _toggleFab,
                backgroundColor: isDarkMode ? Colors.black : Colors.teal,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
            if (isFabOpen) ...[
              Padding(
                padding: const EdgeInsets.only(bottom: 80.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: _pickImage,
                    backgroundColor: isDarkMode ? Colors.black : Colors.teal,
                    child: const Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 140.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: _pickVideo,
                    backgroundColor: isDarkMode ? Colors.black : Colors.teal,
                    child: const Icon(Icons.video_library, color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 200.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: _pickCamera,
                    backgroundColor: isDarkMode ? Colors.black : Colors.teal,
                    child: const Icon(
                      Icons.camera,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ]
          ],
        ),
      ),
      backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.white,
    );
  }
}

class Post {
  final String? text;
  final String? imagePath;
  final String? videoPath;
  bool isLiked;
  int likeCount;
  List<String> comments;

  Post({this.text, this.imagePath, this.videoPath})
      : isLiked = false,
        likeCount = 0,
        comments = [];
}

class PostWidget extends StatelessWidget {
  final Post post;
  final VoidCallback onLike;
  final ValueChanged<String> onComment;
  final VoidCallback onDelete;
  final VoidCallback onArchive;
  final TextEditingController _commentController = TextEditingController();
  final List<String> _comments = [];
  void _addComment() {
    final String comment = _commentController.text;
    if (comment.isEmpty) {
      _comments.add(comment);
    }
  }

  PostWidget({
    super.key,
    required this.post,
    required this.onLike,
    required this.onComment,
    required this.onDelete,
    required this.onArchive,
  });

  @override
  Widget build(BuildContext context) {
    // final postProvider = Provider.of<PostProvider>(context);
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (post.text != null) Text(post.text!),
            if (post.imagePath != null)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          FullScreenImage(imagePath: post.imagePath!),
                    ),
                  );
                },
                child: Image.file(
                  File(post.imagePath!),
                  height: Get.height * 0.4,
                  width: Get.width * 1,
                  fit: BoxFit.cover,
                ),
              ),
            if (post.videoPath != null)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          FullScreenVideo(videoPath: post.videoPath!),
                    ),
                  );
                },
                child: Container(
                  height: Get.height * 0.4,
                  width: Get.width * 01,
                  color: Colors.black54,
                  child: const Center(child: Text('Video Placeholder')),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LikeButton(
                  isLiked: post.isLiked,
                  likeCount: post.likeCount,
                  likeBuilder: (bool isLiked) {
                    return Icon(
                      Icons.favorite,
                      color: isLiked ? Colors.red : Colors.grey,
                      size: 30.0,
                    );
                  },
                  onTap: (bool isLiked) async {
                    onLike();
                    return !isLiked;
                  },
                  bubblesColor: const BubblesColor(
                    dotPrimaryColor: Colors.red,
                    dotSecondaryColor: Colors.redAccent,
                  ),
                  likeCountAnimationType: LikeCountAnimationType.part,
                  likeCountPadding: const EdgeInsets.only(left: 15.0),
                  countBuilder: (int? count, bool isLiked, String text) {
                    var color = isLiked ? Colors.red : Colors.grey;
                    Widget result;
                    if (count == 0) {
                      result = Text(
                        "love",
                        style: TextStyle(color: color),
                      );
                    } else {
                      result = Text(
                        text,
                        style: TextStyle(color: color),
                      );
                    }
                    return result;
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.chat_bubble_outline_rounded),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () => _showPostOptions(context),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () => _showPostOptions(context),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child:
                  // TextField(
                  //   controller: _textController,
                  //   decoration: InputDecoration(
                  //     hintText: 'What\'s on your mind?',
                  //     border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(30.0),
                  //         borderSide: BorderSide.none),
                  //     filled: true,
                  //     fillColor: Colors.white,
                  //     contentPadding: const EdgeInsets.symmetric(
                  //       vertical: 10,
                  //       horizontal: 20,
                  //     ),
                  //     suffixIcon: Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  //         child: _textController.text.isEmpty
                  //             ? IconButton(
                  //                 onPressed: () {},
                  //                 icon: const Icon(Icons.send_outlined))
                  //             : IconButton(
                  //                 onPressed: () {

                  //                 },
                  //                 icon: const Icon(
                  //                   Icons.send,
                  //                   color: Colors.teal,
                  //                 ))),
                  //
                  SizedBox(
                child: Column(
                  children: [
                    TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        labelText: 'Comment',
                        hintText: 'Add a comment...',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: IconButton(
                            onPressed: () async {
                              //  onComment(_addComment as String);
                              _addComment();
                              _commentController.clear();
                              print(
                                  "Send Button pressed with text: ${_commentController.text}");
                            },
                            icon: const Icon(
                              Icons.send,
                              color: Colors.teal,
                            ),
                          ),
                        ),
                      ),
                      onSubmitted: (comment) {
                        onComment(comment);
                        _commentController.clear();
                      },
                    ),
                  ],
                ),
              ),
            ),
            ...post.comments.map((comment) => Text(comment)),
          ],
        ),
      ),
    );
  }

  void _showPostOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete Post'),
                onTap: () {
                  onDelete();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.archive),
                title: const Text('Archive Post'),
                onTap: () {
                  onArchive();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imagePath;

  const FullScreenImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.white : Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Image.file(
          File(
            imagePath,
          ),
        ),
      ),
    );
  }
}

class FullScreenVideo extends StatefulWidget {
  final String videoPath;

  const FullScreenVideo({super.key, required this.videoPath});

  @override
  State<FullScreenVideo> createState() => _FullScreenVideoState();
}

class _FullScreenVideoState extends State<FullScreenVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
