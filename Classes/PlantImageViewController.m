//
//  PlantImageViewController.m
//  PlantKey
//
//  Created by David J Gagnon on 1/3/11.
//  Copyright 2011 University of Wisconsin. All rights reserved.
//

#import "PlantImageViewController.h"
#import "Image.h"

@implementation PlantImageViewController

@synthesize plant;
@synthesize imageViews;
@synthesize caption;
@synthesize scrollView;
@synthesize pageControl;

- (id)initWithPlant:(Plant *)p {
	if ((self = [super initWithNibName:@"PlantImageViewController" bundle:nil])) {
		// Custom initialization
		self.plant = p;
		self.title = p.scientificName;
		self.imageViews = [[NSMutableArray alloc]init];
	}
	return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	NSLog(@"PlantImageViewController: Loading Plant: %@",self.plant.uid);
	self.title = self.plant.scientificName;
	self.hidesBottomBarWhenPushed = YES;
	
	self.scrollView.delegate = self;
	[self.scrollView setBackgroundColor:[UIColor blackColor]];
	[scrollView setCanCancelContentTouches:NO];
	scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	scrollView.clipsToBounds = YES;
	scrollView.scrollEnabled = YES;
	scrollView.pagingEnabled = YES;
	
	CGFloat cx = 0;
	for (NSUInteger nimages = 0; nimages < [self.plant.images count]; nimages++) {
		Image *image = [self.plant.images objectAtIndex:nimages];
		UIImage *uiImage = image.image;
		UIImageView *imageView = [[UIImageView alloc]initWithImage:uiImage];
		
		CGRect rect = imageView.frame;
		rect.size.height = uiImage.size.height;
		rect.size.width = uiImage.size.width;
		//rect.size.height = scrollView.frame.size.height;
		//rect.size.width = scrollView.frame.size.width;
		rect.origin.x = cx;		
		imageView.frame = rect;
		
		[scrollView addSubview:imageView];
		[imageView release];
		
		cx += scrollView.frame.size.width;
	}
	
	self.pageControl.numberOfPages = [self.plant.images count];
	
	[self updateCaption];
	
	[scrollView setContentSize:CGSizeMake(cx, [scrollView bounds].size.height)];
	

	
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
    if (pageControlIsChangingPage) {
        return;
    }
	
	/*
	 *	We switch page at 50% across
	 */
    CGFloat pageWidth = _scrollView.frame.size.width;
    int page = floor((_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
	
	[self updateCaption];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView 
{
    pageControlIsChangingPage = NO;
}

#pragma mark -
#pragma mark PageControl stuff
- (IBAction)changePage:(id)sender 
{
	/*
	 *	Change the scroll view
	 */
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * pageControl.currentPage;
    frame.origin.y = 0;
	
    [scrollView scrollRectToVisible:frame animated:YES];
	
	/*
	 *	When the animated scrolling finishings, scrollViewDidEndDecelerating will turn this off
	 */
    pageControlIsChangingPage = YES;
}

-(void)updateCaption {
	Image *image = [self.plant.images objectAtIndex:pageControl.currentPage];
	caption.text = image.caption;	
}


@end
