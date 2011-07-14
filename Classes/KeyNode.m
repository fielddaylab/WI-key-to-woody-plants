//
//  keyNode.m
//  PlantKey
//
//  Created by David J Gagnon on 8/10/10.
//  Copyright 2010 University of Wisconsin. All rights reserved.
//
//  Licensed under the MIT license: 
//  http://www.opensource.org/licenses/mit-license.php

#import "KeyNode.h"

@implementation KeyNode

@synthesize		uid;
@synthesize		options;

- (id)init {
	if ((self = [super init])) {
		// Custom initialization
		self.options = [[NSMutableArray alloc]init];
	}
	return self;
}

@end
