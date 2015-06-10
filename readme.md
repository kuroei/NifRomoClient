NIFTY Romo Project
------------------------------------------------------------

This P-r is an simple IoT Demo which has been on show at�uCloud Computing Expo Japan Spring 2015�vand�uAPPS JAPAN 2015�v.
We used the smartphone robot Romo, MQTT and WebRTC to show how to creat a simple application for IoT.

![img](https://scontent.xx.fbcdn.net/hphotos-xpt1/v/t1.0-9/11044952_811750628903416_2888003761710349589_n.jpg?oh=2e0e043b78a565b0461c66667c3f3388&oe=56021BAF)

## Requirements

### Driver

* Romo 
Romo�̌����T�C�g�i���{�j�F(http://www.romotive.jp/)
* iphone
iphone5, iphone5s, iphone5c 

### Software

* xcode 6.0 �ȏ�
* ios 7.0 �ȏ�

## lib

* FacebookSDK.framework 
Download�F(https://developers.facebook.com/docs/ios/downloads)
* NCMB.framework
Download: (http://mb.cloud.nifty.com/doc/sdkdownload_ios.html)
* RMCore.framework
Download: (http://www.romotive.com/developers/)

## Installation

```
$ git clone https://github.com/kuroei/NifRomoClient.git
$ cd NifRomoClient/
$ pod install
```
## How to Use

### Run Project and build

After installed the pods, you can start this  p-r with  NifRomo.xcworkspace and then build it to your iphone.

### Run Application

* input the authentication infomation for MQTT Server at the login screen and connect the Server.
* do the same thing at Controllor of this p-r.
* then you can control the Romo robot with the Controller.

## About the Controller of this p-r

* (https://github.com/kuroei/NifRomoController.git)

## About the MQTT server

This p-r use the �uNIFTYCloud MQTT�vas default setting .you also can change it with your MQTT Server.

* �uNIFTYCloud MQTT�v(http://cloud.nifty.com/service/mqtt.htm)

## About the Push Message

This p-r used the �uNIFTYCloud mobile backend�vto save the photos and send the push message to the mobile phones which have been registered in the�uNIFTYCloud mobile backend�v.
Also if you want to see the photos which you took from the Client, you need a webserver to display them.
This p-r used the �uNIFTYCloud C4SA�vto display the photos because�uNIFTYCloud C4SA�vis almost free.

* �uNIFTYCloud mobile backend�v(http://mb.cloud.nifty.com/)
* �uNIFTYCloud C4SA�v(http://c4sa.nifty.com/)
