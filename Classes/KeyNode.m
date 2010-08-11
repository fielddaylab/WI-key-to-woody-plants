//
//  keyNode.m
//  PlantKey
//
//  Created by David J Gagnon on 8/10/10.
//  Copyright 2010 University of Wisconsin. All rights reserved.
//

#import "KeyNode.h"

@implementation KeyNode

@synthesize keyNodeId;
@synthesize opt1Desc;
@synthesize opt1KeyNodeId;
@synthesize opt2Desc;
@synthesize opt2KeyNodeId;
@synthesize speciesName;
@synthesize commonNames;
@synthesize description;



-(BOOL) isLeaf{
	if (self.opt1Desc == nil) return YES;
	else return FALSE;
}


@end
