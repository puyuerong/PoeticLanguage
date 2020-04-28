//
//  PLLoginManager.m
//  PoeticLanguage
//
//  Created by cinderella on 2020/4/28.
//  Copyright © 2020 cinderella. All rights reserved.
//

#import "PLLoginManager.h"
#import "PLLoginModel.h"
#import <AFNetworking.h>
#import "JSONModel.h"
#define HTTP @"http://118.31.12.175:8081/"

static PLLoginManager *manager = nil;

@implementation PLLoginManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    _dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[PLLoginManager alloc] init];
        }
    });
    return manager;
}

- (void)getLoginMessage:(LoginModelBlock)successBlock error:(ErrorBlock)errorBlock account:(NSString *)account password:(NSString *)password {
    AFHTTPSessionManager *httpManager = [AFHTTPSessionManager manager];
    NSString *sureURLStr = [NSString stringWithFormat:@"%@user/login.do?accountNumber=%@&password=%@", HTTP, account, password];
    [httpManager POST:sureURLStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        PLLoginModel *loginModel = [[PLLoginModel alloc] initWithDictionary:responseObject error:nil];
        successBlock(loginModel);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

@end
