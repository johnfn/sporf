//
//  SpotViewController.m
//  Spot
//
//  Created by Grant Mathews on 2/11/13.
//  Copyright (c) 2013 johnfn. All rights reserved.
//

#import "SpotViewController.h"
#import "TagList.h"
#import "TagViewController.h"

@interface SpotViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) TagList* tagList;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@end

@implementation SpotViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)finishLoading {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.refreshControl endRefreshing];
}

- (void)loadTagList {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    _tagList = [[TagList alloc] init];
    dispatch_queue_t downloadQueue = dispatch_queue_create("load taglist", NULL);
    dispatch_async(downloadQueue, ^{
        [_tagList load];
        [self performSelectorOnMainThread:@selector(finishLoading)
                               withObject:nil
                            waitUntilDone:YES];
    });
}

- (TagList*)tagList {
    if (!_tagList) {
        [self loadTagList];
    }
    
    return _tagList;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(loadTagList) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    int index = [self.tableView indexPathForSelectedRow].row;
    TagViewController *newController = (TagViewController*)segue.destinationViewController;
    
    newController.tag = [self.tagList.uniqueTags objectAtIndex:index];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tagList.uniqueTags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *cellTag = [self.tagList.uniqueTags objectAtIndex:[indexPath row]];
    
    int numPhotosWithTag = [self.tagList numPhotosWithTag:cellTag];
    NSMutableString *detailText = [NSMutableString stringWithFormat:@"%d photo", numPhotosWithTag];
    if (numPhotosWithTag > 1) [detailText appendString:@"s"];
    
    cell.textLabel.text = cellTag;
    cell.detailTextLabel.text = detailText;
    
    return cell;
}

@end
