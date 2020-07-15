//
//  PLGetGroupModel.h
//  PoeticLanguage
//
//  Created by cinderella on 2020/7/15.
//  Copyright © 2020 cinderella. All rights reserved.
//

#import "JSONModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PLGetGroupModel : JSONModel

@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *升级;

@end

NS_ASSUME_NONNULL_END
