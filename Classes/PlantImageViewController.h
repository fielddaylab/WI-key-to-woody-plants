//
//  PlantImageViewController.h
//  PlantKey
//
//  Created by David J Gagnon on 1/3/11.
//  Copyright 2011 University of Wisconsin. All rights reserved.
//
//  Licensed under the MIT license: 
//  http://www.opensource.org/licenses/mit-license.php

#import <UIKit/UIKit.h>
#import "Plant.h";

@interface PlantImageViewController : UIViewController <UIScrollViewDelegate> {
	Plant *plant;
	IBOutlet UILabel	*caption;
	IBOutlet UIScrollView		*scrollView;
	IBOutlet UIPageControl		*pageControl;
	
	IBOutlet UIButton *secondaryButton;
	UIViewController *secondaryViewController;


}

@property (nonatomic,retain) Plant *plant;
@property (nonatomic,retain) NSMutableArray	*imageViews;
@property (nonatomic,retain) IBOutlet UILabel *caption;
@property (nonatomic,retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic,retain) IBOutlet UIPageControl *pageControl;
@property (nonatomic,retain) IBOutlet UIButton *secondaryButton;

@property (nonatomic,retain) UIViewController *secondaryViewController;




- (id)initWithPlant:(Plant *)p;
- (void)updateCaption;


@end
