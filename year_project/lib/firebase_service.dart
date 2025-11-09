import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

class FirebaseService {
  static bool _initialized = false;

  static Future<void> initialize() async {
    if (_initialized) return;
    
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      _initialized = true;
      print('✅ Firebase initialized successfully');
    } catch (e) {
      print('❌ Firebase initialization failed: $e');
      rethrow;
    }
  }

  // Authentication Methods
  static Future<User?> signUp(String email, String password) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Sign up error: $e');
      throw e;
    }
  }

  static Future<User?> signIn(String email, String password) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Sign in error: $e');
      throw e;
    }
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static User? get currentUser => FirebaseAuth.instance.currentUser;

  // Firestore Methods
  static Future<DocumentSnapshot> readData(String collection, String documentId) async {
    return await FirebaseFirestore.instance.collection(collection).doc(documentId).get();
  }

  static Future<void> createData(String collection, String documentId, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance.collection(collection).doc(documentId).set(data);
  }

  static Future<void> updateData(String collection, String documentId, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance.collection(collection).doc(documentId).update(data);
  }

  static Future<void> deleteData(String collection, String documentId) async {
    await FirebaseFirestore.instance.collection(collection).doc(documentId).delete();
  }

  static Future<List<QueryDocumentSnapshot>> getAll(String collection) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection(collection).get();
    return snapshot.docs;
  }

  static Stream<QuerySnapshot> getStream(String collection) {
    return FirebaseFirestore.instance.collection(collection).snapshots();
  }
}