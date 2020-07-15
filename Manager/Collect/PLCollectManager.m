
//
//  PLCollectManager.m
//  PoeticLanguage
//
//  Created by cinderella on 2020/5/13.
//  Copyright © 2020 cinderella. All rights reserved.
//

#import "PLCollectManager.h"
#import "PLCollectModel.h"
#import <AFNetworking.h>
#import "JSONModel.h"
#import "PLRecitePoemsModel.h"
#import "PLReciteGetCollectsModel.h"
#import "PLRememberModel.h"
#import "PLCancelRememberModel.h"
#import "PLGetGroupModel.h"
#define HTTP @"http://118.31.12.175:8081/"

static PLCollectManager *manager = nil;
static NSString *account;
static NSString *password;

@implementation PLCollectManager 



+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    _dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[PLCollectManager alloc] init];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            account = [userDefaults objectForKey:@"accountNumber"];
            password = [userDefaults objectForKey:@"password"];
        }
    });
    return manager;
}

- (void)collectMessage:(PLCollectModelBlock)successBlock error:(ErrorBlock)errorBlock id:(NSString *)cid {
    AFHTTPSessionManager *httpManager = [AFHTTPSessionManager manager];
    NSString *sureURLStr = [NSString stringWithFormat:@"%@user/login.do?accountNumber=%@&password=%@", HTTP, account, password];
    [httpManager POST:sureURLStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        AFHTTPSessionManager *httpManager = [AFHTTPSessionManager manager];
        NSString *sureURLStr = [NSString stringWithFormat:@"%@/collect/collect.do?id=%@", HTTP, cid];
        
        [httpManager GET:sureURLStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"responseObject == %@", responseObject);
            PLCollectModel *collectModel = [[PLCollectModel alloc] initWithDictionary:responseObject error:nil];
            successBlock(collectModel);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            errorBlock(error);
        }];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ;
    }];
}

- (void)rememberMessage:(PLRecitePoemsModelBlock)successBlock error:(ErrorBlock)errorBlock id:(NSString *)cid {
    AFHTTPSessionManager *httpManager = [AFHTTPSessionManager manager];
    NSString *sureURLStr = [NSString stringWithFormat:@"%@user/login.do?accountNumber=%@&password=%@", HTTP, account, password];
    [httpManager POST:sureURLStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        AFHTTPSessionManager *httpManager = [AFHTTPSessionManager manager];
        NSString *sureURLStr = [NSString stringWithFormat:@"%@/collect/remember.do?poetId=%@", HTTP, cid];
        
        [httpManager GET:sureURLStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@", responseObject);
            PLRecitePoemsModel *reciteModel = [[PLRecitePoemsModel alloc] initWithDictionary:responseObject error:nil];
            NSLog(@"%@", reciteModel);
            successBlock(reciteModel);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            errorBlock(error);
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ;
    }];
}

- (void)cancelRememberMessage:(PLRecitePoemsModelBlock)successBlock error:(ErrorBlock)errorBlock id:(NSString *)cid {
    AFHTTPSessionManager *httpManager = [AFHTTPSessionManager manager];
    NSString *sureURLStr = [NSString stringWithFormat:@"%@user/login.do?accountNumber=%@&password=%@", HTTP, account, password];
    [httpManager POST:sureURLStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        AFHTTPSessionManager *httpManager = [AFHTTPSessionManager manager];
        NSString *sureURLStr = [NSString stringWithFormat:@"%@/collect/cancelRemember.do?poetId=%@", HTTP, cid];
        
        [httpManager GET:sureURLStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            PLRecitePoemsModel *reciteModel = [[PLRecitePoemsModel alloc] initWithDictionary:responseObject error:nil];
            successBlock(reciteModel);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            errorBlock(error);
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ;
    }];
}

- (void)getCollects:(PLReciteGetCollectsModelBlock)successBlock error:(ErrorBlock)errorBlock {
    AFHTTPSessionManager *httpManager = [AFHTTPSessionManager manager];
    NSString *sureURLStr = [NSString stringWithFormat:@"%@user/login.do?accountNumber=%@&password=%@", HTTP, account, password];
    [httpManager POST:sureURLStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        AFHTTPSessionManager *httpManager = [AFHTTPSessionManager manager];
        NSString *sureURLStr = [NSString stringWithFormat:@"%@/collect/getCollects.do", HTTP];
        [httpManager POST:sureURLStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"res == %@", responseObject);
            PLReciteGetCollectsModel *getCollectsModel = [[PLReciteGetCollectsModel alloc] initWithDictionary:responseObject error:nil];
            successBlock(getCollectsModel);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            errorBlock(error);
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ;
    }];
    
}

- (void)getRemember:(PLRememberModelBlock)successBlock error:(ErrorBlock)errorBlock {
    AFHTTPSessionManager *httpManager = [AFHTTPSessionManager manager];
    NSString *sureURLStr = [NSString stringWithFormat:@"%@user/login.do?accountNumber=%@&password=%@", HTTP, account, password];
    [httpManager POST:sureURLStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        AFHTTPSessionManager *httpManager = [AFHTTPSessionManager manager];
        NSString *sureURLStr = [NSString stringWithFormat:@"%@/collect/getRemember.do", HTTP];
        [httpManager POST:sureURLStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            PLRememberModel *getRememberModel = [[PLRememberModel alloc] initWithDictionary:responseObject error:nil];
            successBlock(getRememberModel);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            errorBlock(error);
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ;
    }];
    
}

- (void)cancelRemember:(PLCancelRememberModelBlock)successBlock error:(ErrorBlock)errorBlock id:(NSString *)sid {
    AFHTTPSessionManager *httpManager = [AFHTTPSessionManager manager];
    NSString *sureURLStr = [NSString stringWithFormat:@"%@user/login.do?accountNumber=%@&password=%@", HTTP, account, password];
    [httpManager POST:sureURLStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        AFHTTPSessionManager *httpManager = [AFHTTPSessionManager manager];
        NSString *sureURLStr = [NSString stringWithFormat:@"%@/collect/cancelRemember.do?poetId=%@", HTTP, sid];
        [httpManager POST:sureURLStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            PLCancelRememberModel *cancelRememberModel = [[PLCancelRememberModel alloc] initWithDictionary:responseObject error:nil];
            successBlock(cancelRememberModel);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            errorBlock(error);
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ;
    }];
}

- (void)getGroup:(PLGetGroupModelBlock)successBlock error:(ErrorBlock)errorBlock id:(NSString *)pid {
    AFHTTPSessionManager *httpManager = [AFHTTPSessionManager manager];
    NSString *sureURLStr = [NSString stringWithFormat:@"%@user/login.do?accountNumber=%@&password=%@", HTTP, account, password];
    [httpManager POST:sureURLStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        AFHTTPSessionManager *httpManager = [AFHTTPSessionManager manager];
        NSString *sureURLStr = [NSString stringWithFormat:@"%@/collect/remember.do?poetId=%@", HTTP, pid];
        [httpManager POST:sureURLStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"getGroupModel responseObject == %@", responseObject);
            PLGetGroupModel *getGroupModel = [[PLGetGroupModel alloc] initWithDictionary:responseObject error:nil];
            successBlock(getGroupModel);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            errorBlock(error);
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ;
    }];
}

@end
