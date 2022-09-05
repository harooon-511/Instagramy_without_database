import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagramy/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


class addPostPage extends ConsumerStatefulWidget {
 const addPostPage({Key? key}): super(key: key);

 @override
 ConsumerState<addPostPage> createState() => _addPostPageState();
}

class _addPostPageState extends ConsumerState<addPostPage> {
  final formKey = GlobalKey<FormState>();
  Map<String, String> formValue = {};// フォームの値を入れる変数
  final ImagePicker _picker = ImagePicker();
  File? _file;

     @override
     Widget build(BuildContext context) {
         return Scaffold(
             appBar: AppBar(
                centerTitle: true,
                title: const Text('New post'),
                backgroundColor: Colors.pink[100],
             ),
             // Form ウィジェット
             body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(_file != null) 
                    SizedBox(
                      height: 200,
                      child: Image.file(_file!, fit: BoxFit.cover,),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        // 入力欄用のウィジェット
                        child: OutlinedButton(
                            onPressed: () async {
                              final XFile? _image = await _picker.pickImage(source: ImageSource.gallery);
                              _file = File(_image!.path);
                              formValue['pic'] = _image.path.toString();                      
                              setState(() {});
                            },
                            child: const Text('画像を選択')
                        ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        // 入力欄用のウィジェット
                        child: TextFormField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'location',
                            ),
                            onSaved: (value){
                              formValue['place'] = value.toString();
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Can\'t be empty';
                              }
                            } 
                        ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        // 入力欄用のウィジェット
                        child: TextFormField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'caption',
                            ),
                            onSaved: (value){
                              formValue['content'] = value.toString();
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Can\'t be empty';
                              }
                            } 
                        ),
                    ),
                  ],
                ),
             ),
             ),
             floatingActionButton: FloatingActionButton(
                 child: const Icon(Icons.send),
                 onPressed: () {
                   if (formKey.currentState?.validate()==true) {
                    formKey.currentState?.save();
                    ref.read(instaProvider).addPostItem(formValue);
                    Navigator.of(context).pop();
                    }else{
                      print('Form is invalid!');
                    }   
                 },
                 backgroundColor: Colors.pink[100],
             ),
         );
     }
 }

 