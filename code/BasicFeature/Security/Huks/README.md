# Harmony Universal Keystore Service

### Introduction

This sample shows how `@ohos.security.huks` works to implement encryption and decryption of arbitrary input content. The implementation scenario is as follows:

1. Using a new key for message encryption and decryption transmission: Use the HUKS generated key interface to generate a new key locally, simulating the scenario where the device encrypts the sent message and decrypts the received message.

2. Using an old key for message encryption and decryption transmission: Import an old key using HUKS' import key interface to simulate the scenario of encrypting the sent message on the old device and decrypting the received message on the new device.

### Usage

1. Click the **New Key** button on the main page, enter the message content to be sent in the input box of the new key interface, and click **Send Message**
button, the encrypted message content will be displayed in the text box below, and then click the **Receive Message** button. The decrypted message content will be displayed in the text box below.
2. Click the **Back** button in the upper left corner to return to the main interface.
3. Click on the **Old Key** button on the main page, enter the message content to be sent in the input box of the old key interface, and click **Send Message**
button, the decrypted message content will be displayed in the text box below. First, click the **Import Key** button, and a pop-up window will prompt that the key was successfully imported. Then, click the **Receive Message** button, and the decrypted message content will be displayed in the text box below.
4. Click the **Back** button in the upper left corner to return to the main interface.

### Constraints

1. This sample can only be run on standard-system devices.

2. This sample has been adapted to the API version 9 SDK, version number 3.2.11.9.

3. This sample requires DevEco Studio 3.1 Canary1 (Build Version: 3.1.0.400) to compile and run.