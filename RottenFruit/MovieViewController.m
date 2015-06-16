//
//  MovieViewController.m
//  RottenFruit
//
//  Created by Chu-An Hsieh on 6/14/15.
//  Copyright (c) 2015 Chu-An Hsieh. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieCell.h"
#import "MovieDetailViewController.h"
#import <UIImageView+AFNetworking.h>
#import <SVProgressHUD.h>

@interface MovieViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *moviesTable;
@property (strong, nonatomic) NSArray *movies;
@property (weak, nonatomic) IBOutlet UIView *alertBar;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@end

@implementation MovieViewController
static NSString* const MOVIE_URL = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=dagqdghwaq3e3mxyrp7kmmj5&limit=20&country=us";
static NSString* const MOVIE_CELL_REUSE_ID = @"MovieCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setup the data source for the moview to me.
    self.moviesTable.dataSource = self;
    
    // Setup the controller of the table to me.
    // Delegate manages sections, handles actions, etc.
    self.moviesTable.delegate = self;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [self.refreshControl addTarget:self action: @selector(refresh:) forControlEvents: UIControlEventValueChanged];
    [self.moviesTable addSubview:self.refreshControl];
    
    [SVProgressHUD show];
    [self loadMovies:^(NSError* error) {
        [SVProgressHUD dismiss];
    }];
}

- (void)loadMovies:(void (^)(NSError* error)) callback {
    self.alertBar.hidden = YES;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:MOVIE_URL]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError != nil) {
            callback(connectionError);
            return;
        }
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.movies = dict[@"movies"];
        [self.moviesTable reloadData];
        callback(nil);
    }];
}

- (void)refresh:(id)sender {
    NSLog(@"Refreshing");
    [self loadMovies:^(NSError* error) {
        [self.refreshControl endRefreshing];
        if (error != nil) {
            self.alertBar.hidden = NO;
            return;
        }
        self.alertBar.hidden = YES;
        NSLog(@"Refresh finished");
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Deque an existing cell or create a new one if the queue is empty
    // This method uses the index path to perform additional configuration based on the cell’s position in the table view
    // The indexPath isn't used in identification of the queue to use.
    // If the screen can show only 5 rows at a time, then only 5 cells object will be created.
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:MOVIE_CELL_REUSE_ID forIndexPath: indexPath];
    NSDictionary * movie = self.movies[indexPath.row];
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"synopsis"];
    NSString *posterURLString = [movie valueForKeyPath: @"posters.thumbnail"];
    [cell.posterView setImageWithURL:[NSURL URLWithString:posterURLString]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MovieCell *cell = sender;
    NSIndexPath *idxPath = [self.moviesTable indexPathForCell:cell];
    NSDictionary *movie = self.movies[idxPath.row];
    MovieDetailViewController *dstVC = segue.destinationViewController;
    dstVC.movie = movie;
}

@end
