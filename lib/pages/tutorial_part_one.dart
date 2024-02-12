// import 'dart:convert';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:go_moon/pages/coin_details.dart';
// import 'package:go_moon/services/http_service.dart';

// // REST ####Animation API integration -COIN CAP

// class HomePage extends StatefulWidget {
//   HomePage();
//   @override
//   State<StatefulWidget> createState() {
//     return _HomePageState();
//   }
// }

// class _HomePageState extends State<HomePage> {
//   double? _deviceHeight, _deviceWidth;
//   String? selectedCoin = "bitcoin";
//   HTTPService? _http;
//   @override
//   void initState() {
//     super.initState();
//     _http = GetIt.instance.get<HTTPService>();
//   }

//   @override
//   Widget build(BuildContext context) {
//     _deviceHeight = MediaQuery.of(context).size.height;
//     _deviceWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: SafeArea(
//           child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           mainAxisSize: MainAxisSize.max,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [_selectedCoinDropDown(), _dataWidget()],
//         ),
//       )),
//     );
//   }

//   Widget _selectedCoinDropDown() {
//     List<String> _coins = ["bitcoin", "tether", "ripple"];

//     List<DropdownMenuItem<String>> _items = _coins
//         .map(
//           (value) => DropdownMenuItem(
//               value: value,
//               child: Container(
//                 padding: const EdgeInsets.only(right: 10),
//                 child: Text(
//                   value,
//                   style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 40,
//                       fontWeight: FontWeight.w600),
//                 ),
//               )),
//         )
//         .toList();
//     return DropdownButton(
//       items: _items,
//       value: selectedCoin,
//       onChanged: (value) {
//         print(value);

//         setState(() {
//           selectedCoin = value;
//         });
//       },
//       dropdownColor: const Color.fromRGBO(88, 88, 206, 1),
//       iconSize: 30,
//       icon: const Icon(
//         Icons.arrow_drop_down_sharp,
//         color: Colors.white,
//       ),
//       underline: Container(),
//     );
//   }

