//
//  ViewController.h
//  RottenFruit
//
//  Created by Chu-An Hsieh on 6/12/15.
//  Copyright (c) 2015 Chu-An Hsieh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (strong, nonatomic) NSDictionary *movie;
@end

