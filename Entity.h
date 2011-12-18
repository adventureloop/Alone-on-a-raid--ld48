//
//  Entity.h
//  CH05_SLQTSOR_EXERCISE
//
//  Created by Tom Jones on 17/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractScene.h"
#import "Image.h"
#import "Animation.h"
#import "Primitives.h"

@interface Entity : NSObject
{
    Image *image;
    
    CGPoint tileLocation;
    CGPoint pixelLocation;
    
    CGSize size;
    
    CGPoint oldLocation;
    int type;
    
    int height;
    int width;
    
    Scale2f scale;
    float rotation;
}

-(CGPoint)tileLocation;;
-(CGSize)size;


-(id)initWithTileLocation:(CGPoint )tileLoc image:(Image *)aImage type:(int)aType;
-(id)initWithTileLocation:(CGPoint)tileLoc image:(Image *)aImage type:(int)aType scale:(Scale2f)aScale rotation:(float)aRotation;
-(void)updateWithDelta:(float)aDelta scene:(Entity *)scene;
-(void)render;
-(BOOL)checkForCollisionWithEntity:(Entity *)entity;
-(CGRect)collisionBounds;

-(void)undoMove;
@end
