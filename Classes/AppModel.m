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
#import "Image.h"
#import "Term.h"
#import "KeyNodeOption.h"


@implementation AppModel

SYNTHESIZE_SINGLETON_FOR_CLASS(AppModel);
@synthesize keyNodes;
@synthesize plants;
@synthesize glossary;

-(id)init {
    if (self = [super init]) {
		//Init Model Here
		// Setup some globals
		databaseName = @"plantKey.sql";
		
		// Get the path to the documents directory and append the databaseName
		NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDir = [documentPaths objectAtIndex:0];
		databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
		
		[self checkAndCreateDatabase];		
		[self readKeyNodesFromDatabase];
		[self readPlantsFromDatabase];
		[self readGlossaryFromDatabase];
		[self readImagesFromDatabaseForPlants];

		
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
	NSLog(@"AppModel:readKeyNodesFromDatabase: Begin Reading");

	sqlite3 *database;
	if (self.keyNodes) [self.keyNodes release];
	self.keyNodes = [[NSMutableDictionary alloc] init];
	
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "select uid,opt1text,opt1id,opt1type,opt2text,opt2id,opt2type from nodes";

		sqlite3_stmt *compiledStatement;
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			//NSLog(@"AppModel:readKeyFromDatabase: SQLITE_OK");
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				//NSLog(@"AppModel:readKeyFromDatabase: Hydrating a KeyNode");
				
				KeyNode *keyNode = [[KeyNode alloc] init];

				keyNode.uid = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)] intValue]];
				
				KeyNodeOption *option1 = [[KeyNodeOption alloc]init];
				option1.text = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				option1.uid = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)] intValue]];
				if ([[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)] isEqualToString:@"n"]) option1.type = kNode;
				else option1.type = kPlant;
				[keyNode.options addObject:option1];
				[option1 release];
				
				
				KeyNodeOption *option2 = [[KeyNodeOption alloc]init];
				option2.text = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
				option2.uid = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)] intValue]];
				if ([[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)] isEqualToString:@"n"]) option2.type = kNode;
				else option2.type = kPlant;
				[keyNode.options addObject:option2];
				[option2 release];				
				
				// Add the node to the keyNode array
				[self.keyNodes setObject:keyNode forKey:keyNode.uid];
				[keyNode release];
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
	}
	sqlite3_close(database);
	NSLog(@"AppModel:readKeyNodesFromDatabase: Reading Complete");
}

-(void) readPlantsFromDatabase {
	NSLog(@"AppModel:readPlantsFromDatabase: Begin Reading");
	
	sqlite3 *database;
	if (self.plants) [self.plants release];
	self.plants = [[NSMutableDictionary alloc] init];
	
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "select uid,scientificName,commonName1,commonName2,commonName3,nativeText,habitatText from plants";
		
		sqlite3_stmt *compiledStatement;
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			//NSLog(@"AppModel:readPlantsFromDatabase: SQLITE_OK");
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				//NSLog(@"AppModel:readPlantsFromDatabase: Hydrating a Plant");
				
				Plant *plant = [[Plant alloc] init];
				plant.uid = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)] intValue]];
				plant.scientificName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				plant.commonName1 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
				plant.commonName2 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
				plant.commonName3 = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
				plant.nativeText = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];
				plant.habitatText = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)];
														
				// Add the plant to the Plants array
				[self.plants setObject:plant forKey:plant.uid];
				[plant release];
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
	}
	sqlite3_close(database);
	NSLog(@"AppModel:readPlantsFromDatabase: Reading Complete");
}

-(void) readImagesFromDatabaseForPlants {
	NSLog(@"AppModel:readImagesFromDatabaseForPlants: Begin Reading");
	
	sqlite3 *database;
	
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "select uid,caption,displayPriority,fileName,thing_uid from images where thing_type = 'p'";		

		sqlite3_stmt *compiledStatement;
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			//NSLog(@"AppModel:readImagesFromDatabaseForPlant: SQLITE_OK");
			// Loop through the results and add them to the plant
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				//NSLog(@"AppModel:readImagesFromDatabaseForPlant: Hydrating an Image");
				
				
				Image *image = [[Image alloc] init];
				image.uid = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)] intValue]];
				image.caption = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				image.displayPriority = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
				NSString *filename = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
				image.fileName = [NSString stringWithFormat:@"%@.jpg", filename]; //Add the extension  
				
				NSNumber *plantId = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)] intValue]];

				// Add the image to the Plant's image array
				Plant *plant = [self.plants objectForKey:plantId];
				if (plant) {
					//NSLog(@"AppModel:readImagesFromDatabaseForPlant: adding image to plant %@", plant.uid);
					[plant.images addObject:image];
				}
				else NSLog(@"AppModel:readImagesFromDatabaseForPlant: Bad Plant uid in Image uid %@",image.uid );
				[image release];
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
	}
	sqlite3_close(database);
	NSLog(@"AppModel:readImagesFromDatabaseForPlant: Reading Complete");
}

-(void) readGlossaryFromDatabase {
	NSLog(@"AppModel:readGlossaryFromDatabase: Begin Reading");
	
	sqlite3 *database;
	if (self.glossary) [self.glossary release];
	self.glossary = [[NSMutableDictionary alloc] init];
	
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "select uid,word,definition from glossary";
		
		sqlite3_stmt *compiledStatement;
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			//NSLog(@"AppModel:readKeyFromDatabase: SQLITE_OK");
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				//NSLog(@"AppModel:readKeyFromDatabase: Hydrating a Term");
				
				Term *term = [[Term alloc] init];
				term.uid = [NSNumber numberWithInt:[[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)] intValue]];
				term.word = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				term.definition = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
							
								
				// Add the node to the array
				[self.glossary setObject:term forKey:term.uid];
				[term release];
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
	}
	sqlite3_close(database);
	NSLog(@"AppModel:readGlossaryFromDatabase: Reading Complete");
}



- (KeyNode *)keyNodeForId: (NSNumber *)i {
	KeyNode* kn = [self.keyNodes objectForKey:i];
	return kn;
}


- (Plant*)plantForId:(NSNumber *)i {
	return [self.plants objectForKey:i];	
}

- (Term*)termForId:(NSNumber *)i {
	return [self.glossary objectForKey:i];	
}






@end
