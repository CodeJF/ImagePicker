//
//  JFimagePicker.m
//  BarDemo
//
//  Created by jianfeng on 17/6/7.
//  Copyright © 2017年 NARA. All rights reserved.
//

#import "JFimagePicker.h"

@interface JFimagePicker ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, copy) jf_imagePickerDidFinishPickingMediaWithInfo DidFinishPickingMediaBlock;
@property (nonatomic, copy) jf_imagePickerControllerDidCancel imagePickerControllerDidCancelBlock;
@end
@implementation JFimagePicker

-(UIImagePickerController*)imagePickerController
{
    if (_imagePickerController == nil) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        // 设置代理
        _imagePickerController.delegate = self;
        _imagePickerController.allowsEditing = YES;
        
    }
    return _imagePickerController;
    
}


- (void)showDidFinishPickingMedia:(jf_imagePickerDidFinishPickingMediaWithInfo)finish imagePickerControllerDidCancel:(jf_imagePickerControllerDidCancel)cancel
{
    //完成回调
    self.DidFinishPickingMediaBlock = finish;
    //取消回调
    self.imagePickerControllerDidCancelBlock = cancel;
    [self uploadPhoto];
    
}

- (void)uploadPhoto
{
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:nil message:@"请选择一种方式" preferredStyle:UIAlertControllerStyleActionSheet];
    
    __weak typeof(self) weakSelf = self;
    
    UIAlertAction* takePhoto = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 判断数据来源是否可用
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            // 设置数据来源
            weakSelf.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            // 打开相机/相册/图库
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:weakSelf.imagePickerController animated:YES completion:nil];
        }else{
            [SVProgressHUD showInfoWithStatus:@"该设备没有拍照功能"];
        }
        
    }];
    
    UIAlertAction* album = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 设置数据来源
        weakSelf.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        // 打开相机/相册/图库
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:weakSelf.imagePickerController animated:YES completion:nil];
        
    }];
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:takePhoto];
    [alertController addAction:album];
    [alertController addAction:cancel];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark - UIImagePickerControllerDelegate
// 取消选择
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    // 退出当前界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //把事件传出去
    !self.imagePickerControllerDidCancelBlock ? : self.imagePickerControllerDidCancelBlock();
    
}

// 选择完成
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // 获取点击的图片
    UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    NARALog(@"imageframe -> %@",NSStringFromCGSize(image.size));
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //把事件传出去
    !self.DidFinishPickingMediaBlock ? : self.DidFinishPickingMediaBlock(image);
    
}



@end
