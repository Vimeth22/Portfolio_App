import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String? _userId = FirebaseAuth.instance.currentUser?.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _username = '';
  String _email = '';
  String? _profileImage;
  String? _bio = '';
  List<String>? _featuredImages;
  List<dynamic>? _posts;

  void _fetchUserData() async {
    final userSnapshot = await _firestore.collection('users').doc(_userId).get();
    final data = userSnapshot.data();
    if (data != null) {
      setState(() {
        _username = data['username'];
        _email = data['email'];
        _profileImage = data['profileImage'];
        _bio = data['bio'];

        if (data['featuredImages'] != null) {
          _featuredImages = List<String>.from(data['featuredImages']);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_profileImage == null) ...[
              Container(
                height: MediaQuery.of(context).size.height * .20,
                color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
              ),
            ] else ...[
              Container(
                height: MediaQuery.of(context).size.height * .35,
                child: Image.network(
                  _profileImage!,
                  fit: BoxFit.cover,
                ),
              )
            ],
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
              child: Text(_username, style: TextStyle(fontFamily: 'DM Serif Display', fontSize: 30, height: 1)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                _email,
                style: TextStyle(fontFamily: "Titillium Web"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 10),
              child: Text(
                _bio ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontFamily: "Titillium Web"),
              ),
            ),
            if (_featuredImages != null) ...[
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.3,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        var featuredImage;

                        if (index < _featuredImages!.length) {
                          featuredImage = _featuredImages?[index];
                        }

                        if (featuredImage == null) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: ClipRRect(
                              clipBehavior: Clip.antiAlias,
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                width: MediaQuery.of(context).size.width * .3,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: ClipRRect(
                            clipBehavior: Clip.antiAlias,
                            borderRadius: BorderRadius.circular(5),
                            child: Container(
                              width: MediaQuery.of(context).size.width * .3,
                              child: Image.network(
                                featuredImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
              if (_featuredImages != null && _featuredImages?.length == 4) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                  child: ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      height: MediaQuery.sizeOf(context).height * .4,
                      child: Image.network(
                        _featuredImages![3],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              ] else ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                  child: ClipRRect(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      height: MediaQuery.sizeOf(context).height * .4,
                      color: Colors.grey,
                    ),
                  ),
                )
              ]
            ],
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 5.0, bottom: 8),
              child: Text('Recent Posts', style: TextStyle(fontFamily: 'DM Serif Display', fontSize: 20, height: 1)),
            ),
            StreamBuilder(
              stream: _firestore.collection('posts').where('userId', isEqualTo: _userId).snapshots(),
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
