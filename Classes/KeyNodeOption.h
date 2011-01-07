//
//  KeyNodeOption.h
//  PlantKey
//
//  Created by David J Gagnon on 1/6/11.
//  Copyright 2011 University of Wisconsin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlantKeyType.h"


@interface KeyNodeOption : NSObject {
	NSNumber*		uid;
	plantKeyType	type;
	NSString*		text;
}

@property(nonatomic, retain)	NSNumber*		uid;
@property(nonatomic)			plantKeyType	type;
@property(nonatomic, retain)	NSString*		text;

- (id)initWithUid:(NSNumber*)aUid Type:(plantKeyType)aType andText:(NSString*)aText;

@end
