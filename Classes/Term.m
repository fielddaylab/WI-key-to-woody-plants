//
//  Term.m
//  PlantKey
//
//  Created by David J Gagnon on 1/5/11.
//  Copyright 2011 University of Wisconsin. All rights reserved.
//
//  Licensed under the MIT license: 
//  http://www.opensource.org/licenses/mit-license.php

#import "Term.h"


@implementation Term

@synthesize uid;
@synthesize word;
@synthesize definition;

- (NSComparisonResult)compareWord:(Term*)otherTerm{
	return [self.word localizedCaseInsensitiveCompare:otherTerm.word];
}

@end
