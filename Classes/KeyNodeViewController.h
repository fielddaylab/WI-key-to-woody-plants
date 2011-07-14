//
//  KeyNodeViewController.h
//  PlantKey
//
//  Created by David J Gagnon on 8/11/10.
//  Copyright 2010 University of Wisconsin. All rights reserved.
//
//  Licensed under the MIT license: 
//  http://www.opensource.org/licenses/mit-license.php

#import <UIKit/UIKit.h>
#import "KeyNode.h"


@interface KeyNodeViewController : UIViewController <UITableViewDelegate,UITableViewDataSource> {
	IBOutlet UITableView *myTableView;
	KeyNode *keyNode;
}

@property (nonatomic,retain) KeyNode *keyNode;

- (id)initWithKeyNode:(KeyNode *)k;


@end
