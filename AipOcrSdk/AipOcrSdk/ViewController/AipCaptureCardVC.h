//
//  AipCaptureCardVC.h
//  OCRLib
//  卡片识别VewController
//  Created by Yan,Xiangda on 16/11/9.
//  Copyright © 2016年 Baidu Passport. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AipOcrSdk/AipOcrDelegate.h>


typedef NS_ENUM(NSInteger, CardType) {
    
    CardTypeIdCardFont = 0,
    CardTypeIdCardBack,
    CardTypeBankCard,
    CardTypeLocalIdCardFont ,
    CardTypeLocalIdCardBack,
    CardTypeLocalBankCard
};

@interface AipCaptureCardVC : UIViewController

@property (nonatomic, assign) CardType cardType;
@property (nonatomic, weak) id<AipOcrDelegate> delegate;

@property (nonatomic,strong) UIImage * idCardImage;

+(UIViewController *)ViewControllerWithCardType:(CardType)type andDelegate:(id<AipOcrDelegate>)delegate isPushTypeOrAlbum:(UIImage *)isAlbumImage;

/**
 打开相册
 */
-(void)openPhotoAlbum;

@property (nonatomic,strong) UIImage * isOpenPhotoAlbum;
@end
