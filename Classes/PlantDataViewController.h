//
//  PlantDataViewController.h
//  PlantKey
//
//  Created by David J Gagnon on 9/30/10.
//  Copyright 2010 University of Wisconsin. All rights reserved.
//
//  Licensed under the MIT license: 
//  http://www.opensource.org/licenses/mit-license.php

#import <UIKit/UIKit.h>
#import "Plant.h"


@interface PlantDataViewController : UIViewController {
	Plant *plant;
    IBOutlet UIWebView *webView;
	IBOutlet UITextView *commonNamesTextView;
    IBOutlet UITextView *nativeTextView;
	IBOutlet UITextView *habitatTextView;
    IBOutlet UITextView *usesTextView;
	IBOutlet UITextView *creditsTextView;   
	IBOutlet UIImageView *mainImageView;
	IBOutlet UIView *otherImagesView;	
}

@property (nonatomic,retain) Plant *plant;
@property (nonatomic,retain) UIWebView *webView;


- (id)initWithPlant:(Plant *)p;

@end
