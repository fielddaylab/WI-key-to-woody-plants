//
//  GlossaryListViewController.m
//  PlantKey
//
//  Created by David J Gagnon on 1/5/11.
//  Copyright 2011 University of Wisconsin. All rights reserved.
//

#import "GlossaryListViewController.h"
#import "AppModel.h"
#import "Term.h"

@implementation GlossaryListViewController

@synthesize indexes;
@synthesize filteredIndexes;

#pragma mark -
#pragma mark View lifecycle


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.title = @"Glossary";
		self.tabBarItem.image = [UIImage imageNamed:@"96-book.png"];

		[self refreshIndexes];
		self.filteredIndexes = [NSMutableArray arrayWithCapacity:[self.indexes count]];
    }
    return self;
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	/*
     If the requesting table view is the search display controller's table view, return the count of
     the filtered list, otherwise return the count of the main list.
     */
    if (tableView == self.searchDisplayController.searchResultsTableView)
		return [self.filteredIndexes count];
    else return [self.indexes count];
    
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell;
	cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	}

	NSNumber *uid;
	if (tableView == self.searchDisplayController.searchResultsTableView) 
		uid = [self.filteredIndexes objectAtIndex:indexPath.row];
    else uid = [self.indexes objectAtIndex:indexPath.row];


	Term *t = [[AppModel sharedInstance] termForId:uid];
	
	cell.textLabel.text = t.word;
	cell.detailTextLabel.text = t.definition;
	
	
	
	return cell;
}

/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{

}
*/

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 
 
 
 /*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSLog(@"GlossaryViewController: didSelectRowAtIndexPath");
}



#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText{
	[self.filteredIndexes removeAllObjects]; // First clear the filtered array.
	
	for (NSNumber *uid in self.indexes) {
		Term *t = [[AppModel sharedInstance] termForId:uid];
		if ([[t.word lowercaseString] rangeOfString:[searchText lowercaseString]].location != NSNotFound) [self.filteredIndexes addObject:uid]; 
	}
	NSLog(@"filting Complete");
}




#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


#pragma mark -
#pragma mark Sorting
-(IBAction) sortingSelectorValueChanged: (id) sender {
	[self refreshIndexes];
	[myTableView reloadData];
}

- (void)refreshIndexes {
	NSLog(@"PlantListVC: Refresh Indexes");
	self.indexes = [[[AppModel sharedInstance] glossary] keysSortedByValueUsingSelector:@selector(compareWord:)];
}

#pragma mark -
#pragma mark Memory management



- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
