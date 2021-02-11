# Near Chat

The near chat works on google’s Nearby Messages API. The API allows you to pass small binary payloads between devices. It uses a combination of bluetooth, bluetooth low energy, Wi-Fi and near ultrasonic audio to communicate a unique-in-time pairing code between devices.  The server facilitates message exchange between devices that detect the same pairing code. When a device detects a pairing code from a nearby device, it sends the pairing code to the Nearby Messages server for validation, and to check whether there are any messages to deliver for the application’s current set of subscriptions.

The following sequence shows the events leading to message exchange:
1. A publishing app makes a request to associate a binary payload (the message) with a unique-in-time pairing code (token). The server makes a temporary association between the message payload and the token.
2. The publishing device uses a combination of Bluetooth, Bluetooth Low Energy, Wi-Fi and an ultrasonic modem to make the token detectable by nearby devices. The publishing device also uses these technologies to scan for tokens from other devices.
3. A subscribing app associates its subscription with a token and uses a mix of the above technologies to send its token to the publisher, and to detect the publisher's token.
When either side detects the other's token, it reports it to the server.
4. The server facilitates message exchange between two devices when both are associated with a common token, and the API keys used by the calling apps are associated with the same project in the Google Developers Console.


**Developed as part of the Mobile Communication and Computing Lab Project required for Semester VII, Computer Engineering - University of Mumbai**
