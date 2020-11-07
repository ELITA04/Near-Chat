import 'package:flutter/material.dart';
import 'package:near_chat/utils/constants.dart';

void connectionAlert(context, id, authenticationToken, endpointName,
    isIncomingConnection, onAccepted, onRejected) {
  showDialog(
    context: context,
    builder: (builder) {
      return AlertDialog(
        title: Text('Connect to $endpointName?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('ID: $id'),
            Text('Authentication Token: $authenticationToken'),
          ],
        ),
        actions: [
          FlatButton(
            color: kGreen,
            child: Text(
              'Accept',
              style: TextStyle(color: kBlack),
            ),
            onPressed: () {
              Navigator.pop(context);
              onAccepted();
            },
          ),
          FlatButton(
            color: kRed,
            child: Text(
              'Reject',
              style: TextStyle(color: kBlack),
            ),
            onPressed: () {
              Navigator.pop(context);
              onRejected();
            },
          ),
        ],
      );
    },
  );
}
