import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String? photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;

  const User({
    required this.email,
    required this.uid,
    this.photoUrl,
    required this.username,
    required this.bio,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'uid': uid,
    'photoUrl': photoUrl,
    'username': username,
    'bio': bio,
    'followers': followers,
    'following': following,
  };

  static User fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;

    return User(
      email: snap['email'],
      uid: snap['uid'],
      photoUrl: snap['photoUrl'],
      username: snap['username'],
      bio: snap['bio'],
      followers: snap['followers'],
      following: snap['following'],
    );
  }
}
