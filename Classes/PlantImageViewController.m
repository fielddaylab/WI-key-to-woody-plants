//
//  PlantImageViewController.m
//  PlantKey
//
//  Created by David J Gagnon on 1/3/11.
//  Copyright 2011 University of Wisconsin. All rights reserved.
//
//  Licensed under the MIT license: 
//  http://www.opensource.org/licenses/mit-license.php

#import "PlantImageViewController.h"
#import "Image.h"
#import "PlantDataViewController.h"

@implementation PlantImageViewController

@synthesize plant;
@synthesize caption;
@synthesize scrollView;
@synthesize pageControl;
@synthesize secondaryButton;
@synthesize secondaryViewController;

- (id)initWithPlant:(Plant *)p {
	if ((self = [super initWithNibName:@"PlantImageViewController" bundle:nil])) {
		// Custom initialization
		self.plant = p;
	}
	return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	
	NSLog(@"PlantImageViewController: Loading Plant: %@",self.plant.uid);
	self.title = self.plant.commonName1;
	self.hidesBottomBarWhenPushed = YES;
	
	//Scroller Images
	self.scrollView.delegate = self;
	[scrollView setCanCancelContentTouches:NO];
	scrollView.showsHorizontalScrollIndicator = NO;
	scrollView.clipsToBounds = YES;
	scrollView.scrollEnabled = YES;
	scrollView.pagingEnabled = YES;
	
	CGFloat scrollViewContentWidth = 0;
	for (NSUInteger imageIndex = 0; imageIndex < [self.plant.images count]; imageIndex++) {
		Image *image = [self.plant.images objectAtIndex:imageIndex];
		UIImage *uiImage = image.image;
		UIImageView *imageView = [[UIImageView alloc]initWithImage:uiImage];
	
		imageView.contentMode = UIViewContentModeScaleAspectFit;
				
		CGRect rect = imageView.frame;
		rect.size.height = scrollView.frame.size.height;
		rect.size.width = scrollView.frame.size.width;
		rect.origin.x = scrollViewContentWidth;		
		imageView.frame = rect;
		
		[scrollView addSubview:imageView];
		[imageView release];
		
		scrollViewContentWidth += scrollView.frame.size.width;
	}
	[scrollView setContentSize:CGSizeMake(scrollViewContentWidth, [scrollView bounds].size.height)];

	
	//Update the caption and page control
	self.pageControl.numberOfPages = [self.plant.images count];
	[self updateCaption];
	
	
	//Setup the secondary view and button
	PlantDataViewController *secondaryVc = [[PlantDataViewController alloc]initWithPlant:self.plant];
	self.secondaryViewController = secondaryVc;
	[secondaryVc release];
	
	//Setup secondary view button
	[secondaryButton addTarget:self action:@selector(showSecondary) forControlEvents:UIControlEventTouchUpInside];
	
	//If no images, go directly to secondary view
	if (self.pageControl.numberOfPages < 1) [self showSecondary];
	
	//Setup Home Button
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


-(void)showSecondary{
	
	self.secondaryViewController.modalTransitionStyle = UIModalTransitionStylePartialCurl;
	[self presentModalViewController:self.secondaryViewController animated:YES];

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



#pragma mark -
#pragma mark UIScrollViewDelegate stuff
- (void)scrollViewDidScroll:(UIScrollView *)_scrollView
{
 
	/*
	 *	We switch page at 50% across
	 */
    CGFloat pageWidth = _scrollView.frame.size.width;
    int page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
	
	[self updateCaption];
}

-(void)updateCaption {
	if (self.pageControl.numberOfPages < 1) caption.text = @"No Images Available";
	else {
		Image *image = [self.plant.images objectAtIndex:pageControl.currentPage];
		caption.text = image.caption;
	}
}


@end
