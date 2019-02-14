//
//  BaseModel.h
//  BigFriendClient
//
//  Created by apple on 2018/4/20.
//  Copyright © 2018年 Space. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
/**1、成功 0、退出登录 -1、错误给提示*/
@property (nonatomic,assign) NSInteger res_status;
/**内容json字典*/
@property (nonatomic,strong) id res_body;
/**提示信息*/
@property (nonatomic,strong) NSString* res_msg;
@end
