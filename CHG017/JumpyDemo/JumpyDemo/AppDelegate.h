//
//  AppDelegate.h
//  JumpyDemo
//
//  Created by Martin Höller on 01.07.12.
//  Copyright BytePoets GmbH 2012. All rights reserved.
//

#import "cocos2d.h"

@interface JumpyDemoAppDelegate : NSObject <NSApplicationDelegate>
{
	NSWindow	*window_;
	CCGLView	*glView_;
}

@property (assign) IBOutlet NSWindow	*window;
@property (assign) IBOutlet CCGLView	*glView;

- (IBAction)toggleFullScreen:(id)sender;

@end
