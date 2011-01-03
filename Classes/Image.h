//
//  Image.h
//  PlantKey
//
//  Created by David J Gagnon on 1/3/11.
//  Copyright 2011 University of Wisconsin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Image : NSObject {
	NSNumber*		uid;
	BOOL			isDefault;
	NSString*		caption;
	NSNumber*		displayPriority;
	NSString*		fileName;
}


@property(nonatomic, retain) NSNumber*		uid;
@property(nonatomic) BOOL					isDefault;
@property(nonatomic, retain) NSString*		caption;
@property(nonatomic, retain) NSNumber*		displayPriority;
@property(nonatomic, retain) NSString*		fileName;

- (NSComparisonResult)compareDisplayPriority:(Image*)otherImage;

@end
