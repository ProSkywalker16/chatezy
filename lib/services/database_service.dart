import 'package:chatezy/models/user_profile.dart';
import 'package:chatezy/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  late AuthService _authService;
  final GetIt _getIt = GetIt.instance;

  late CollectionReference<UserProfile> _userscollection;

  DatabaseService() {
    _authService = _getIt.get<AuthService>();
    _setupCollectionReferences();
  }

  void _setupCollectionReferences() {
    _userscollection = _firebaseFirestore.collection('users').withConverter<UserProfile>(
          fromFirestore: (snapshots, _) => UserProfile.fromJson(
            snapshots.data()!,
          ),
          toFirestore: (UserProfile userProfile, _) => userProfile.toJson(),
        );
  }

  Future<void> createUserProfile({required UserProfile userProfile}) async {
    await _userscollection.doc(userProfile.uid).set(userProfile);
  }


  Stream<QuerySnapshot<UserProfile>> getUSerProfiles() {
    return _userscollection
    ?.where("uid", isNotEqualTo: _authService.user!.uid)
    .snapshots() as Stream<QuerySnapshot<UserProfile>>;
  }
}