import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:npark_buddy/editprofile.dart';
import 'main.dart';
import 'resetPW.dart';

import 'package:provider/provider.dart';
import 'provider.dart';
//main for debugging
void main() => runApp(const MaterialApp(
  home: Profile(),
));

class Profile extends StatelessWidget {
  const Profile({super.key});

  
  @override
  Widget build(BuildContext context) {

    String username = Provider.of<UserData>(context, listen:false).username;
    String email = Provider.of<UserData>(context, listen:false).email;

    return Scaffold(
      backgroundColor: const Color(0xFFFEFBEA),
      // appBar: AppBar(
      //   title: Row(
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
      //         child: Image.asset(
      //           'assets/logo.png',
      //           height: 70,
      //           width: 70,
      //         ),
      //       ),
      //       const Text(
      //         'ParkBuddy',
      //         style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
      //       )
      //   ],
      // ),

      //   backgroundColor: const Color(0xFF2B512F),
      //   foregroundColor: Colors.white,
      //   toolbarHeight: 110,
      // ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children:[
                const Padding(
                  padding: EdgeInsets.fromLTRB(120, 30, 0, 30),
                  child: Center(
                    child: Text(
                      'My Profile',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:(context) => 
                          const EditProfile(),
                      )
                    );
                  },
                )
              ]
            ),
        
            Container(
              width: 390,
              height: 250,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Color(0xFF2B512F),
              ),
              child: Column(
                children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(30),
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.asset('assets/profilepic.png'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 15, 0, 0),
                          child: AutoSizeText(
                            username,
                            softWrap: true,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        
                      ],
                    ),
        
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: Text(
                        email,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ]
              ),
            ),
        
            Padding(
              padding: const EdgeInsets.fromLTRB(0,15,0,0),
              child: SizedBox(
                width: 300,
                height: 50,
                child: OutlinedButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                          ResetPW()),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )
                  ),
                  child: const Text(
                    'Change password',
                    style: TextStyle(
                      fontSize: 20, 
                      fontWeight: FontWeight.w500, 
                      color: Colors.black,
                    ),
                  )
                  
                ),
              ),
            ),
        
            Padding(
              padding: const EdgeInsets.fromLTRB(0,120,0,0),
              child: SizedBox(
                width: 300,
                height: 50,
                child: OutlinedButton(
                  onPressed: (){showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      titlePadding: const EdgeInsets.fromLTRB(50, 50, 50, 20),
                      backgroundColor: const Color(0xFFFEFBEA),
                      surfaceTintColor: const Color(0xFFFEFBEA),
                      title: const Center(child: Text('Are you sure you want to log out?')),
                      titleTextStyle: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        
                      ),
                      actions: <Widget>[
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              child: OutlinedButton(
                                onPressed: () => Navigator.pop(context, 'Back'),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                  backgroundColor: const Color(0xFFFEFBEA),
                                  side: const BorderSide(color: Colors.black),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                ),
                                child: const Text(
                                  'Back',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                              
                                  )
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Landing(),
                                    ),
                                    (Route<dynamic> route) => false, // Removes all routes below the new route
                                  );
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                  backgroundColor: Colors.red[900],
                                  side: const BorderSide(color: Colors.red),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                ),
                                child: const Text(
                                  'Log Out',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                              
                                  )
                                ),
                              ),
                            ),
                          ],
                        )
                        
                      ]
                    )
                  );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.red[900],
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    )
                  ),
                  child: const Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 20, 
                      fontWeight: FontWeight.w900, 
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )


    );
  }
}

