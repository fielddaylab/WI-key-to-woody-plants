//
//  Plant.m
//  PlantKey
//
//  Created by David J Gagnon on 9/30/10.
//  Copyright 2010 University of Wisconsin. All rights reserved.
//

#import "Plant.h"


@implementation Plant

@synthesize uid;
@synthesize scientificName;
@synthesize commonName1;
@synthesize commonName2;
@synthesize commonName3;
@synthesize nativeText;
@synthesize habitatText; 
@synthesize images;

-(id)init {
	self.images = [[NSMutableArray alloc]init];
    return self;
}

- (NSComparisonResult)compareScientificName:(Plant*)otherPlant{
	return [self.scientificName localizedCaseInsensitiveCompare:otherPlant.scientificName];
}

- (NSComparisonResult)compareCommonName:(Plant*)otherPlant{
	return [self.commonName1 localizedCaseInsensitiveCompare:otherPlant.commonName1];
}

@end
