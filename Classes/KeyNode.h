//
//  KeyNode.h
//  PlantKey
//
//  Created by David J Gagnon on 8/10/10.
//  Copyright 2010 University of Wisconsin. All rights reserved.
//
//  Licensed under the MIT license: 
//  http://www.opensource.org/licenses/mit-license.php

#import <Foundation/Foundation.h>
#import "PlantKeyType.h"


@interface KeyNode : NSObject {
	NSNumber*		uid;
	NSMutableArray*	options;
}

@property(nonatomic, retain)	NSNumber*		uid;
@property(nonatomic, retain)	NSMutableArray*	options;

@end
