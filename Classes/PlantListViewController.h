//
//  PlantListViewController.h
//  PlantKey
//
//  Created by David J Gagnon on 9/30/10.
//  Copyright 2010 University of Wisconsin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PlantListViewController : UIViewController <UITableViewDelegate,UITableViewDataSource, UISearchDisplayDelegate, UISearchBarDelegate> {
	IBOutlet UITableView *myTableView;
	NSArray *plantIndexes;
	NSMutableArray *filteredPlantIndexes;
}

@property(nonatomic, retain) NSArray *plantIndexes;
@property(nonatomic, retain) NSMutableArray *filteredPlantIndexes;

@end
