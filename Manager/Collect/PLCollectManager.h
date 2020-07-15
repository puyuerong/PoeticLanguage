//
//  PLCollectManager.h
//  PoeticLanguage
//
//  Created by cinderella on 2020/5/13.
//  Copyright © 2020 cinderella. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class PLCollectModel;
@class PLRecitePoemsModel;
@class PLReciteGetCollectsModel;
@class PLRememberModel;
@class PLCancelRememberModel;
@class PLGetGroupModel;

typedef void (^ErrorBlock)(NSError * _Nullable error);

typedef void (^PLCollectModelBlock)(PLCollectModel * _Nullable collectModel);
typedef void (^PLRecitePoemsModelBlock)(PLRecitePoemsModel * _Nullable recitePoemsModel);
typedef void (^PLReciteGetCollectsModelBlock)(PLReciteGetCollectsModel * _Nullable getCollectsModel);
typedef void (^PLRememberModelBlock)(PLRememberModel * _Nullable rememberModel);
typedef void (^PLCancelRememberModelBlock)(PLCancelRememberModel * _Nullable cancelRememberModel);
typedef void (^PLGetGroupModelBlock)(PLGetGroupModel * _Nullable getGroupModel);

@interface PLCollectManager : NSObject

+ (instancetype)sharedManager;
- (void)collectMessage:(PLCollectModelBlock)successBlock error:(ErrorBlock)errorBlock id:(NSString *)cid;
- (void)rememberMessage:(PLRecitePoemsModelBlock)successBlock error:(ErrorBlock)errorBlock id:(NSString *)cid;
- (void)cancelRememberMessage:(PLRecitePoemsModelBlock)successBlock error:(ErrorBlock)errorBlock id:(NSString *)cid;
- (void)getCollects:(PLReciteGetCollectsModelBlock)successBlock error:(ErrorBlock)errorBlock;
- (void)getRemember:(PLRememberModelBlock)successBlock error:(ErrorBlock)errorBlock;
- (void)cancelRemember:(PLCancelRememberModelBlock)successBlock error:(ErrorBlock)errorBlock id:(NSString *)sid;
- (void)getGroup:(PLGetGroupModelBlock)successBlock error:(ErrorBlock)errorBlock id:(NSString *)pid;


@end

NS_ASSUME_NONNULL_END
