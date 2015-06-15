//
//  MovieCellTableViewCell.h
//  RottenFruit
//
//  Created by Chu-An Hsieh on 6/15/15.
//  Copyright (c) 2015 Chu-An Hsieh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@end
