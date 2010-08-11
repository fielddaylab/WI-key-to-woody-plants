//
//  KeyNodeViewController.m
//  PlantKey
//
//  Created by David J Gagnon on 8/10/10.
//  Copyright 2010 University of Wisconsin. All rights reserved.
//

#import "KeyNodeViewController.h"
#import "QuestionViewController.h";
#import "SpeciesViewController.h";

@implementation KeyNodeViewController

@synthesize keyNode;
@synthesize contentViewController;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


- (id)initWithKeyNode:(KeyNode *)k {
	 if ((self = [super initWithNibName:@"KeyNodeViewController" bundle:nil])) {
		 // Custom initialization
		 self.keyNode = k;
	 }
	 return self;
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	NSLog(@"KeyNodeViewController: Loading View with KeyNodeId: %@", self.keyNode.keyNodeId);
	
	if ([self.keyNode isLeaf]) {
		//Display a Species Details VC
		NSLog(@"KeyNodeViewController: The current KeyNode is a Species");
		self.title = self.keyNode.speciesName;
		
		contentViewController = [[SpeciesViewController alloc] initWithKeyNode:keyNode andNavigationController:self.navigationController];
		[self.view addSubview:contentViewController.view];

	}
	else {
		//Display a Key Question VC
		NSLog(@"KeyNodeViewController: The current KeyNode is a Question");
		self.title = @"Question";

		contentViewController = [[QuestionViewController alloc] initWithKeyNode:keyNode andNavigationController:self.navigationController];
		[self.view addSubview:contentViewController.view];

	}
		
    [super viewDidLoad];
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
