import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blogger_app/bloc/main_bloc.dart';
import 'package:flutter/material.dart';
import 'dart:io';


class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: true,
      create: (BuildContext context) => UserBloc(),
      child: BlocListener<UserBloc, UserState>(
        listener: (context, UserState state){
          if(state is LogOut){
            exit(0);
          }
        },
        child: HomePageView()
      )

    );
  }
}


class HomePageView extends StatefulWidget {

  const HomePageView({
    Key key,
  }) : super(key: key);

  @override
  _HomePageView createState() => _HomePageView();
}

class _HomePageView extends State<HomePageView>{
  @override
  Widget build(BuildContext context){

    return BlocBuilder(
        bloc: context.read<UserBloc>(),
        builder: (BuildContext context, UserState state){
        if (state is LogOut){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("Home"),

            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  CustomDrawerHeader(),

                  ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text('Profile'),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                  ListTile(
                    leading: Icon(Icons.power_settings_new_sharp),
                    title: Text('LogOut'),
                    onTap: (){
                      context.read<UserBloc>().add(IsLogOut());
                    },

                  )
                ],
              ),
            ),
            backgroundColor: Colors.white,
            body: Center(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 5.0),

                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                    ],
                  )
                ],
              ),
            )
        );
        }
    );
  }

}




class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final data = context.read<UserBloc>().testData;
        return SizedBox(
          height: 300.0,
          child: Container(
            color: Colors.deepPurple[900],
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 40.0, bottom: 10.0),
                  child: SizedBox(
                    width: 200.0,
                    height: 150.0,
                    child: Card(
                        color: Colors.deepPurple[900],
                        child: Icon(
                          Icons.account_circle,
                          size: 125.0,
                        )
                    ),
                  ),
                ),
                Text(
                  data.username,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                Text(
                  'Balance: R${data.balance}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