//   Widget _dataWidget() {
//     return FutureBuilder(
//         future: _http!.get("/coins/$selectedCoin"),
//         builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
//           if (asyncSnapshot.hasData) {
//             Map data = jsonDecode(asyncSnapshot.data.toString());
//             num usedPrice = data["market_data"]["current_price"]["usd"];
//             num percentageChange =
//                 data["market_data"]["price_change_percentage_24h"];
//             String imgUrl = data["image"]["large"];
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.max,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 GestureDetector(
//                   onDoubleTap: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (BuildContext context) {
//                       return CoinDetails(test: selectedCoin!,);
//                     }));
//                   },
//                   child: _coinImageWidget(imgUrl),
//                 ),
//                 _usdPriceContainer(usedPrice),
//                 _percentageChange(percentageChange),
//                 _descWidget(data["description"]["en"])
//               ],
//             );
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(
//                 color: Colors.white,
//               ),
//             );
//           }
//         });
//   }

//   Widget _usdPriceContainer(num price) {
//     return Text(
//       "${price.toStringAsFixed(2)} USD",
//       style: const TextStyle(
//         color: Colors.white,
//         fontSize: 20,
//         fontWeight: FontWeight.w500,
//       ),
//     );
//   }

//   Widget _percentageChange(num price) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 5),
//       child: Text(
//         "${price.toStringAsFixed(2)} %",
//         style: TextStyle(
//           color: (price < 0)
//               ? const Color.fromARGB(255, 236, 154, 148)
//               : const Color.fromARGB(255, 140, 228, 143),
//           fontSize: 10,
//           fontWeight: FontWeight.w300,
//         ),
//       ),
//     );
//   }

//   Widget _coinImageWidget(String imgUrl) {
//     return Container(
//       height: _deviceHeight! * 0.15,
//       width: _deviceWidth! * 0.15,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: NetworkImage(imgUrl),
//         ),
//       ),
//     );
//   }

//   Widget _descWidget(String content) {
//     return Container(
//       height: _deviceHeight! * 0.45,
//       width: _deviceWidth! * 0.9,
//       margin: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.05),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: const Color.fromRGBO(83, 88, 206, 0.5)),
//       padding: EdgeInsets.symmetric(
//         vertical: _deviceHeight! * 0.01,
//         horizontal: _deviceWidth! * 0.02,
//       ),
//       child: Text(content,
//           style: const TextStyle(
//             color: Colors.white,
//           )),
//     );
//   }
// }
// // import 'package:go_moon/models/task.dart';
// // import 'package:hive/hive.dart';
// // import 'package:go_moon/widgets/custom_dropdown.dart';

// // ####Animation - ANimo

// // class HomePage extends StatefulWidget {
// //   HomePage();
// //   @override
// //   State<StatefulWidget> createState() {
// //     return _HomePageState();
// //   }
// // }

// // class _HomePageState extends State<HomePage>
// //     with SingleTickerProviderStateMixin {
// //   double _buttonRadius = 100;
// //   final Tween<double> _backgroundScale = Tween<double>(begin: 0, end: 1);
// //   AnimationController? _startAnimationController;

// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     super.initState();
// //     _startAnimationController =
// //         AnimationController(vsync: this, duration: const Duration(seconds: 4));
// //         _startAnimationController!.repeat();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Container(
// //         child: Stack(
// //           clipBehavior: Clip.none,
// //           children: [
// //             _pageBackground(),
// //             Column(
// //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //               mainAxisSize: MainAxisSize.max,
// //               crossAxisAlignment: CrossAxisAlignment.center,
// //               children: [_circularAnimationButton(), _startIcon()],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _pageBackground() {
// //     return TweenAnimationBuilder(
// //       tween: _backgroundScale,
// //       duration: Duration(seconds: 2),
// //       curve: Curves.easeInOutCubicEmphasized,
// //       builder: (context, scale, child) {
// //         return Transform.scale(
// //           scale: scale,
// //           child: child,
// //         );
// //       },
// //       child: Container(color: Colors.blue),
// //     );
// //   }

// //   Widget _circularAnimationButton() {
// //     return Center(
// //         child: GestureDetector(
// //             onTap: () {
// //               setState(() {
// //                 _buttonRadius = _buttonRadius == 100
// //                     ? _buttonRadius + 100
// //                     : _buttonRadius - 100;
// //               });
// //             },
// //             child: AnimatedContainer(
// //               duration: const Duration(seconds: 2),
// //               height: _buttonRadius,
// //               curve: Curves.bounceInOut,
// //               width: _buttonRadius,
// //               decoration: BoxDecoration(
// //                   color: Colors.purple,
// //                   borderRadius: BorderRadius.circular(_buttonRadius)),
// //             )));
// //   }

// //   Widget _startIcon() {
// //     return AnimatedBuilder(
// //       animation: _startAnimationController!.view,
// //       builder: ((context, child) {
// //         return Transform.rotate(
// //           angle: _startAnimationController!.value * 2 * pi,
// //           child: child,
// //         );
// //       }),
// //       child: const Icon(
// //         Icons.star,
// //         size: 100,
// //         color: Colors.white,
// //       ),
// //     );
// //   }
// // }



// // ####StateWidget Initialization - Taskly

// // class HomePage extends StatefulWidget {
// //   HomePage();
// //   @override
// //   State<StatefulWidget> createState() {
// //     return _HomePageState();
// //   }
// // }

// // class _HomePageState extends State<HomePage> {
// //   late double _deviceHeight, _deviceWidth;
// //   String? _inputValue;
// //   Box? _box;

// //   _HomePageState();

// //   @override
// //   Widget build(BuildContext context) {
// //     _deviceHeight = MediaQuery.of(context).size.height;
// //     _deviceWidth = MediaQuery.of(context).size.width;
// //     return Scaffold(
// //       appBar: AppBar(
// //         toolbarHeight: _deviceHeight * 0.15,
// //         title: const Text(
// //           "Taskly",
// //           style: TextStyle(fontSize: 25),
// //         ),
// //       ),
// //       body: _taskView(),
// //       floatingActionButton: _addTaskButton(),
// //     );
// //   }

// //   Widget _listView() {
// //     List tasks = _box!.values.toList();
// //     return ListView.builder(
// //         itemCount: tasks.length,
// //         itemBuilder: (BuildContext context, int index) {
// //           var task = Task.fromMap(tasks[index]);
// //           return ListTile(
// //             title: Text(
// //               task.content,
// //               style: task.done
// //                   ? const TextStyle(decoration: TextDecoration.lineThrough)
// //                   : const TextStyle(decoration: TextDecoration.none),
// //             ),
// //             subtitle: Text(task.timestamp.toString()),
// //             trailing: task.done
// //                 ? const Icon(
// //                     Icons.check_box_outlined,
// //                     color: Colors.red,
// //                   )
// //                 : const Icon(
// //                     Icons.check_box_outline_blank,
// //                     color: Colors.red,
// //                   ),
// //             onTap: () {
// //                task.done = !task.done;
// //                 _box!.putAt(index, task.toMap());
// //               setState(() {
               
// //               });
// //             },
// //             onLongPress: () {
// //               _box!.deleteAt(index);
// //               setState(() {
                
// //               });
// //             },
// //           );
// //         });
// //   }

// //   Widget _addTaskButton() {
// //     return FloatingActionButton(
// //       onPressed: _displayPopup,
// //       child: const Icon(Icons.add),
// //     );
// //   }

// //   void _displayPopup() {
// //     showDialog(
// //         context: context,
// //         builder: (BuildContext _context) {
// //           return AlertDialog(
// //             title: const Text("Add New Task"),
// //             content: TextField(
// //               onSubmitted: (value) {
// //                 if (_inputValue != null && _inputValue!.isNotEmpty) {
// //                   var newTask = Task(
// //                       content: _inputValue!,
// //                       done: false,
// //                       timestamp: DateTime.now());
// //                   _box?.add(newTask.toMap());
// //                   setState(() {
// //                     _inputValue = null;
// //                     Navigator.pop(context);
// //                   });
// //                 }
// //               },
// //               onChanged: (value) {
// //                 setState(() {
// //                   _inputValue = value;
// //                 });
// //               },
// //             ),
// //           );
// //         });
// //   }

// //   Widget _taskView() {
// //     return FutureBuilder(
// //         future: Hive.openBox('tasks'),
// //         builder: (BuildContext _context, AsyncSnapshot _snapshot) {
// //           if (_snapshot.hasData) {
// //             _box = _snapshot.data;
// //             return _listView();
// //           } else {
// //             return const Center(child: CircularProgressIndicator());
// //           }
// //         });
// //   }
// // }


// // ####Initial UI Part - GO Moon

// // class HomePage extends StatelessWidget {
// //   HomePage({Key? key}) : super(key: key);
// //   late double _deviceHeight;
// //   late double _deviceWidth;

// //   @override
// //   Widget build(BuildContext context) {
// //     _deviceHeight = MediaQuery.of(context).size.height;
// //     _deviceWidth = MediaQuery.of(context).size.width;
// //     return Scaffold(
// //       body: SafeArea(
// //         child: Container(
// //             height: _deviceHeight,
// //             width: _deviceWidth,
// //             padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05),
// //             child: Stack(
// //               children: [
// //                 Column(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     _pageTitle(),
// //                     SizedBox(
// //                         height: 0.25 * _deviceHeight,
// //                         child: Column(
// //                           mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                           children: [
// //                             _destinationDropDownWidget(),
// //                             _rowWithTravelCount(),
// //                             _rideButton()
// //                           ],
// //                         ))
// //                   ],
// //                 ),
// //                 Align(alignment: Alignment.centerRight, child: _astroImageWidget(),)
// //               ],
// //             )),
// //       ),
// //     );
// //   }

// //   Widget _pageTitle() {
// //     return const Text("#GoMoon",
// //         style: TextStyle(
// //           color: Colors.white,
// //           fontSize: 70,
// //           fontWeight: FontWeight.w800,
// //         ));
// //   }

// //   Widget _astroImageWidget() {
// //     return Container(
// //       width: _deviceWidth*0.65,
// //       height: _deviceHeight*0.55,
// //       decoration: const BoxDecoration(
// //           image: DecorationImage(
// //         fit: BoxFit.fill,
// //         image: AssetImage("assets/images/astro_moon.png"),
// //       )),
// //     );
// //   }

// //   Widget _destinationDropDownWidget() {
// //     List<String> items = ["Test Station", "Moon Station"];
// //     return CustomDropDownClass(
// //       values: items,
// //       width: _deviceWidth,
// //     );
// //   }

// //   Widget _rowWithTravelCount() {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceAround,
// //       children: [_countDropDown(), _classDropDown()],
// //     );
// //   }

// //   Widget _countDropDown() {
// //     List<String> items = ["1", "2", "3", "4", "5"];
// //     return CustomDropDownClass(
// //       values: items,
// //       width: _deviceWidth * 0.40,
// //     );
// //   }

// //   Widget _classDropDown() {
// //     List<String> items = ["Economy", "Casual", "Business"];
// //     return CustomDropDownClass(
// //       values: items,
// //       width: _deviceWidth * 0.45,
// //     );
// //   }

// //   Widget _rideButton() {
// //     return Container(
// //       decoration: BoxDecoration(
// //           color: Colors.white, borderRadius: BorderRadius.circular(10)),
// //       width: _deviceWidth,
// //       child: MaterialButton(
// //           onPressed: () {},
// //           child: const Text(
// //             "Book Ride!!",
// //             style: TextStyle(color: Colors.black),
// //           )),
// //     );
// //   }
// // }
