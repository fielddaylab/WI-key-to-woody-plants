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
#import "Plant.h"
#import "Term.h"

@interface AppModel : NSObject {
	// Database variables
	NSString *databaseName;
	NSString *databasePath;
	
	NSMutableDictionary *keyNodes;
	NSMutableDictionary *plants;
	NSMutableDictionary *glossary;

	
	
}

+ (AppModel *)sharedInstance;
- (void) readKeyNodesFromDatabase;
- (void) readPlantsFromDatabase;
- (void) readGlossaryFromDatabase;

- (void) checkAndCreateDatabase;
- (KeyNode *)keyNodeForId: (NSNumber*)i;
- (Plant *)plantForId: (NSNumber*)i;
- (Term *)termForId: (NSNumber*)i;


@property (nonatomic, retain) NSMutableDictionary *keyNodes;
@property (nonatomic, retain) NSMutableDictionary *plants;
@property (nonatomic, retain) NSMutableDictionary *glossary;



@end
