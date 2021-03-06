//
//  KeyNodeViewController.m
//  PlantKey
//
//  Created by David J Gagnon on 8/11/10.
//  Copyright 2010 University of Wisconsin. All rights reserved.
//
//  Licensed under the MIT license: 
//  http://www.opensource.org/licenses/mit-license.php

#import "AppModel.h"
#import "PlantKeyType.h"
#import "KeyNodeViewController.h"
#import "Plant.h"
#import "PlantImageViewController.h"
#import "KeyNodeOption.h"

#define FONT_SIZE 18.0f
#define CELL_CONTENT_WIDTH 300.0f
#define CELL_CONTENT_MARGIN 10.0f


@implementation KeyNodeViewController

@synthesize keyNode;

#pragma mark -
#pragma mark View lifecycle


- (id)initWithKeyNode:(KeyNode *)k {
	if ((self = [super initWithNibName:@"KeyNodeViewController" bundle:nil])) {
		// Custom initialization
		self.keyNode = k;
		self.title = @"Identification Key";
		self.tabBarItem.image = [UIImage imageNamed:@"30-key.png"];
	}
	return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	NSLog(@"KeyNodeViewController: Loading");
	
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
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
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
    return [self.keyNode.options count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";

	UITableViewCell *cell;
	UILabel *label = nil;

	cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
        [cell setBackgroundColor:[UIColor colorWithRed:71/255.0 green:97/255.0 blue:23/255.0 alpha:1.0]];
        cell.backgroundView = nil;
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        
        
		label = [[UILabel alloc] initWithFrame:CGRectZero];
		[label setLineBreakMode:UILineBreakModeWordWrap];
		[label setMinimumFontSize:FONT_SIZE];
		[label setNumberOfLines:0];
		[label setFont:[UIFont systemFontOfSize:FONT_SIZE]];
        [label setTextColor:[UIColor whiteColor]];
		[label setTag:1];
        [label setBackgroundColor:[UIColor clearColor]];
		 	
		[[cell contentView] addSubview:label];
		
	}
	
	KeyNodeOption *o = [self.keyNode.options objectAtIndex:indexPath.row];
	NSString *text = o.text;
	CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
	CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
	
	if (!label)
		label = (UILabel*)[cell viewWithTag:1];
	
	[label setText:text];
	[label setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAX(size.height, 44.0f))];
	
	return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
	KeyNodeOption *o = [self.keyNode.options objectAtIndex:indexPath.row];

	CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
	CGSize size = [o.text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
	CGFloat height = MAX(size.height, 44.0f);
	return height + (CELL_CONTENT_MARGIN * 2);
}

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
	NSLog(@"KeyNodeViewController: didSelectRowAtIndexPath");

	
	//Retrieve the details of the selection 
	plantKeyType nextType;
	NSNumber *nextId;
	
	KeyNodeOption *o = [self.keyNode.options objectAtIndex:indexPath.row];
	
	nextType = o.type;
	nextId = o.uid;
			
	//Create an push the new view
	UIViewController *nextVc;
	
	if (nextType == kNode) {
		NSLog(@"KeyNodeViewController: Key Node specifies a Key Node");
		KeyNode *kn = [[AppModel sharedInstance] keyNodeForId:nextId];
		nextVc = [[KeyNodeViewController alloc]initWithKeyNode:kn];
				
		UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
		temporaryBarButtonItem.title = @"Back";
		self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
		[temporaryBarButtonItem release];
		 
		
		[kn release];
	}
	else if (nextType == kPlant){	
		NSLog(@"KeyNodeViewController: Key Node specifies a Plant");
		Plant *p = [[AppModel sharedInstance] plantForId:nextId];
		nextVc = [[PlantImageViewController alloc]initWithPlant:p];
		nextVc.hidesBottomBarWhenPushed = YES;
	}
	else NSLog(@"KeyNodeViewController: Shouldn't have gotten here");

	
	[self.navigationController pushViewController:nextVc animated:YES];
	[nextVc release];
	
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

