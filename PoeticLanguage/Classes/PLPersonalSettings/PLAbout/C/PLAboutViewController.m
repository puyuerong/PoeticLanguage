//
//  PLAboutViewController.m
//  PoeticLanguage
//
//  Created by cinderella on 2020/7/15.
//  Copyright © 2020 cinderella. All rights reserved.
//

#import "PLAboutViewController.h"
#import "PLAboutView.h"
#import <Masonry.h>

@interface PLAboutViewController ()

@end

@implementation PLAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *backImage = [[UIImage imageNamed:@"allBackgroundImage.jpg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];  //pl_pc_fly.jpg
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:backImage];
    [self.view addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view.mas_width);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
    self.myView = [[PLAboutView alloc] init];
    [self.view addSubview:_myView];
    _myView.frame = self.view.bounds;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
