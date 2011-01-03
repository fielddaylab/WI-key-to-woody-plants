//
//  Plant.h
//  PlantKey
//
//  Created by David J Gagnon on 9/30/10.
//  Copyright 2010 University of Wisconsin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Plant : NSObject {
	NSNumber*		uid;
	NSString*		scientificName;
	NSString*		commonName1;
	NSString*		commonName2;
	NSString*		commonName3;
	NSString*		nativeText;
	NSString*		habitatText;
	NSMutableArray*	images;
}

@property(nonatomic, retain) NSNumber*		uid;
@property(nonatomic, retain) NSString*		scientificName;
@property(nonatomic, retain) NSString*		commonName1;
@property(nonatomic, retain) NSString*		commonName2;
@property(nonatomic, retain) NSString*		commonName3;
@property(nonatomic, retain) NSString*		nativeText;
@property(nonatomic, retain) NSString*		habitatText;
@property(nonatomic, retain) NSMutableArray*	images;

- (NSComparisonResult)compareScientificName:(Plant*)otherPlant;
- (NSComparisonResult)compareCommonName:(Plant*)otherPlant;

@end
