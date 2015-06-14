//
//  MasterViewController.m
//  CrazyWheel
//
//  Created by NSSimpleApps on 04.03.15.
//  Copyright (c) 2015 NSSimpleApps. All rights reserved.
//

#import "MasterViewController.h"
#import "TableContentsController.h"
#import "JSONData.h"
#import "DetailViewController.h"

static const NSTimeInterval kTimeInterval = 5;

@interface MasterViewController () <TableContentsControllerDelegate>

@property (strong, nonatomic) TableContentsController* tableContentsController;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableContentsController = [[TableContentsController alloc] init];
    self.tableContentsController.delegate = self;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.tableContentsController startUpdatingWithTimeInterval:kTimeInterval URL:[NSURL URLWithString:@"http://crazy-dev.wheely.com"]];
}

- (void)stopUpdating {
    
    [self.tableContentsController stopUpdating];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self stopUpdating];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.tableContentsController count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    JSONData *data = [self.tableContentsController JSONDataAtIndex:indexPath.row];
    
    cell.textLabel.text = data.title;
    cell.detailTextLabel.text = [data.ID stringValue];
    
    return cell;
}

#pragma mark - TableContentsControllerDelegate

- (void)controllerWillChangeContent {
    
    [self.tableView beginUpdates];
}
- (void)controllerDidChangeContent {
    
    [self.tableView endUpdates];
}

- (void)changeContentWithIndexesForDelete:(NSIndexSet *)indexesForDelete
                         indexesForInsert:(NSIndexSet *)indexesForInsert
                         indexesForReload:(NSIndexSet *)indexesForReload {
    
    NSMutableArray *indexPathsForDelete = [NSMutableArray array];
    
    [indexesForDelete enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        
        [indexPathsForDelete addObject:[NSIndexPath indexPathForRow:idx inSection:0]];
    }];
    
    NSMutableArray *indexPathsForInsert = [NSMutableArray array];
    
    [indexesForInsert enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        
        [indexPathsForInsert addObject:[NSIndexPath indexPathForRow:idx inSection:0]];
    }];
    
    NSMutableArray *indexPathsForReload = [NSMutableArray array];
    
    [indexesForReload enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        
        [indexPathsForReload addObject:[NSIndexPath indexPathForRow:idx inSection:0]];
    }];
    
    [self.tableView deleteRowsAtIndexPaths:indexPathsForDelete withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView insertRowsAtIndexPaths:indexPathsForInsert withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView reloadRowsAtIndexPaths:indexPathsForReload withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"detailSegue"]) {
        
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForCell:sender];
        
        JSONData *data = [self.tableContentsController JSONDataAtIndex:selectedIndexPath.row];
        
        DetailViewController *detailViewController = segue.destinationViewController;
        detailViewController.title = data.title;
        detailViewController.text = data.text;
    }
}


@end
