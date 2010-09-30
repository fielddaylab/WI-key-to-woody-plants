//
//  PlantViewController.m
//  PlantKey
//
//  Created by David J Gagnon on 9/30/10.
//  Copyright 2010 University of Wisconsin. All rights reserved.
//

#import "PlantViewController.h"


@implementation PlantViewController
@synthesize plant;

- (id)initWithPlant:(Plant *)p {
	if ((self = [super initWithNibName:@"PlantViewController" bundle:nil])) {
		// Custom initialization
		self.plant = p;
		self.title = @"Plant Details";
	}
	return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	NSLog(@"PlantViewController: Loading Plant: %@",self.plant.uid);
	self.title = self.plant.scientificName;
	nativeTextView.text = self.plant.nativeText;
	commonNamesTextView.text = self.plant.commonName1;
	habitatTextView.text = self.plant.habitatText;
	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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
