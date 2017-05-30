//
//  ViewController.h
//  firstView
//
//  Created by 앨리스 on 2017. 5. 27..
//  Copyright © 2017년 앨리스. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) NSMutableArray<FIRDataSnapshot *> *time;
@property (strong, nonatomic) IBOutlet UITableView *timeTable;
@end

