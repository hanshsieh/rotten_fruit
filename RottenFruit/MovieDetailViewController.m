//
//  ViewController.m
//  RottenFruit
//
//  Created by Chu-An Hsieh on 6/12/15.
//  Copyright (c) 2015 Chu-An Hsieh. All rights reserved.
//

#import "MovieDetailViewController.h"
#import <UIImageView+AFNetworking.h>
#import <SVProgressHUD.h>

@interface MovieDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *alertBar;
@end

@implementation MovieDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.alertBar.hidden = YES;
    self.titleLabel.text = self.movie[@"title"];
    self.synopsisLabel.text = self.movie[@"synopsis"];
    self.posterView.image = self.posterPlaceholder;
    NSString *posterURLString = [self.movie valueForKeyPath: @"posters.detailed"];
    posterURLString = [self convertPosterUrlStringToHighRes:posterURLString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:posterURLString]];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    
    [self.posterView setImageWithURLRequest:request placeholderImage:nil
        success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            self.posterView.image = image;
            self.alertBar.hidden = YES;
        } failure: ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            self.alertBar.hidden = NO;
        }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSString*)convertPosterUrlStringToHighRes:(NSString*)urlString {
    NSLog(@"URL: %@", urlString);
    NSRange range = [urlString rangeOfString:@".*cloudfront.net/" options:NSRegularExpressionSearch];
    NSString* returnValue = urlString;
    if (range.length > 0) {
        returnValue = [urlString stringByReplacingCharactersInRange:range withString:@"https://content6.flixster.com/"];
    } else {
        NSLog(@"Pattern not found for URL: %@", urlString);
    }
    return returnValue;
}


@end
