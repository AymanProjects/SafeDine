import 'package:SafeDine/Models/Account.dart';
import 'package:SafeDine/Services/Authentication.dart';
import 'package:SafeDine/Services/Database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Interfaces/DatabaseModel.dart';
import 'Branch.dart';
import 'Category.dart';

class Restaurant extends Account implements DatabaseModel{
  List<Category> _menu;
  @override
  String id;

  Restaurant({String id, String email, String password,
    String name, List<Category> menu}): super(name: name, email: email, password: password){
    this.id = id;
    this._menu = menu;
  }

 @override
  Map<String, dynamic> toJson() {
    return {
      'id': getID(),
      'email': super.getEmail(),
      'name' : super.getName(),
      'menu' : getMenu()?.map((category) {
        return category?.toJson();
      })?.toList(),
    };
  }

  @override
  Restaurant fromJson(Map json){
    if (json == null) return Restaurant();
    return new Restaurant(
      id: json['id'],
      email: json['email'],
      name : json['name'],
      menu : json['menu']?.map<Category>((json) {
        return Category().fromJson(json);
      })?.toList(),
    );
  }

  bool createTableQR(String tableNumber){
    //
  }

  @override
  Future<Restaurant> fetch(String id) async{
    DocumentSnapshot doc = await Database().getDocument(id, Database.restaurantsCollection);
    return fromJson(doc.data);
  }

  @override
  Future updateOrCreate() async{
    await Database().setDocument(this, Database.restaurantsCollection);
  }

  Future addBranch(Branch branch) async{
    await Database().setDocument(branch, Database.branchesCollection);
  }

  Future deleteBranch(Branch branch) async{
    await Database().deleteDocument(branch.id, Database.branchesCollection);
  }

  @override
  Future<void> login() async{
    final auth = Authentication();
    return await auth.login(this);
  }
  @override
  Future<void> logout() async{
    final auth = Authentication();
    return await auth.signOut();
  }
  @override
  Future<void> register() async{
    final auth = Authentication();
    return await auth.register(this);
  }

  List<Category> getMenu() => _menu ?? [];

  setMenu(List<Category> value) {
    _menu = value;
  }

   @override
  String getID() {
    return id ?? '';
  }

  @override
  void setID(String id) {
    this.id = id;
  }
}

