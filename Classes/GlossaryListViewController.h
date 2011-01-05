//
//  GlossaryListViewController.h
//  PlantKey
//
//  Created by David J Gagnon on 1/5/11.
//  Copyright 2011 University of Wisconsin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GlossaryListViewController : UIViewController <UITableViewDelegate,UITableViewDataSource, UISearchDisplayDelegate, UISearchBarDelegate> {
	IBOutlet UITableView *myTableView;
	IBOutlet UISegmentedControl *sortFieldSegmentedControl;
	NSArray *plantIndexes;
	NSMutableArray *filteredPlantIndexes;
}

@property(nonatomic, retain) NSArray *plantIndexes;
@property(nonatomic, retain) NSMutableArray *filteredPlantIndexes;

-(IBAction) sortingSelectorValueChanged: (id) sender;
-(void)refreshPlantIndexes;
 

@end
