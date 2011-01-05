//
//  Term.h
//  PlantKey
//
//  Created by David J Gagnon on 1/5/11.
//  Copyright 2011 University of Wisconsin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Term : NSObject {
	NSNumber*		uid;
	NSString*		word;
	NSString*		definition;

}

@property(nonatomic, retain) NSNumber*		uid;
@property(nonatomic, retain) NSString*		word;
@property(nonatomic, retain) NSString*		definition;

- (NSComparisonResult)compareWord:(Term*)otherTerm;


@end
