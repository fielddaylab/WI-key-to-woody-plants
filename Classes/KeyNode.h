//
//  KeyNode.h
//  PlantKey
//
//  Created by David J Gagnon on 8/10/10.
//  Copyright 2010 University of Wisconsin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlantKeyType.h"


@interface KeyNode : NSObject {
	NSNumber*		uid;
	NSString*		opt1text;
	NSNumber*		opt1id;
	plantKeyType	opt1type;
	NSString*		opt2text;
	NSNumber*		opt2id;
	plantKeyType	opt2type;
}

@property(nonatomic, retain) NSNumber*		uid;
@property(nonatomic, retain) NSString*		opt1text;
@property(nonatomic, retain) NSNumber*		opt1id;
@property(nonatomic) plantKeyType	opt1type;
@property(nonatomic, retain) NSString*		opt2text;
@property(nonatomic, retain) NSNumber*		opt2id;
@property(nonatomic) plantKeyType	opt2type;


@end
