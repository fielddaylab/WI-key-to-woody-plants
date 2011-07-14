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
#import "KeyNode.h"
#import "KeyNodeOption.h"
#import "AppInfoViewController.h"

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
	
	self.title = @"Key to WI Woody Plants";

	[keyButton addTarget:self action:@selector(keyButtonAction) forControlEvents:UIControlEventTouchUpInside];
	[keyToKeysButton addTarget:self action:@selector(keyToKeysButtonAction) forControlEvents:UIControlEventTouchUpInside];
	[glossaryButton addTarget:self action:@selector(glossaryButtonAction) forControlEvents:UIControlEventTouchUpInside];
	[plantListButton addTarget:self action:@selector(plantListButtonAction) forControlEvents:UIControlEventTouchUpInside];
	[infoButton addTarget:self action:@selector(infoButtonAction) forControlEvents:UIControlEventTouchUpInside];

}

-(void) keyButtonAction {
	KeyNode *kn = [[AppModel sharedInstance] keyNodeForId:[NSNumber numberWithInt: 1111]];

	KeyNodeViewController *vc = [[KeyNodeViewController alloc]initWithKeyNode:kn];
	[vc.navigationItem setHidesBackButton:YES];
	[self.navigationController pushViewController:vc animated:YES];
	[kn release];
	[vc release];
}
-(void) keyToKeysButtonAction {
	
	KeyNode *kn = [[KeyNode alloc]init];
	[kn.options addObject: [[[KeyNodeOption alloc]initWithUid:[NSNumber numberWithInt: 1] Type:kNode andText:@"Conifers"]autorelease]];
	[kn.options addObject: [[[KeyNodeOption alloc]initWithUid:[NSNumber numberWithInt: 21] Type:kNode andText:@"Trees With Alternate Simple Leaves"]autorelease]];
	[kn.options addObject: [[[KeyNodeOption alloc]initWithUid:[NSNumber numberWithInt: 34] Type:kNode andText:@"Trees With Alternate Compound Leaves"]autorelease]];
	[kn.options addObject: [[[KeyNodeOption alloc]initWithUid:[NSNumber numberWithInt: 79] Type:kNode andText:@"Trees With Opposite Leaves"]autorelease]];
	//[kn.options addObject: [[[KeyNodeOption alloc]initWithUid:[NSNumber numberWithInt: 1] Type:kNode andText:@"Shrubs or Vines"]autorelease]];
	
	
	KeyNodeViewController *vc = [[KeyNodeViewController alloc]initWithKeyNode:kn];[vc.navigationItem setHidesBackButton:YES];
	[self.navigationController pushViewController:vc animated:YES];
	[kn release];
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
-(void) infoButtonAction {
	AppInfoViewController *vc = [[AppInfoViewController alloc]initWithNibName:@"AppInfoViewController" bundle:nil];
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
