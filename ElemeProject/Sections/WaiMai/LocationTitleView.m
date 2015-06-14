//
//  LocationTitleView.m
//
//
//  Created by Sam Lau on 6/14/15.
//
//

#import "LocationTitleView.h"
#import <Masonry.h>

@implementation LocationTitleView

#pragma mark - Views hierarchy and layout
- (void)addSubviews
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.downwardDirectionImageView];
    [self addSubview:self.locationLabel];
}

- (void)defineLayout
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(self);
        make.top.equalTo(self);
    }];
    
    [self.downwardDirectionImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.titleLabel.mas_right).offset(2);
        make.centerY.equalTo(self.titleLabel);
    }];
    
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(self);
        make.top.equalTo(self.titleLabel.mas_bottom);
    }];
}

#pragma mark - Views Lazy Initialization
- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"附近餐厅";
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:18];
    }

    return _titleLabel;
}

- (UIImageView*)downwardDirectionImageView
{
    if (!_downwardDirectionImageView) {
        _downwardDirectionImageView = [UIImageView new];
        _downwardDirectionImageView.image = [UIImage imageNamed:@"detail_icon"];
    }

    return _downwardDirectionImageView;
}

- (UILabel*)locationLabel
{
    if (!_locationLabel) {
        _locationLabel = [UILabel new];
        _locationLabel.textColor = [UIColor whiteColor];
        _locationLabel.font = [UIFont systemFontOfSize:10];
    }

    return _locationLabel;
}

@end
