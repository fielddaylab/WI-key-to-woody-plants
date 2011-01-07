//
//  PlantImageViewController.m
//  PlantKey
//
//  Created by David J Gagnon on 1/3/11.
//  Copyright 2011 University of Wisconsin. All rights reserved.
//

#import "PlantImageViewController.h"
#import "Image.h"
#import "PlantDataViewController.h"

@implementation PlantImageViewController

@synthesize plant;
@synthesize caption;
@synthesize scrollView;
@synthesize pageControl;
@synthesize secondaryView;

- (id)initWithPlant:(Plant *)p {
	if ((self = [super initWithNibName:@"PlantImageViewController" bundle:nil])) {
		// Custom initialization
		self.plant = p;
		self.title = p.scientificName;
	}
	return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	
	NSLog(@"PlantImageViewController: Loading Plant: %@",self.plant.uid);
	self.title = self.plant.scientificName;
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
	
		imageView.contentMode = UIViewContentModeScaleAspectFill;
				
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
	PlantDataViewController *secondaryViewController = [[PlantDataViewController alloc]initWithPlant:self.plant];
	self.secondaryView = secondaryViewController.view;
	[secondaryViewController release];
	
	
	UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Second" 
															   style:UIBarButtonItemStylePlain 
															  target:self 
															  action:@selector(showSecondary)];
	button.image = [UIImage imageNamed:@"179-notepad.png"];
	
	self.navigationItem.rightBarButtonItem = button;
	[button release];
	
	//If no images, go directly to secondary view
	if (self.pageControl.numberOfPages < 1) [self showSecondary];
	
	
}


-(void)showSecondary{
	NSLog(@"PlantImageViewController: Showing Secondary View");
	
	UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Primary" 
															   style:UIBarButtonItemStylePlain 
															  target:self 
															  action:@selector(showPrimary)];
	button.image = [UIImage imageNamed:@"43-film-roll.png"];
	self.navigationItem.rightBarButtonItem = button;
	[button release];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp
						   forView:[self view]
							 cache:YES];
	[[self view] addSubview:self.secondaryView];
	[UIView commitAnimations];
	
}

-(void)showPrimary{
	NSLog(@"PlantImageViewController: Showing Primary View");
	UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Second" 
															   style:UIBarButtonItemStylePlain 
															  target:self 
															  action:@selector(showSecondary)];  
	button.image = [UIImage imageNamed:@"179-notepad.png"];

	self.navigationItem.rightBarButtonItem = button;
	[button release];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.5];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown
						   forView:[self view]
							 cache:YES];
	[self.secondaryView removeFromSuperview];
	[UIView commitAnimations];
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
