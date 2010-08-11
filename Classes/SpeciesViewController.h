//
//  SpeciesViewController.h
//  PlantKey
//
//  Created by David J Gagnon on 8/11/10.
//  Copyright 2010 University of Wisconsin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyNode.h"


@interface SpeciesViewController : UIViewController {
	KeyNode *keyNode;
	IBOutlet UINavigationController *navigationController;

}

@property (nonatomic,retain) KeyNode *keyNode;
@property (nonatomic,retain) IBOutlet UINavigationController *navigationController;

- (id)initWithKeyNode:(KeyNode *)k andNavigationController:(UINavigationController *)n;



@end
