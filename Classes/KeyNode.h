//
//  KeyNode.h
//  PlantKey
//
//  Created by David J Gagnon on 8/10/10.
//  Copyright 2010 University of Wisconsin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface KeyNode : NSObject {
	NSNumber	*keyNodeId;
	
	//Link related
	NSString	*opt1Desc;
	NSNumber	*opt1KeyNodeID;
	NSString	*opt2Desc;
	NSNumber	*opt2KeyNodeId;
	
	//Species Related
	NSString	*speciesName;
	NSString	*commonNames;	
	NSString	*description;
}

@property(nonatomic, retain) NSNumber	*keyNodeId;
@property(nonatomic, retain) NSString	*opt1Desc;
@property(nonatomic, retain) NSNumber	*opt1KeyNodeId;
@property(nonatomic, retain) NSString	*opt2Desc;
@property(nonatomic, retain) NSNumber	*opt2KeyNodeId;
@property(nonatomic, retain) NSString	*speciesName;
@property(nonatomic, retain) NSString	*commonNames;	
@property(nonatomic, retain) NSString	*description;	


-(BOOL) isLeaf;


@end
