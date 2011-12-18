//
//  EnemyEntity.h
//  CH05_SLQTSOR_EXERCISE
//
//  Created by Tom Jones on 17/12/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayerEntity.h"

@interface EnemyEntity : PlayerEntity
-(void)updateWithDelta:(float)aDelta player:(Entity *)player;
-(void)attackPlayer:(Entity *)player;

@property (assign) float health;
@end
