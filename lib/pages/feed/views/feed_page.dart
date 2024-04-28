import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:portfolio_app/pages/feed/views/new_post.dart';

class FeedPage extends StatefulWidget {
  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Portfolio.', style: TextStyle(fontFamily: 'DM Serif Display', fontSize: 30, height: 1)),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NewPostPage()));
                    },
                    child: Icon(
                      Icons.post_add,
                      color: Color.fromARGB(255, 232, 177, 68),
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 5.0, bottom: 8),
              child: Text('Your Feed', style: TextStyle(fontFamily: 'DM Serif Display', fontSize: 20, height: 1)),
            ),
            StreamBuilder(
              stream: _firestore.collection('posts').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: Colors.black));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      'No Posts :(',
                      style: TextStyle(fontFamily: "Titillium Web"),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var post = snapshot.data!.docs[index];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                          child: ClipRRect(
                            clipBehavior: Clip.antiAlias,
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              height: MediaQuery.sizeOf(context).height * .4,
                              child: Image.network(
                                post['image'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0, top: 5.0, bottom: 8),
                          child: Text(post['author'], style: TextStyle(fontFamily: 'DM Serif Display', fontSize: 20, height: 1)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0, bottom: 8),
                          child: Text(
                            post['description'],
                            style: TextStyle(fontFamily: "Titillium Web"),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
