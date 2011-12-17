//
//  TileSet.h
//  CH05_SLQTSOR_EXERCISE
//
//  Created by Tom Jones on 17/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TextureManager.h"
#import "SpriteSheet.h"

@interface TileSet : NSObject
{
    NSString *name;
    int firstGlobalID;
    int lastGlobalID;
    int tileWidth;
    int tileHeight;
    int spacing;
    int margin;
    int tileSetID;
    
    int horizontalTiles;
    int verticalTiles;
    
    TextureManager *sharedTextureManager;
    SpriteSheet *tiles;
}

-(id)initWithImagedNamed:(NSString *)aImageFileName name:(NSString *)aName tileSetID:(int)aTileSetID firstGID:(int)afirstGID tileSize:(CGSize )aSize spacing:(int)aSpacing margin:(int)aMargin;
- (BOOL)containsGlobalID:(int)aGlobalID;
- (int)getTileX:(int)aTileID;
- (int)getTileY:(int)aTileID;
@end
