import 'package:ecommerce_app/utils/responsive_menu.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveMenu(
        title: "Profile",
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.all(8.0),
                            color: Colors.red,
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Card(
                                shape: const CircleBorder(),
                                clipBehavior: Clip.antiAlias,
                                child: Image.network(
                                  'https://picsum.photos/seed/904/600',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text("data"),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            height: 500,
                            color: Colors.green,
                          )
                        ],
                      )),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          Container(
                            height: 1000,
                            color: Colors.green,
                          )
                        ],
                      ))
                ],
              ),
            ],
          ),
        ));
  }
}
