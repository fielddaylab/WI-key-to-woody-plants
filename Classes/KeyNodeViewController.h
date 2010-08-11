//
//  KeyNodeViewController.h
//  PlantKey
//
//  Created by David J Gagnon on 8/10/10.
//  Copyright 2010 University of Wisconsin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyNode.h"

@interface KeyNodeViewController : UIViewController {
	KeyNode *keyNode;
	UIViewController *contentViewController;
}

@property (nonatomic,retain) KeyNode *keyNode;
@property (nonatomic,retain) UIViewController *contentViewController;

- (id)initWithKeyNode:(KeyNode *)k;


@end
