//
//  Command.h
//  NifRomo
//
//  Created by sci01507 on 15-6-8.
//  Copyright (c) 2015年 iot.team. All rights reserved.
//

#ifndef NifRomo_Command_h
#define NifRomo_Command_h

/***********
 about the topic
 forward    0000 0001         0x01
 back       0000 0010         0x02
 left       0000 0100         0x04
 right      0000 1000         0x08
 up         0001 0000         0x10
 down       0010 0000         0x20
 
 not-f      1111 1110         0xfe
 not-b      1111 1101         0xfd
 not-l      1111 1011         0xfb
 not-r      1111 0111         0xf7
 not-u      1110 1111         0xef
 not-d      1101 1111         0xdf
 
 status =   0000 0000         0x00
 
 takepic    0100 0000         0x40
 
 *****/

#define isStop    0x00
#define isForward 0x01
#define isBack    0x02
#define isLeft    0x04
#define isRight   0x08
#define isUp      0x10
#define isDown    0x20

#define noForward 0xfe
#define noBack    0xfd
#define noLeft    0xfb
#define noRight   0xf7
#define noUp      0xef
#define noDown    0xdf

#define isTakepic 0x40

#define kTopic    @"move"
#define kTopicPic @"pic"

#define NCMB_ApplicationKey @"input your ApplicationKey"
#define NCMB_ClientKey @"input your ClientKey"


#endif
