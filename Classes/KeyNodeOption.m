//
//  KeyNodeOption.m
//  PlantKey
//
//  Created by David J Gagnon on 1/6/11.
//  Copyright 2011 University of Wisconsin. All rights reserved.
//

#import "KeyNodeOption.h"


@implementation KeyNodeOption

@synthesize		uid;
@synthesize		type;
@synthesize		text;

- (id)initWithUid:(NSNumber*)aUid Type:(plantKeyType)aType andText:(NSString*)aText {
	if ((self = [super init])) {
		// Custom initialization
		self.uid = aUid;
		self.type = aType;
		self.text = aText;
	}
	return self;
}

@end
