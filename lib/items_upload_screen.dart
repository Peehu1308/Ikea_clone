import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ItemsUploadScreen extends StatefulWidget {
  @override
  State<ItemsUploadScreen> createState() => _ItemsUploadScreenState();
}

class _ItemsUploadScreenState extends State<ItemsUploadScreen> {
  Uint8List? imageFileUint8List;
  TextEditingController sellerNameTextEditingController =
      TextEditingController();
  TextEditingController sellerPhoneTextEditingController =
      TextEditingController();
  TextEditingController itemNameTextEditingController = TextEditingController();
  TextEditingController itemPriceTextEditingController =
      TextEditingController();
  TextEditingController itemDescriptionTextEditingController =
      TextEditingController();

  bool isUploading = false;

  Widget uploadFormScreen() {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Upload New Item",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back,
              color: Colors.white), // Ensures back button is white
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.cloud_upload,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          if (isUploading)
            const LinearProgressIndicator(color: Colors.purpleAccent),

          // Image Upload Section
          SizedBox(
            height: 230,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: imageFileUint8List != null
                  ? Image.memory(imageFileUint8List!)
                  : const Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                      size: 40,
                    ),
            ),
          ),
          const Divider(color: Colors.white, thickness: 2),

          _buildTextField(Icons.person_pin_circle_rounded, "Seller Name",
              sellerNameTextEditingController),
          _buildTextField(Icons.phone_android_rounded, "Seller Phone",
              sellerPhoneTextEditingController),
          _buildTextField(
              Icons.title, "Item Name", itemNameTextEditingController),
          _buildTextField(Icons.description, "Item Description",
              itemDescriptionTextEditingController),
          _buildTextField(
              Icons.price_change, "Item Price", itemPriceTextEditingController),
        ],
      ),
    );
  }

  // Helper method to create text fields
  Widget _buildTextField(
      IconData icon, String hintText, TextEditingController controller) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.white),
          title: TextField(
            style: const TextStyle(color: Colors.grey),
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
          ),
        ),
        const Divider(color: Colors.white, thickness: 1),
      ],
    );
  }

  // default screen
  Widget defaultScreen() {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Upload New Item',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_a_photo_rounded,
                color: Colors.white,
                size: 200,
              ),
              ElevatedButton(
                  onPressed: () {
                    showDialogBox();
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: Text(
                    "Add New Iten",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ))
            ],
          ),
        ));
  }

  showDialogBox() {
    return showDialog(
      context: context,
      builder: (c) {
        return SimpleDialog(
          backgroundColor: Colors.black,
          title: const Text(
            "Item Image",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          children: [
            SimpleDialogOption(
              onPressed: () {
                caputureImageWithCamera();
              },
              child: const Text(
                "Capture Image with Camera",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                chooseImageFromGallery();
              },
              child: const Text(
                "Choose Image from Gallery",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.grey),
              ),
            )
          ],
        );
      },
    );
  }

  caputureImageWithCamera() async {
    Navigator.pop(context);
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);

      if (pickedImage != null) {
        String imagePath = pickedImage.path;
        imageFileUint8List = await pickedImage.readAsBytes();

        // /remove background
        // make the image transparent

        setState(() {
          imageFileUint8List;
        });
      }
    } catch (e) {
      print("Error: " + e.toString());
      setState(() {
        imageFileUint8List = null;
      });
    }
  }

  chooseImageFromGallery() async {
    Navigator.pop(context);
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        String imagePath = pickedImage.path;
        imageFileUint8List = await pickedImage.readAsBytes();

        // /remove background
        // make the image transparent

        setState(() {
          imageFileUint8List;
        });
      }
    } catch (e) {
      print("Error: " + e.toString());
      setState(() {
        imageFileUint8List = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return imageFileUint8List==null?defaultScreen():uploadFormScreen();
  }
}
