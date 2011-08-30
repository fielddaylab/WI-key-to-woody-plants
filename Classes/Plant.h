//
//  Plant.h
//  PlantKey
//
//  Created by David J Gagnon on 9/30/10.
//  Copyright 2010 University of Wisconsin. All rights reserved.
//
//  Licensed under the MIT license: 
//  http://www.opensource.org/licenses/mit-license.php

#import <Foundation/Foundation.h>


@interface Plant : NSObject {
    NSNumber*		uid;
    NSString*		scientificName;
    NSString*		commonName;
    NSString*		commonNames;
    NSString*		family;
    NSString*		nativeText;
    NSString*		habitatText;
    NSString*		uses;
    NSString*		credits;
	NSMutableArray*	images;
}

@property(nonatomic, retain) NSNumber*		uid;
@property(nonatomic, retain) NSString*		scientificName;
@property(nonatomic, retain) NSString*		commonName;
@property(nonatomic, retain) NSString*		commonNames;
@property(nonatomic, retain) NSString*		family;
@property(nonatomic, retain) NSString*		nativeText;
@property(nonatomic, retain) NSString*		habitatText;
@property(nonatomic, retain) NSString*		uses;
@property(nonatomic, retain) NSString*		credits;
@property(nonatomic, retain) NSMutableArray*	images;

- (NSComparisonResult)compareScientificName:(Plant*)otherPlant;
- (NSComparisonResult)compareCommonName:(Plant*)otherPlant;

@end
