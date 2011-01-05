//
//  PlantImageViewController.h
//  PlantKey
//
//  Created by David J Gagnon on 1/3/11.
//  Copyright 2011 University of Wisconsin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Plant.h";

@interface PlantImageViewController : UIViewController {
	Plant *plant;
	NSMutableArray *imageViews;
	IBOutlet UILabel	*caption;
	IBOutlet UIScrollView		*scrollView;
	IBOutlet UIPageControl		*pageControl;
	BOOL pageControlIsChangingPage;

}

@property (nonatomic,retain) Plant *plant;
@property (nonatomic,retain) NSMutableArray	*imageViews;
@property (nonatomic,retain) IBOutlet UILabel *caption;
@property (nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic,retain) IBOutlet UIPageControl *pageControl;



- (id)initWithPlant:(Plant *)p;


@end
