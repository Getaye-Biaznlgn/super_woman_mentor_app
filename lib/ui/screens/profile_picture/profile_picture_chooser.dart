import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../providers/auth.dart';
import '../../../utils/constants.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

class ProfilePictureChooser extends StatefulWidget {
  static const String routeName = 'profile-picture-chooser';
  const ProfilePictureChooser({Key? key}) : super(key: key);

  @override
  State<ProfilePictureChooser> createState() => _ProfilePictureChooserState();
}

class _ProfilePictureChooserState extends State<ProfilePictureChooser> {
  File? image;
  bool isLoading = false;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  uploadImage(File imageFile, context) async {
    try {
      setState(() {
        isLoading = true;
      });
      Auth auth = Provider.of<Auth>(context, listen: false);

      var stream =
          http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
      var length = await imageFile.length();

      var uri =
          Uri.parse('http://192.168.0.8:8000/user/change_profile_picture');
      Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $auth.token'
      };

      var request = http.MultipartRequest(
        "POST",
        uri,
      );
      request.headers.addAll(headers);
      var multipartFile = http.MultipartFile('profile', stream, length,
          filename: basename(imageFile.path));
      //contentType: new MediaType('image', 'png'));

      request.files.add(multipartFile);
      var response = await request.send();
      print('😊 status code');
      print(response.statusCode);
      response.stream.transform(utf8.decoder).listen((value) {
        print('🤣 value');
        print(value);
      });
      if (response.statusCode == 200) {
        // auth.profilePicture = jsonDecode(response)['profile_picture'];
      }
      
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            image == null
                ? Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    height: size.height * 0.3,
                    width: size.width * 0.6,
                    // color: Colors.grey[200],
                    child: const Center(child: Text('Image is not selected')),
                  )
                : Image.file(
                    image!,
                    height: size.height * 0.3,
                    width: size.width * 0.6,
                    fit: BoxFit.fill,
                  ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kSecondaryColor,
                    ),
                    onPressed: () {
                      pickImage();
                    },
                    child: const Text('Choose Image',
                        style: TextStyle(color: Colors.white, fontSize: 12))),
                const SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,
                    ),
                    onPressed: image == null
                        ? null
                        : () {
                            print('upload img');
                            uploadImage(image!, context);
                          },
                    child: Row(
                      children: [
                        const Text('Upload Image',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                        if (isLoading)
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator()),
                          )
                      ],
                    )),
              ],
            )
          ],
        ));
  }
}
