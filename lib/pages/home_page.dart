import 'package:flutter/material.dart';
import 'package:minimal_app/services/auth/auth_service.dart';
import 'package:minimal_app/services/chat/chat_service.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../components/my_drawer.dart';
import '../components/user_tile.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        foregroundColor: Colors.grey,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList(){
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot){
        if(snapshot.hasError){
          return const Text("Error");
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: LoadingAnimationWidget.flickr(leftDotColor: Theme.of(context).colorScheme.primary, rightDotColor: Theme.of(context).colorScheme.secondary, size: 40));
        }

        return ListView(
          children: snapshot.data!.map<Widget>((userData)=>_buildUserListItem(userData, context)).toList(),
        );
      }
    );
  }

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context){
    if(userData['email'] != _authService.getCurrentUser()!.email){
      return UserTile(text: userData['email'], onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(
          receiverEmail: userData['email'],
          receiverID: userData['uid'],
        )));
      },);
    }
    else{
      return Container();
    }
  }
}
