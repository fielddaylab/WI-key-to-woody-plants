//
//  AppModel.m
//  PlantKey
//
//  Created by David J Gagnon on 8/2/10.
//  Copyright 2010 University of Wisconsin. All rights reserved.
//

#import "AppModel.h"
#import <sqlite3.h>


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
		
		// Query the database for all animal records and construct the "animals" array
		[self readKeyFromDatabase];
		
		
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

-(void) readKeyFromDatabase {
	NSLog(@"AppModel:readKeyFromDatabase: Begin Reading");

	// Setup the database object
	sqlite3 *database;
	
	// Init the animals Array
	keyNodes = [[NSMutableDictionary alloc] init];
	
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "select id,opt1desc,opt1keyNode,opt2desc,opt2keyNode,species,commonNames from keyNodes";

		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			NSLog(@"AppModel:readKeyFromDatabase: SQLITE_OK");
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				NSLog(@"AppModel:readKeyFromDatabase: Hydrating a KeyNode");
				// Read the data from the result row
				
				NSNumber *keyNodeId = [NSNumber numberWithInt:sqlite3_column_int(compiledStatement, 0)]; //sqlite3_column_int returns a 0 is null
				
				NSString *opt1desc;
				if(sqlite3_column_text(compiledStatement, 1) == NULL) opt1desc = nil;
				else opt1desc = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				
				NSNumber *opt1keyNodeId = [NSNumber numberWithInt:sqlite3_column_int(compiledStatement, 2)]; //sqlite3_column_int returns a 0 is null
				
				NSString *opt2desc;
				if(sqlite3_column_text(compiledStatement, 3) == NULL) opt2desc = nil;
				else opt2desc = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
				
				NSNumber *opt2keyNodeId = [NSNumber numberWithInt: sqlite3_column_int(compiledStatement, 4)]; //sqlite3_column_int returns a 0 is null
				 
				NSString *species;
				if(sqlite3_column_text(compiledStatement, 5) == NULL) species = nil;
				else species = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];	
				
				NSString *commonNames;
				if(sqlite3_column_text(compiledStatement, 6) == NULL) commonNames = nil;
				else commonNames = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)];				

				// Create a new animal object with the data from the database
				KeyNode *keyNode = [[KeyNode alloc] init];
				keyNode.keyNodeId = keyNodeId;
				keyNode.opt1Desc = opt1desc;
				keyNode.opt1KeyNodeId = opt1keyNodeId;
				keyNode.opt2Desc = opt2desc;
				keyNode.opt2KeyNodeId = opt2keyNodeId;
				keyNode.speciesName = species;
				keyNode.commonNames = commonNames;
				
				// Add the animal object to the animals Array
				[keyNodes setObject:keyNode forKey:keyNode.keyNodeId];
				
				[keyNode release];
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
	
}

- (KeyNode *)keyNodeForId: (NSNumber *)n {
	return [keyNodes objectForKey:n];
}






@end
