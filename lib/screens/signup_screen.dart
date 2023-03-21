import 'package:flutter/material.dart';
import 'package:flutter_login_ui/utilities/constants.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:io';



class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
  

}

class _SignupScreenState extends State<SignupScreen> {

final GlobalKey<FormState> formkey = GlobalKey<FormState>();

PickedFile _imageFile;
final ImagePicker _picker = ImagePicker();
bool circular = false;


Widget _imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.black,
            radius: 85,
        child: CircleAvatar(
          radius: 80.0,
          backgroundImage: _imageFile == null
              ? AssetImage("assets/logos/facebook.jpg")
              : FileImage(File(_imageFile.path)),
        ),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => _bottomSheet()),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25.0),
                  ),
                ),
                backgroundColor: Colors.black
              );
            },
            child: Icon(
              Icons.add_a_photo,
              color: Colors.blueAccent,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }



  Widget _bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width, 
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              color:Colors.amber, 
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.camera,color: Colors.green,),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            TextButton.icon(
              icon: Icon(Icons.image,color: Colors.pink,),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }


  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }




void validate(){
  if(formkey.currentState.validate()){
    print("Validated");
  }else{
    print("Not Validated");
  }
}

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }


Widget _buildFullNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Full Name',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle2,
          height: 60.0,
          child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                hintText: 'Enter your Full Name',
              ),
              validator: (textValue) {
                if (textValue == null || textValue.isEmpty) {
                  return 'Name field is required!';
                }
                return null;
              }),
        ),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Email',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle2,
            height: 60.0,
            child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  hintText: 'Enter your Email',
                ),
                validator: (textValue) {
                  if (textValue == null || textValue.isEmpty) {
                    return 'Email is required!';
                  }
                  if (!EmailValidator.validate(textValue)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                }),
          ),
        ]);
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle2,
          height: 60.0,
          child: TextFormField(
            obscureText: true,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black,
              ),
              hintText: 'Enter your Password',
            ),
            validator: (textValue) {
              RegExp regex = RegExp(
                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
              if (textValue == null || textValue.isEmpty) {
                return 'Password is required!';
              } else {
                if(textValue.length<8){
                  return ("Password Must be more than 7 characters");
                }else{

                } if(!regex.hasMatch(textValue)){
                  return ("The password must contain uppercase letters, lowercase letters, numbers and special characters.");
                }
                return null;
              }
            },
          ),
        ),
      ],
    );
  }


Widget _buildCreateBtn() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: 140,
        height: 100,
        child: ElevatedButton(
          child: Text("Register".toUpperCase(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.blueAccent),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              shape: MaterialStateProperty.all<StadiumBorder>(
                  StadiumBorder(
                      side: BorderSide(color: Colors.blueAccent,width:2)))),
          onPressed: validate,
        ));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Form(
            key: formkey,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFEFDCDEB),
                      Color(0xFEE9FBAB),
                      Color(0xFECDE3FD),
                      Color(0xFEAEFBA5),

                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 120.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                       // SizedBox(height: 30.0),
                        _imageProfile(),
                        SizedBox(height: 30.0),
                        _buildFullNameTF(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildEmailTF(),
                        SizedBox(height: 30.0),
                        _buildPasswordTF(),
                        SizedBox(height: 30.0),
                        _buildCreateBtn(),
                        _backButton(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
