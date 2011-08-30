//
//  PlantListViewController.m
//  PlantKey
//
//  Created by David J Gagnon on 9/30/10.
//  Copyright 2010 University of Wisconsin. All rights reserved.
//
//  Licensed under the MIT license: 
//  http://www.opensource.org/licenses/mit-license.php

#import "PlantListViewController.h"
#import "AppModel.h"
#import "PlantImageViewController.h"

@implementation PlantListViewController

@synthesize plantIndexes;
@synthesize filteredPlantIndexes;

#pragma mark -
#pragma mark View lifecycle


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.title = @"Species List";
		self.tabBarItem.image = [UIImage imageNamed:@"189-plant.png"];

		[self refreshPlantIndexes];
		self.filteredPlantIndexes = [NSMutableArray arrayWithCapacity:[self.plantIndexes count]];
    }
    return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//Setup the Home Button
	UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Home" 
															   style:UIBarButtonItemStylePlain 
															  target:self 
															  action:@selector(home)];
	button.image = [UIImage imageNamed:@"53-house.png"];
	
	self.navigationItem.rightBarButtonItem = button;
	[button release];
	
}

- (void)home{
	NSLog(@"KeyNodeViewController: Home Requested");
	[self.navigationController popToRootViewControllerAnimated:YES];
}

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
		return [self.filteredPlantIndexes count];
    else return [self.plantIndexes count];
    
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell;
	cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        
        [cell setBackgroundColor:[UIColor colorWithRed:71/255.0 green:97/255.0 blue:23/255.0 alpha:1.0]];
        cell.backgroundView = nil;
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.7];
        
	}


    
	NSNumber *plantId;
	if (tableView == self.searchDisplayController.searchResultsTableView) 
		plantId = [self.filteredPlantIndexes objectAtIndex:indexPath.row];
    else plantId = [self.plantIndexes objectAtIndex:indexPath.row];


	Plant *p = [[AppModel sharedInstance] plantForId:plantId];
	
	switch (sortFieldSegmentedControl.selectedSegmentIndex) {
		case 0:
			cell.textLabel.text = p.scientificName;
			cell.detailTextLabel.text = p.commonName;			
			break;
		case 1:
			cell.textLabel.text = p.commonName;
			cell.detailTextLabel.text = p.scientificName;
			break;
		default:
			break;
	}
	
	
	
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
	NSLog(@"PlantListViewController: didSelectRowAtIndexPath");
		
	NSNumber *plantId;
	
	if (tableView == self.searchDisplayController.searchResultsTableView) 
		plantId = [self.filteredPlantIndexes objectAtIndex:indexPath.row];
    else plantId = [self.plantIndexes objectAtIndex:indexPath.row];

	Plant *p = [[AppModel sharedInstance] plantForId:plantId];
	PlantImageViewController *vc = [[PlantImageViewController alloc]initWithPlant:p];
	vc.hidesBottomBarWhenPushed = YES;
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];
}



#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText{
	[self.filteredPlantIndexes removeAllObjects]; // First clear the filtered array.
	
	for (NSNumber *plantId in self.plantIndexes) {
		Plant *p = [[AppModel sharedInstance] plantForId:plantId];
		if ([[p.scientificName lowercaseString] rangeOfString:[searchText lowercaseString]].location != NSNotFound) [self.filteredPlantIndexes addObject:plantId]; 
		if ([[p.commonName lowercaseString] rangeOfString:[searchText lowercaseString]].location != NSNotFound) [self.filteredPlantIndexes addObject:plantId]; 
		if ([[p.commonNames lowercaseString] rangeOfString:[searchText lowercaseString]].location != NSNotFound) [self.filteredPlantIndexes addObject:plantId]; 
		
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
	[self refreshPlantIndexes];
	[myTableView reloadData];
}

- (void)refreshPlantIndexes {
	NSLog(@"PlantListVC: Refresh Indexes");
	switch (sortFieldSegmentedControl.selectedSegmentIndex) {
		case 0:
			self.plantIndexes = [[[AppModel sharedInstance] plants] keysSortedByValueUsingSelector:@selector(compareScientificName:)];
			break;
		case 1:
			self.plantIndexes = [[[AppModel sharedInstance] plants] keysSortedByValueUsingSelector:@selector(compareCommonName:)];
			break;
		default:
			break;
	}
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
