import 'package:flutter/material.dart';

void connectionInitSheet(context, id, authenticationToken, endpointName,
    isIncomingConnection, onPressed) {
  showModalBottomSheet(
    context: context,
    builder: (builder) {
      return Center(
        child: Column(
          children: [
            Text('id: $id'),
            Text('Token: $authenticationToken'),
            Text('Name: $endpointName'),
            Text('Incoming: $isIncomingConnection'),
            RaisedButton(
              child: Text('Accept Connection'),
              onPressed: () {
                Navigator.pop(context);
                onPressed(id);
              },
            ),
          ],
        ),
      );
    },
  );
}
