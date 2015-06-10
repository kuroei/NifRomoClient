NIFTY Romo Project
------------------------------------------------------------

This P-r is an simple IoT Demo which has been on show at「Cloud Computing Expo Japan Spring 2015」and「APPS JAPAN 2015」.
We used the smartphone robot Romo, MQTT and WebRTC to show how to creat a simple application for IoT.

![img](https://scontent.xx.fbcdn.net/hphotos-xfa1/v/t1.0-9/11393160_823670774378068_6055071381405467661_n.jpg?oh=cd90b4685e1be44f2e0b086f8af8743c&oe=5602782D)

## Requirements

### Driver

* Romo 
Romo Official Website (Japan): (http://www.romotive.jp/)
* iphone
iphone5, iphone5s, iphone5c 

### Software

* xcode 6.0 or later
* ios 7.0 or later

## lib

* FacebookSDK.framework 
Download：(https://developers.facebook.com/docs/ios/downloads)
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

* NifRomoController (https://github.com/kuroei/NifRomoController.git)

## About the MQTT server

This p-r use the 「NIFTYCloud MQTT」as default setting .you also can change it with your MQTT Server.

* 「NIFTYCloud MQTT」(http://cloud.nifty.com/service/mqtt.htm)

## About the Push Message

This p-r used the 「NIFTYCloud mobile backend」to save the photos and send the push message to the mobile phones which have been registered in the「NIFTYCloud mobile backend」.
Also if you want to see the photos which you took from the Client, you need a webserver to display them.
This p-r used the 「NIFTYCloud C4SA」to display the photos because「NIFTYCloud C4SA」is almost free.

* 「NIFTYCloud mobile backend」(http://mb.cloud.nifty.com/)
* 「NIFTYCloud C4SA」(http://c4sa.nifty.com/)
