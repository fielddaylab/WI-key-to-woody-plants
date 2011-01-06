//
//  RootMenuViewController.m
//  PlantKey
//
//  Created by David J Gagnon on 1/6/11.
//  Copyright 2011 University of Wisconsin. All rights reserved.
//

#import "RootMenuViewController.h"

#import "AppModel.h"
#import "KeyNodeViewController.h"
#import "PlantListViewController.h"
#import "GlossaryListViewController.h"

@implementation RootMenuViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Plant Key";

	[treeButton addTarget:self action:@selector(treeButtonAction) forControlEvents:UIControlEventTouchUpInside];
	[shrubButton addTarget:self action:@selector(shrubButtonAction) forControlEvents:UIControlEventTouchUpInside];
	[glossaryButton addTarget:self action:@selector(glossaryButtonAction) forControlEvents:UIControlEventTouchUpInside];
	[plantListButton addTarget:self action:@selector(plantListButtonAction) forControlEvents:UIControlEventTouchUpInside];

}

-(void) treeButtonAction {
	KeyNodeViewController *vc = [[KeyNodeViewController alloc]initWithKeyNode:[[AppModel sharedInstance] keyNodeForId:[NSNumber numberWithInt:1]]];
	[vc.navigationItem setHidesBackButton:YES];
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];
}
-(void) shrubButtonAction {
	KeyNodeViewController *vc = [[KeyNodeViewController alloc]initWithKeyNode:[[AppModel sharedInstance] keyNodeForId:[NSNumber numberWithInt:1]]];
	[vc.navigationItem setHidesBackButton:YES];
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];
}
-(void) glossaryButtonAction {
	GlossaryListViewController *vc = [[GlossaryListViewController alloc]initWithNibName:@"GlossaryListViewController" bundle:nil];
	[vc.navigationItem setHidesBackButton:YES];
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];
}
-(void) plantListButtonAction {
	PlantListViewController *vc = [[PlantListViewController alloc]initWithNibName:@"PlantListViewController" bundle:nil];
	[vc.navigationItem setHidesBackButton:YES];
	[self.navigationController pushViewController:vc animated:YES];
	[vc release];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
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
