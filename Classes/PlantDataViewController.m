//
//  PlantDataViewController.m
//  PlantKey
//
//  Created by David J Gagnon on 9/30/10.
//  Copyright 2010 University of Wisconsin. All rights reserved.
//
//  Licensed under the MIT license: 
//  http://www.opensource.org/licenses/mit-license.php

#import "PlantDataViewController.h"

NSString *const kHtmlTemplate = 
@"<html>"
@"<head>"
@"<meta name='viewport' content='width=100; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;'/>"
@"	<style type='text/css'>"
@"	body {"
@"		background-color: transparent;"
@"		color: #FFFFFF;"
@"		font-size: 17px;"
@"		font-family: Helvetia, Sans-Serif;"
@"      word-wrap: break-word;"
@"	}"
@"	h1 {"
@"		color: #CCCCCC;"
@"		font-size: 18px;"
@"		font-style: bold;"
@"		font-family: Helvetia, Sans-Serif;"
@"		margin: 0 0 10 0;"
@"	}"
@"  td {"
@"      vertical-align:top;"
@"      padding:10px 15px 10px 10px;"
@"      word-wrap: break-word;"
@"  }"
@"  div {"
@"  width: 180px;"
@"  }"
@"  .break-word {"
@"      word-wrap: break-word;"
@"  }"
@"	</style>"
@"</head>"
@"<body>"
@"<table width = '100%' >"
@"<tr><td><h1>Scientific Name</h1></td><td>%@</td></tr>"
@"<tr><td><h1>Common Name(s)</h1></td><td>%@</td></tr>"
@"<tr><td><h1>Native To</h1></td><td>%@</td></tr>"
@"<tr><td><h1>Habitat</h1></td><td>%@</td></tr>"
@"<tr><td><h1>Uses</td></h1><td>%@</td></tr>"
@"<tr><td><h1>Photo Credits</h1></td><td><div class=break-word'>%@</div></td></tr>"
@"</table>"
@"</body>"
@"</html>";




@implementation PlantDataViewController
@synthesize plant;
@synthesize webView;

- (id)initWithPlant:(Plant *)p {
	if ((self = [super initWithNibName:@"PlantDataViewController" bundle:nil])) {
		// Custom initialization
		self.plant = p;
	}
	return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	NSLog(@"PlantDataViewController: Loading Plant: %@",self.plant.uid);
    
	self.title = self.plant.scientificName;

    NSString *commonName;
    if ([self.plant.commonNames length] == 0 ) commonName=self.plant.commonName;
    else commonName=self.plant.commonNames;
    
    NSString *htmlDescription = [NSString stringWithFormat:kHtmlTemplate, self.plant.scientificName, commonName, self.plant.nativeText, self.plant.habitatText, self.plant.uses, self.plant.credits];
	[webView loadHTMLString:htmlDescription baseURL:nil];
    NSLog(@"HTML = %@", htmlDescription);
    [webView setBackgroundColor:[UIColor clearColor]];
    [webView setScalesPageToFit:YES];
    NSLog(@"Loading: %@",webView);
    
	self.hidesBottomBarWhenPushed = YES;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_key.png"]];

	
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
