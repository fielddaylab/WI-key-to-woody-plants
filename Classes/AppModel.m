//
//  AppModel.m
//  PlantKey
//
//  Created by David J Gagnon on 8/2/10.
//  Copyright 2010 University of Wisconsin. All rights reserved.
//

#import "AppModel.h"
#import <sqlite3.h>
#import "PlantKeyType.h"


@implementation AppModel

SYNTHESIZE_SINGLETON_FOR_CLASS(AppModel);
@synthesize keyNodes;

-(id)init {
    if (self = [super init]) {
		//Init Model Here
		// Setup some globals
		databaseName = @"plantKey.sql";
		
		// Get the path to the documents directory and append the databaseName
		NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDir = [documentPaths objectAtIndex:0];
		databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
		
		// Execute the "checkAndCreateDatabase" function
		[self checkAndCreateDatabase];
		
		[self readKeyNodesFromDatabase];
		
		
		NSLog(@"AppModel Inited");
	}
	
    return self;
}


-(void) checkAndCreateDatabase{
	// Check if the SQL database has already been saved to the users phone, if not then copy it over
	BOOL success;
	
	// Create a FileManager object, we will use this to check the status
	// of the database and to copy it over if required
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	// Check if the database has already been created in the users filesystem
	success = [fileManager fileExistsAtPath:databasePath];
	
	// If the database already exists then return without doing anything
	if(success) return;
	
	// If not then proceed to copy the database from the application to the users filesystem
	
	// Get the path to the database in the application package
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
	
	// Copy the database from the package to the users filesystem
	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
	
	[fileManager release];
}

-(void) readKeyNodesFromDatabase {
	NSLog(@"AppModel:readKeyFromDatabase: Begin Reading");

	// Setup the database object
	sqlite3 *database;
	
	// Init the animals Array
	keyNodes = [[NSMutableDictionary alloc] init];
	
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "select uid,opt1text,opt1id,opt1type,opt2text,opt2id,opt2type from nodes";

		sqlite3_stmt *compiledStatement;
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			NSLog(@"AppModel:readKeyFromDatabase: SQLITE_OK");
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				NSLog(@"AppModel:readKeyFromDatabase: Hydrating a KeyNode");
				// Read the data from the result row
				
				NSNumber *uid = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)] intValue]];
				NSString *opt1text = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				NSNumber *opt1id = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)] intValue]];
				
				plantKeyType opt1type;
				if ([[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)] isEqualToString:@"n"]) opt1type = kNode;
				else opt1type = kPlant;
				
				NSString *opt2text = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
				NSNumber *opt2id = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)] intValue]];
				
				plantKeyType opt2type;
				if ([[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)] isEqualToString:@"n"]) opt2type = kNode;
				else opt2type = kPlant;
				
				
				// Create a new animal object with the data from the database
				KeyNode *keyNode = [[KeyNode alloc] init];
				keyNode.uid = uid;
				keyNode.opt1text = opt1text;
				keyNode.opt1id = opt1id;
				keyNode.opt1type = opt1type;
				keyNode.opt2text = opt2text;
				keyNode.opt2id = opt2id;
				keyNode.opt2type = opt2type;
				
				// Add the node to the keyNode array
				[keyNodes setObject:keyNode forKey:keyNode.uid];
				
				[keyNode release];
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
	NSLog(@"AppModel:readKeyNodesFromDatabase: Reading Complete");

	
}

- (KeyNode *)keyNodeForId: (NSNumber *)n {
	return [keyNodes objectForKey:n];
}






@end
