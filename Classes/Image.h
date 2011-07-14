//
//  Image.h
//  PlantKey
//
//  Created by David J Gagnon on 1/3/11.
//  Copyright 2011 University of Wisconsin. All rights reserved.
//
//  Licensed under the MIT license: 
//  http://www.opensource.org/licenses/mit-license.php

#import <Foundation/Foundation.h>


@interface Image : NSObject {
	NSNumber*		uid;
	BOOL			isDefault;
	NSString*		caption;
	NSNumber*		displayPriority;
	NSString*		fileName;
	UIImage*		image;
}


@property(nonatomic, retain) NSNumber*		uid;
@property(nonatomic, retain) NSString*		caption;
@property(nonatomic, retain) NSNumber*		displayPriority;
@property(nonatomic, retain) NSString*		fileName;
@property(nonatomic, retain) UIImage*		image;

- (NSComparisonResult)compareDisplayPriority:(Image*)otherImage;

//When filename is set, calculate and store a UIImage
- (void)setFileName:(NSString*)fn;

@end
