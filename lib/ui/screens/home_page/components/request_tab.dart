import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_woman_mentor/controller/request_controller.dart';
import '../../../../models/request.dart';
import '../../../../providers/auth.dart';
import '../../../../utils/constants.dart';

class RequestTab extends StatefulWidget {
  RequestTab({Key? key}) : super(key: key);

  @override
  State<RequestTab> createState() => _RequestTabState();
}

class _RequestTabState extends State<RequestTab> {
  bool isLoading = false;
  Future fetchMenteeRequest() async {
    setState(() {
      isLoading = true;
    });
    String token = Provider.of<Auth>(context, listen: false).token;
    await Provider.of<RequestController>(context, listen: false)
        .fetchMenteeRequest(token);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchMenteeRequest();
  }

  @override
  Widget build(BuildContext context) {
    // Auth auth = Provider.of<Auth>(context);
    List<MenteeRequest> requests =
        Provider.of<RequestController>(context).requests;
    return !isLoading
        ? ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) => ChangeNotifierProvider.value(
                  value: requests[index],
                  child: RequestListItem(),
                ))
        : const Center(child: CircularProgressIndicator());
    // return FutureBuilder(
    //     future: requestCtrl.fetchRequestController(auth.token),
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         if (snapshot.hasError) {
    //           return const Center(
    //             child: Text('Faild to load data'),
    //           );
    //         } else if (snapshot.hasData) {
    //           List<MenteeRequest> menteeRequest =
    //               snapshot.data as List<MenteeRequest>;
    //           return ListView.builder(
    //               itemCount: menteeRequest.length,
    //               itemBuilder: (context, index) => ChangeNotifierProvider.value(
    //                     value: menteeRequest[index],
    //                     child: RequestListItem(),
    //                   ));
    //         }
    //       }
    //       return const Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     });
  }
}

class RequestListItem extends StatelessWidget {
  RequestListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Consumer<MenteeRequest>(builder: (context, menteeRequest, __) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -2),
              leading: menteeRequest.profilePic == null
                  ? CircleAvatar(
                    radius: 30,
                      backgroundColor: kPrimaryColor,
                      child: Text(
                        menteeRequest.firstName.substring(0, 1).toUpperCase(),
                        style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : CircleAvatar(
                    radius: 30,
                      backgroundImage: NetworkImage(menteeRequest.profilePic!),
                    ),
              title: Text(
                '${menteeRequest.firstName} ${menteeRequest.lastName}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(menteeRequest.educationLevel),
              trailing: Text(
                menteeRequest.state,
                style: TextStyle(
                    color: menteeRequest.state ==
                            requestStatus['accepted'].toString()
                        ? Colors.green
                        : menteeRequest.state ==
                                requestStatus['rejected'].toString()
                            ? kPrimaryColor
                            : Colors.orangeAccent),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: width * 0.4,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Review',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(primary: kSecondaryColor),
                  ),
                ),
                SizedBox(
                  width: width * 0.4,
                  child: ElevatedButton(
                    onPressed: menteeRequest.state ==
                            requestStatus['open'].toString()
                        ? () {
                            menteeRequest.acceptRequest(menteeRequest.id, Provider.of<Auth>(context, listen: false).token);
                          }
                        : null,
                    child: Text(
                      'Accept',
                      style: TextStyle(
                          color: menteeRequest.state ==
                                  requestStatus['open'].toString()
                              ? Colors.white
                              : Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(primary: kPrimaryColor),
                  ),
                )
              ],
            ),
            const Divider(
              color: Colors.grey,
              height: 5,
              thickness: 2,
            )
          ],
        ),
      );
    });
  }
}
