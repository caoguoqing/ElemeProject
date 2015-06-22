//
//  CurrentLocationCell.m
//
//
//  Created by Sam Lau on 6/17/15.
//
//

#import "CurrentLocationCell.h"
#import "ColorMacro.h"
#import <Masonry.h>

@implementation CurrentLocationCell

#pragma mark - Views hierarchy and layout
- (void)addSubviews
{
    [self addSubview:self.locationImageView];
    [self addSubview:self.currentLocationLabel];
    

}

- (void)defineLayout
{
    [self.currentLocationLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(self).with.offset(10);
        make.centerY.equalTo(self);
    }];
    
    [self.locationImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(self.currentLocationLabel.mas_left).offset(-5);
        make.centerY.equalTo(self);
    }];
}

#pragma mark - Views Lazy Initialization
- (UIImageView *)locationImageView
{
    if (!_locationImageView) {
        _locationImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_current"]];
    }
    
    return _locationImageView;
}

- (UILabel *)currentLocationLabel
{
    if (!_currentLocationLabel) {
        _currentLocationLabel = [UILabel new];
        _currentLocationLabel.text = @"定位到当前位置";
        _currentLocationLabel.textColor = THEME_COLOR;
        _currentLocationLabel.font = [UIFont systemFontOfSize:16.0f];
    }
    
    return _currentLocationLabel;
}

@end
