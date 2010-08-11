//
//  AppModel.h
//  PlantKey
//
//  Created by David J Gagnon on 8/2/10.
//  Copyright 2010 University of Wisconsin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
#import "KeyNode.h"

@interface AppModel : NSObject {
	// Database variables
	NSString *databaseName;
	NSString *databasePath;
	
	// Array to store the keyNode objects
	NSMutableDictionary *keyNodes;
	
	
}

+ (AppModel *)sharedInstance;
- (void) readKeyFromDatabase;
- (void) checkAndCreateDatabase;
- (KeyNode *)keyNodeForId: (NSNumber*)i;




@property (nonatomic, retain) NSMutableDictionary *keyNodes;



@end
