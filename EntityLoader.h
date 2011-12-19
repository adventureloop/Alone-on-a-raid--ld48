//
//  EntityLoader.h
//  CH05_SLQTSOR_EXERCISE
//
//  Created by Tom Jones on 18/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpriteSheet.h"
#import "Entity.h"

@interface EntityLoader : NSObject
{
    NSMutableArray *entities;
//    SpriteSheet *sprites;
    
    int pixelWidth;
    int pixelHeight;
    
    int mapHeight;
    int mapWidth;
    
    int tileHeight;
    int tileWidth;
}

-(id)initWithSpriteSheet:(NSString *)spriteSheet mapFile:(NSString *)mapFile mapHeight:(int)aMapHeight mapWidth:(int)aMapWidth tileHeight:(int)aTileHeight tileWidth:(int)aTileWidth;
-(void)parseMapFile:(NSString *)fileName;

-(NSArray *)entities;

@property (copy,nonatomic) SpriteSheet *sprites;
@end
