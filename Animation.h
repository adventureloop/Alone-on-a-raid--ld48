//
//  Animation.h
//  CH05_SLQTSOR_EXERCISE
//
//  Created by Tom Jones on 18/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpriteSheet.h"
#import "Image.h"
@interface Animation : NSObject
{
    int direction;
    int state;
    
    NSMutableDictionary *frameDict;
    NSMutableArray *frames;
    
    SpriteSheet *sprites;
}

-(id)initWithSpriteSheet:(SpriteSheet *)aSheet;

-(void)addFrameForKey:(NSString *)key andIndex:(int)index;
-(Image *)frameForKey:(NSString *)key;
@end
