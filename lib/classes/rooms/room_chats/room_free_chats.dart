// import 'package:flutter/foundation.dart';
// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../headers/utils/utils.dart';

class RoomFreeChatScreen extends StatefulWidget {
  const RoomFreeChatScreen({super.key, this.getFreeRoomChatData});
  //
  final getFreeRoomChatData;
  //
  @override
  State<RoomFreeChatScreen> createState() => _RoomFreeChatScreenState();
}

class _RoomFreeChatScreenState extends State<RoomFreeChatScreen> {
  //

  //
  @override
  Widget build(BuildContext context) {
    //
    Size size = MediaQuery.of(context).size;
    //
    return Scaffold(
      appBar: AppBar(
        title: textWithSemiBoldStyle(
          'Free room chat',
          16.0,
          Colors.white,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromRGBO(31, 43, 66, 1),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              // Added
              child: Container(
                  width: size.width,
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Expanded(
                        // Added
                        child: ListView.builder(
                          itemCount: 6,
                          itemBuilder: (context, i) {
                            return (i % 2 == 0)
                                ? Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                            right: 40,
                                            left: 0.0,
                                            top: 12.0,
                                          ),
                                          // color: const Color.fromARGB(
                                          //     255, 228, 232, 235),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.person,
                                                  color: Colors.pink,
                                                  size: 18.0,
                                                ),
                                                const SizedBox(
                                                  width: 6.0,
                                                ),
                                                textWithRegularStyle(
                                                  'dishu',
                                                  12.0,
                                                  Colors.black,
                                                  'left',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                            right: 40,
                                            left: 10.0,
                                          ),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(
                                                16,
                                              ),
                                              bottomRight: Radius.circular(
                                                16,
                                              ),
                                              topRight: Radius.circular(
                                                16,
                                              ),
                                            ),
                                            color: Color.fromARGB(
                                                255, 228, 232, 235),
                                          ),
                                          padding: const EdgeInsets.all(
                                            16,
                                          ),
                                          child: textWithRegularStyle(
                                            'Data is Data is Data is Data is Data is Data is Data is Data is Data isData is Data is Data is Data is Data is Data is Data is Data isData is Data is Data is Data is Data is Data is Data is Data is ',
                                            // 'data',
                                            14.0,
                                            Colors.black,
                                            'left',
                                          ),
                                        ),
                                      ),
                                      //
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                            right: 40,
                                            left: 10.0,
                                            top: 0.0,
                                          ),
                                          // color: const Color.fromARGB(
                                          //     255, 228, 232, 235),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.schedule,
                                                  size: 14.0,
                                                ),
                                                textWithRegularStyle(
                                                  '12:00',
                                                  12.0,
                                                  Colors.black,
                                                  'left',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      //
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                            right: 40,
                                            left: 0.0,
                                            top: 12.0,
                                          ),
                                          // color: const Color.fromARGB(
                                          //     255, 228, 232, 235),
                                          // child: Padding(
                                          //   padding: const EdgeInsets.all(6.0),
                                          //   child: Row(
                                          //     children: [
                                          // const Icon(
                                          //   Icons.person,
                                          //   color: Colors.pink,
                                          //   size: 18.0,
                                          //       // ),
                                          //       const SizedBox(
                                          //         width: 6.0,
                                          //       ),
                                          //       textWithRegularStyle(
                                          //         'dishu',
                                          //         12.0,
                                          //         Colors.black,
                                          //         'left',
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                            right: 10,
                                            left: 40.0,
                                          ),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(
                                                16,
                                              ),
                                              bottomLeft: Radius.circular(
                                                16,
                                              ),
                                              topRight: Radius.circular(
                                                16,
                                              ),
                                            ),
                                            color:
                                                Color.fromRGBO(31, 43, 66, 1),
                                          ),
                                          padding: const EdgeInsets.all(
                                            16,
                                          ),
                                          child: textWithRegularStyle(
                                            'Data is Data is Data is Data is Data is Data is Data is Data is Data isData is Data is Data is Data is Data is Data is Data is Data isData is Data is Data is Data is Data is Data is Data is Data is ',
                                            // 'data',
                                            14.0,
                                            Colors.white,
                                            'left',
                                          ),
                                        ),
                                      ),
                                      //
                                      Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                            right: 10,
                                            left: 40.0,
                                            top: 0.0,
                                          ),
                                          // color: const Color.fromARGB(
                                          //     255, 228, 232, 235),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                const Icon(
                                                  Icons.schedule,
                                                  size: 12.0,
                                                ),
                                                const SizedBox(
                                                  width: 4.0,
                                                ),
                                                textWithRegularStyle(
                                                  '12:00',
                                                  12.0,
                                                  Colors.black,
                                                  'left',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      //
                                    ],
                                  );
                          },
                        ),
                      ),
                      //
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  // controller: contTextSendMessage,
                                  minLines: 1,
                                  maxLines: 5,
                                  decoration: const InputDecoration(
                                    // labelText: '',
                                    hintText: 'write something',
                                  ),
                                ),
                              ),
                            ),
                            //
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 40,
                                width: 40,
                                child: IconButton(
                                  onPressed: () {
                                    //
                                  },
                                  icon: const Icon(
                                    Icons.send,
                                  ),
                                ),
                              ),
                            ),

                            //
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
      /*Stack(
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(
                    right: 40,
                    left: 10.0,
                    top: 10.0,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        16,
                      ),
                      bottomRight: Radius.circular(
                        16,
                      ),
                      topRight: Radius.circular(
                        16,
                      ),
                    ),
                    color: Color.fromARGB(255, 228, 232, 235),
                  ),
                  padding: const EdgeInsets.all(
                    16,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: textWithRegularStyle(
                          'dishu',
                          10.0,
                          Colors.black,
                          'left',
                        ),
                      ),
                      //
                      const SizedBox(
                        height: 8.0,
                      ),
                      textWithRegularStyle(
                        'Data is Data is Data is Data is Data is Data is Data is Data is Data isData is Data is Data is Data is Data is Data is Data is Data isData is Data is Data is Data is Data is Data is Data is Data is ',
                        // 'data',
                        14.0,
                        Colors.black,
                        'left',
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: textWithRegularStyle(
                          '12:00',
                          10.0,
                          Colors.black,
                          'left',
                        ),
                      ),
                      //
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(
                    right: 10,
                    left: 40.0,
                    top: 10.0,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        16,
                      ),
                      bottomRight: Radius.circular(
                        16,
                      ),
                      topRight: Radius.circular(
                        16,
                      ),
                    ),
                    color: Color.fromRGBO(31, 43, 66, 1),
                  ),
                  padding: const EdgeInsets.all(
                    16,
                  ),
                  child: Column(
                    children: [
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: textWithRegularStyle(
                      //     'dishu',
                      //     10.0,
                      //     Colors.white,
                      //     'left',
                      //   ),
                      // ),
                      // //
                      // const SizedBox(
                      //   height: 8.0,
                      // ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: textWithRegularStyle(
                          'Data is Data is Data is Data is Data is Data is Data is Data is Data isData is Data is Data is Data is Data is Data is Data is Data isData is Data is Data is Data is Data is Data is Data is Data is ',
                          // 'data',
                          14.0,
                          Colors.white,
                          'left',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            // controller: contTextSendMessage,
                            minLines: 1,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              // labelText: '',
                              hintText: 'write something',
                            ),
                          ),
                        ),
                      ),
                      //

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: IconButton(
                            onPressed: () {
                              //
                            },
                            icon: const Icon(
                              Icons.send,
                            ),
                          ),
                        ),
                      ),
                      /*IconButton(
                onPressed: () {
                  if (kDebugMode) {
                    print('send');
                  }
                  //
                        
                  sendMessageViaFirebase(contTextSendMessage.text);
                  lastMessage = contTextSendMessage.text.toString();
                  contTextSendMessage.text = '';
                        
                  // }
                },
                icon: const Icon(
                  Icons.send,
                ),
                            ),*/
                      //
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),*/
    );
  }
}
