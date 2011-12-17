//
//  Layer.h
//  CH05_SLQTSOR_EXERCISE
//
//  Created by Tom Jones on 17/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Structures.h"

#define kTile_Width 32
#define kTile_Height 32

@interface Layer : NSObject
{
    TexturedColoredQuad *tileImages;
    int layerData [kTile_Width][kTile_Height][4];
}

@property (assign,nonatomic) NSInteger layerID;
@property (retain,nonatomic) NSString *name;
@property (assign,nonatomic) NSInteger width;
@property (assign,nonatomic) NSInteger height;

-(id)initWithName:(NSString *)aName layerID:(int)aLayerID layerWidth:(int)aLayerWidth layerHeight:(int)aLayerHeight;
-(void)addTileAt:(CGPoint)aTileCoord tileSetID:(int)aTileSetID tileID:(int)aTileID globalID:(int)aGlobalID value:(int)aValue;
-(void)addTileImageAt:(CGPoint) aPoint imageDetails:(ImageDetails *)aImageDetails;

-(int)globalTileIDAtTile:(CGPoint)aTileCoord;
-(void)setValueAtTile:(CGPoint)aTileCoord value:(int)aValue;
-(TexturedColoredQuad *)titleImageAt:(CGPoint)aPoint;
@end
