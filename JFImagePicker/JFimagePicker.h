//
//  JFimagePicker.h
//  BarDemo
//
//  Created by jianfeng on 17/6/7.
//  Copyright © 2017年 NARA. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 完成block
 */
typedef void(^jf_imagePickerDidFinishPickingMediaWithInfo)();

/**
 * 返回block
 */
typedef void(^jf_imagePickerControllerDidCancel)();

@interface JFimagePicker : NSObject

/**
 * 显示
 * finish 选择完照片之后的回调
 * cancel 取消/返回选择照片的回调
 */
- (void)showDidFinishPickingMedia:(jf_imagePickerDidFinishPickingMediaWithInfo)finish imagePickerControllerDidCancel:(jf_imagePickerControllerDidCancel)cancel;

@end
