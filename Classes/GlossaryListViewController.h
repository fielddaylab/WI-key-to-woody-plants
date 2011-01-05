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
	NSArray *indexes;
	NSMutableArray *filteredIndexes;
}

@property(nonatomic, retain) NSArray *indexes;
@property(nonatomic, retain) NSMutableArray *filteredIndexes;

-(void)refreshIndexes;
 

@end
