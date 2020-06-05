import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pollingsystem/Authentication/Data.dart';
import 'package:pollingsystem/Authentication/User.dart';
import 'package:provider/provider.dart';

class DatabaseService{

  final String uid;


  DatabaseService({this.uid});
final  CollectionReference pollingCollection=Firestore.instance.collection('Udata');
  Future updateUserData(String name,int aadhar,String city, int contact ) async {
return await pollingCollection.document(uid).updateData({
'name':name,

'aadhar':aadhar,
'city':city,
'contact':contact,

});
  }

  List<Data> _newsListfromSnapshoot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Data(name: doc.data['name']??'',
      mail: doc.data['Email']??'',
      aadhar: doc.data['aadhar']??'',
      city:doc.data['city']??'',
      contact:doc.data['contact']??''
      );
      
    } ).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot)
  {
    return UserData(
      uid:uid,
      name: snapshot.data['name'],
      mail: snapshot.data['Email'],
      aadhar: snapshot.data['aadhar'],
      city: snapshot.data['city'],
      contact: snapshot.data['contact'],
      flag:snapshot.data['flag']


    );
  }
  Stream<List<Data>> get Udata{
    return pollingCollection.snapshots().map(_newsListfromSnapshoot);
  }

  Stream<UserData> get userData{

    return pollingCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }

 
}

