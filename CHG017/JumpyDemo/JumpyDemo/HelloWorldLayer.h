//
//  HelloWorldLayer.h
//  JumpyDemo
//
//  Created by Martin Höller on 01.07.12.
//  Copyright BytePoets GmbH 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
    CCSprite *player;
    CGPoint velocity;
    
    CCArray *salads;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
