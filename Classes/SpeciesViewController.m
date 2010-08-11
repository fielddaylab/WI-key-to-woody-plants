//
//  SpeciesViewController.m
//  PlantKey
//
//  Created by David J Gagnon on 8/11/10.
//  Copyright 2010 University of Wisconsin. All rights reserved.
//

#import "SpeciesViewController.h"


NSString *const kSpeciesDescriptionHtmlTemplate = 
@"<html>"
@"<head>"
@"	<title>Plant KEy</title>"
@"	<style type='text/css'><!--"
@"	body {"
@"		background-color: #FFFFFF;"
@"		color: #000000;"
@"		font-size: 17px;"
@"		font-family: Helvetia, Sans-Serif;"
@"	}"
@"	--></style>"
@"</head>"
@"<body>%@</body>"
@"</html>";



@implementation SpeciesViewController

@synthesize keyNode;
@synthesize navigationController;
@synthesize imageView;
@synthesize webView;


- (id)initWithKeyNode:(KeyNode *)k andNavigationController:(UINavigationController *)n {
	if ((self = [super initWithNibName:@"SpeciesViewController" bundle:nil])) {
		// Custom initialization
		self.keyNode = k;
		self.navigationController = n;		
	}
	return self;
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSString *imageName = [NSString stringWithFormat:@"%@.png",self.keyNode.keyNodeId];
	imageView.image = [UIImage imageNamed:imageName];
	
	NSString *cssDescription = [NSString stringWithFormat:kSpeciesDescriptionHtmlTemplate, self.keyNode.description];
	[webView loadHTMLString:cssDescription baseURL:nil];
	
	NSLog(@"SpeciesViewController: view loaded");
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
