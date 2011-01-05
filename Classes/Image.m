//
//  Image.m
//  PlantKey
//
//  Created by David J Gagnon on 1/3/11.
//  Copyright 2011 University of Wisconsin. All rights reserved.
//

#import "Image.h"


@implementation Image

@synthesize uid;
@synthesize isDefault;
@synthesize caption;
@synthesize displayPriority;
@synthesize fileName;
@synthesize image;


- (NSComparisonResult)compareDisplayPriority:(Image*)otherImage{
	return self.displayPriority < otherImage.displayPriority;
}

- (void)setFileName:(NSString*)fn{
	NSLog(@"Image.m: Setting Filename to %@",fn);
	fileName = fn;
	self.image = [UIImage imageNamed:fn];
}



@end
