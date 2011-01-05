//
//  PlantDataViewController.h
//  PlantKey
//
//  Created by David J Gagnon on 9/30/10.
//  Copyright 2010 University of Wisconsin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Plant.h";


@interface PlantDataViewController : UIViewController {
	Plant *plant;
	IBOutlet UITextView *nativeTextView;
	IBOutlet UITextView *commonNamesTextView;
	IBOutlet UITextView *habitatTextView;
	IBOutlet UIImageView *mainImageView;
	IBOutlet UIView *otherImagesView;	
}

@property (nonatomic,retain) Plant *plant;

- (id)initWithPlant:(Plant *)p;

@end
