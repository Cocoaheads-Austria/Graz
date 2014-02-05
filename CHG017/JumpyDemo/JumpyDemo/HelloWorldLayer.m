//
//  HelloWorldLayer.m
//  JumpyDemo
//
//  Created by Martin Höller on 01.07.12.
//  Copyright BytePoets GmbH 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import <Carbon/Carbon.h>
#import "SimpleAudioEngine.h"


// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) 
    {
		player = [[CCSprite alloc] initWithFile:@"player.stand.png"];
        player.position = ccp(100.0f, 100.0f);
        [self addChild:player];
        
        self.isKeyboardEnabled = YES;        
        
        salads = [[CCArray array] retain];
        
        [self scheduleUpdate];
        
        [self schedule:@selector(spawnSalad:) interval:2.0];
        
        
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"jump.wav"];
    }
	return self;
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
    [salads release], salads = nil;
    
	// don't forget to call "super dealloc"
	[super dealloc];
}



- (void)spawnSalad:(ccTime)delta
{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCSprite *salad = [[[CCSprite alloc] initWithFile:@"salad.png"] autorelease];
    salad.position = ccp(winSize.width, 100.0f);
    [self addChild:salad];
    [salads addObject:salad];
}


static CGFloat speed = 200.0f;
static CGFloat gravity = 40.0f;

- (void)update:(ccTime)delta
{
    [self _movePlayer:delta];
    [self _moveSalads:delta];
    [self _detectCollisions];
}


- (void)_movePlayer:(ccTime)delta
{
    // apply gravity
    velocity.y -= gravity;
    
    CGPoint displacement = ccpMult(velocity, delta);
    CGPoint newPosition = ccpAdd(player.position, displacement);
    
    if (newPosition.y < 100.0)
    {
        newPosition.y = 100.0;
    }
    
    player.position = newPosition;
}


- (void)_moveSalads:(ccTime)delta
{
    for (CCSprite *salad in salads)
    {
        CGPoint displacement = ccp(-speed * delta, 0.0f);
        CGPoint newPosition = ccpAdd(salad.position, displacement);
        salad.position = newPosition;
    }
    
    // TODO: remove salads which are off screen
}


- (void)_detectCollisions
{
    CGRect playerBox = player.boundingBox;
    
    for (CCSprite *salad in salads)
    {
        CGRect saladBox = salad.boundingBox;
        
        if (CGRectIntersectsRect(playerBox, saladBox))
        {
            CCBlink *blink = [CCBlink actionWithDuration:2.0 blinks:8];
            [player runAction:blink];
            break;
        }
    }
}


- (BOOL)ccKeyDown:(NSEvent *)event
{
    unichar key = [event keyCode];
    
    switch (key)
    {
        case kVK_UpArrow:   // up
            velocity.y = 700.0;
            [[SimpleAudioEngine sharedEngine] playEffect:@"jump.wav"];
            break;
            
        case kVK_DownArrow:   // down
            break;
            
        case kVK_LeftArrow:   // left
            velocity.x = -speed;
            break;
            
        case kVK_RightArrow:   // right
            velocity.x = speed;
            break;
            
        default:
            break;
    }
    return YES;    
}



- (BOOL)ccKeyUp:(NSEvent *)event
{
    unichar key = [event keyCode];
    
    switch (key)
    {
        case kVK_UpArrow:   // up
            break;
            
        case kVK_DownArrow:   // down
            break;
            
        case kVK_LeftArrow:   // left
            velocity.x = 0.0f;
            break;
            
        case kVK_RightArrow:   // right
            velocity.x = 0.0f;
            break;
            
        default:
            break;
    }
    return YES;    
}


@end
