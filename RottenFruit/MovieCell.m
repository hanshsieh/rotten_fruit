//
//  MovieCellTableViewCell.m
//  RottenFruit
//
//  Created by Chu-An Hsieh on 6/15/15.
//  Copyright (c) 2015 Chu-An Hsieh. All rights reserved.
//

#import "MovieCell.h"

@implementation MovieCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.posterView.image = nil;
}

@end
