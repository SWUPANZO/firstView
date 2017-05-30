//
//  ViewController.m
//  firstView
//
//  Created by 앨리스 on 2017. 5. 27..
//  Copyright © 2017년 앨리스. All rights reserved.
//
#import "Constants.h"
#import "ViewController.h"


@interface ViewController (){
    FIRDatabaseHandle _refHandle;
}

@end

@implementation ViewController{
    NSArray *array;
}
@synthesize ref;
@synthesize time,timeTable;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    time = [[NSMutableArray alloc] init];
    [timeTable registerClass:UITableViewCell.self forCellReuseIdentifier:@"Cell"];
    
    [self configureDatabase];

}

- (void)dealloc {
    [[ref child:@"Students/2013111564/lecture"] removeObserverWithHandle:_refHandle];
}


- (void)configureDatabase {
    ref = [[FIRDatabase database] reference];
    // Listen for new messages in the Firebase database
    _refHandle = [[ref child:@"Students/2013111564/lecture"] observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *snapshot) {
        NSLog(@"%@", snapshot);
        [time addObject:snapshot];
        NSLog(@"%d", time.count);
        [timeTable insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:time.count-1 inSection:0]] withRowAnimation: UITableViewRowAnimationAutomatic];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return time.count;
}


/*- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    // Dequeue cell
    UITableViewCell *cell = [timeTable dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Unpack message from Firebase DataSnapshot
    NSLog(@"time : %@", time);
    __block NSString *timeName;
 
 
    FIRDataSnapshot *timeSnapshot = time[indexPath.row];
    FIRDatabaseReference *timeSnapsotRef = timeSnapshot.ref;
    [[timeSnapsotRef child:@"name"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
            NSLog(@"name : %@", snapshot.value);
        timeName = snapshot.value;
    }];
    NSString *title = timeName;
    NSLog(@"timeName : %@", timeName);
    cell.textLabel.text = [NSString stringWithFormat:@"%@", title];
    return cell;
}*/


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    // Dequeue cell
    UITableViewCell *cell = [timeTable dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Unpack message from Firebase DataSnapshot
    FIRDataSnapshot *timeSnapshot = time[indexPath.row];
    NSDictionary<NSString *, NSString *> *time = timeSnapshot.value;
    NSString *name = time[timeFieldsname];
   // NSString *ttime = time[timeFieldsttime];
    cell.textLabel.text = [NSString stringWithFormat:@"%@" ,name];
    
    return cell;
}






@end
