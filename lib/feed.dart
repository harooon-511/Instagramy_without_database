import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagramy/provider.dart';


class Feedpage extends ConsumerWidget{
  const Feedpage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context, WidgetRef ref){
    final insta = ref.watch(instaProvider);
    int bottomIndex = 0;
    
    return Scaffold(
      appBar:AppBar(title: Image.asset('images/logo.gif', 
      height: 120,
        fit: BoxFit.contain),
        backgroundColor: Colors.pink[100],
            ),
            body: ListView.builder(
              itemCount: insta.posts.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: SizedBox(
                    height: 400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: Image.asset('images/icons/face2.png',
                            height: 75,
                            width: 75,
                            fit: BoxFit.fitHeight,),
                          title: Text(insta.posts[index].username,
                          style: const TextStyle(fontSize: 16, color: Colors.black),),
                          subtitle: Text(insta.posts[index].place,
                          style: const TextStyle(fontSize: 16, color: Colors.grey),),
                          // trailing: Icon(Icons.more_vert),
                        ),
                        SizedBox(
                          height: 240,
                          child: Container(
                            constraints: BoxConstraints.expand(),
                            child: Card(
                              child: Image.asset(insta.posts[index].pic, fit: BoxFit.cover),                           
                            ),
                          ),
                        ),
                        // 横にスクロールできる複数写真投稿機能をつける場合
                        // SizedBox(
                        //   height: 240,
                        //   child: PageView.builder(
                        //     controller: PageController(viewportFraction: 0.8),
                        //     itemBuilder: (context, index) {
                        //       return Padding(
                        //     padding: const EdgeInsets.symmetric(horizontal: 8),
                        //     child: Card(
                        //     child: Image.asset(insta.posts[index].pic,fit: BoxFit.cover),
                        //   ),
                        // );
                        //     }
                        //   ),
                        // ),
                        Center(child: 
                        Text(
                          insta.posts[index].content,
                          style: const TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              //  backgroundColor: Colors.pink,
                // 表示する要素を配列で渡す
                items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: '',
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.sunny),
                        label: '',
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.slideshow),
                        label: '',
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.local_mall),
                        label: '',
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.sentiment_satisfied_alt,),
                        label: '',
                    ),
                ],
                // タップされた時の処理
                currentIndex: insta.bottomIndex,               
                onTap: (index){
                  bottomIndex = index;
                  if(bottomIndex == 1){
                    Navigator.of(context).pushNamed('weather');
                  }
                },
               
                
        ),
    floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed('add',
            arguments: insta.addPostItem);
          },
          backgroundColor: Colors.pink[100],
        ),
    );
   
  }
}

// Widget _buildVerticalItem(BuildContext context, WidgetRef ref, int Index) {
//   final insta = ref.watch(instaProvider);
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       child: SizedBox(
//         height: 320,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               insta.posts[Index].username,
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             _buildHorizontalItem(context, Index),
//             Text(
//               insta.posts[Index].content,
//               style: const TextStyle(fontSize: 16, color: Colors.grey),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//  Widget _buildHorizontalItem(BuildContext context, int Index) {
  
//    final imageUrl ='images/tokyo.jpeg';
//     return SizedBox(
//       height: 240,
//       child: PageView.builder(
//         controller: PageController(viewportFraction: 0.8),
//         itemBuilder: (context, index) {
//           return Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8),
//         child: Card(
//         child: Image.asset(imageUrl,fit: BoxFit.cover),
//       ),
//     );
//         }
//       ),
//     );
//   }

  