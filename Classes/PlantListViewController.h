//
//  PlantListViewController.h
//  PlantKey
//
//  Created by David J Gagnon on 9/30/10.
//  Copyright 2010 University of Wisconsin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PlantListViewController : UIViewController <UITableViewDelegate,UITableViewDataSource> {
	IBOutlet UITableView *myTableView;
}

@end
