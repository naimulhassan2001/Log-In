

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sagor/home_page.dart';


class Sagor extends StatefulWidget {
  const Sagor({super.key});

  @override
  State<Sagor> createState() => _SagorState();
}

class _SagorState extends State<Sagor> {

  TextEditingController email = TextEditingController() ;
  TextEditingController password = TextEditingController() ;

  String login = "Log In" ;

  Future getData() async {

    // 'https://xpart.top/breakup/log_in.php?email=developernaimul00@gmail.com&password=112244' ;
    final uri = Uri.parse('https://xpart.top/breakup/log_in.php?email=${email.text}&password=${password.text}') ;
    var respones = await http.get(uri) ;
    return jsonDecode(respones.body) ;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In Page'),
      ),
      body:  FutureBuilder(
        future: getData(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          controller: email,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)
                              )
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          controller: password,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)
                              )
                          ),
                        ),
                      ),
                      const SizedBox(height: 30,),

                      ElevatedButton(
                          onPressed: (){
                            String mail =snapshot.hasData ? snapshot.data[0]['email'] : 'abc';
                            String pass =snapshot.hasData ? snapshot.data[0]['password'] : 'abc' ;

                            if(mail == email.text && pass == password.text) {

                              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage())) ;
                              print('data load');
                            } else{
                              setState(() {
                                login = 'invalid' ;
                              });
                              print('null');


                            }

                      },
                          child: Text(login))
                    ],
                  ),
                ),
              );
            }
            return const CircularProgressIndicator();
          },
      )
    );
  }
}
