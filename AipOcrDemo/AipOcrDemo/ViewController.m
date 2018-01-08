//
//  ViewController.m
//  AipOcrDemo
//
//  Created by chenxiaoyu on 17/2/7.
//  Copyright © 2017年 baidu. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <AipOcrSdk/AipOcrSdk.h>

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate, AipOcrDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    UIImage * albumImage;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<NSArray<NSString *> *> *actionList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//#error 【必须】请先build AipOcrSdk工程
//#error 【必须】在此填写授权信息
//#error 【必须】上传至AppStore前，请使用lipo移除AipBase的模拟器架构，参考FAQ：http://ai.baidu.com/docs#/OCR-iOS-SDK/top
//     授权方法1：请在 http://ai.baidu.com中 新建App, 绑定BundleId后，在此处填写App的Api Key/Secret Key
        [[AipOcrService shardService] authWithAK:@"QdbsjvfVcmgWD2VTpDURlNV4" andSK:@"cpIrjGliNizUXAfmv55510CPUXhdGiPz"];


    // 授权方法2： 下载授权文件，添加至资源
//    NSString *licenseFile = [[NSBundle mainBundle] pathForResource:@"aip" ofType:@"license"];
//    NSData *licenseFileData = [NSData dataWithContentsOfFile:licenseFile];
//    if(!licenseFileData) {
//        [[[UIAlertView alloc] initWithTitle:@"授权失败" message:@"授权文件不存在" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
//    }
//    [[AipOcrService shardService] authWithLicenseFileData:licenseFileData];


    [self configureView];
    [self configureData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateTableView];
}

- (void)configureView {
    
    self.title = @"百度OCR";
}

- (void)configureData {
    
    self.actionList = [NSMutableArray array];
    
    [self.actionList addObject:@[@"通用文字识别", @"generalOCR"]];
    [self.actionList addObject:@[@"身份证正面拍照识别", @"idcardOCROnline"]];
    [self.actionList addObject:@[@"身份证反面拍照识别", @"idcardOCROnlineBack"]];
    [self.actionList addObject:@[@"身份证正面(嵌入式质量控制+云端识别)", @"loaclIdcardOCROnline"]];
    [self.actionList addObject:@[@"身份证反面(嵌入式质量控制+云端识别)", @"localIdcardOCROnlineBack"]];
    [self.actionList addObject:@[@"银行卡正面拍照识别", @"bankCardOCROnline"]];
    [self.actionList addObject:@[@"驾驶证识别", @"drivingLicenseOCR"]];
    [self.actionList addObject:@[@"行驶证识别", @"vehicleLicenseOCR"]];
    [self.actionList addObject:@[@"车牌识别", @"plateLicenseOCR"]];
     [self.actionList addObject:@[@"身份证正面相册识别", @"idcardOCROnline"]];
}

- (void)updateTableView {
    
    [self.tableView reloadData];
}

#pragma mark - Action

- (void)idcardOCROnline {

    UIViewController * vc = [AipCaptureCardVC ViewControllerWithCardType:CardTypeIdCardFont andDelegate:self isPushTypeOrAlbum:albumImage];
    [self presentViewController:vc animated:YES completion:nil];
    
}

//- (void)loaclIdcardOCROnline {
//
//    UIViewController * vc = [AipCaptureCardVC ViewControllerWithCardType:CardTypeLocalIdCardFont andDelegate:self];
//    [self presentViewController:vc animated:YES completion:nil];
//
//}
//
//- (void)bankCardOCROnline{
//
//    UIViewController * vc = [AipCaptureCardVC ViewControllerWithCardType:CardTypeBankCard andDelegate:self];
//    [self presentViewController:vc animated:YES completion:nil];
//
//}

- (void)idcardOCROnlineBack{
    
    UIViewController * vc = [AipCaptureCardVC ViewControllerWithCardType:CardTypeIdCardBack andDelegate:self  isPushTypeOrAlbum:albumImage];
    [self presentViewController:vc animated:YES completion:nil];
}

//- (void)localIdcardOCROnlineBack{
//    
//    UIViewController * vc = [AipCaptureCardVC ViewControllerWithCardType:CardTypeLocalIdCardBack andDelegate:self];
//    [self presentViewController:vc animated:YES completion:nil];
//}
//
//- (void)generalOCR{
//
//    UIViewController * vc = [AipGeneralVC ViewControllerWithHandler:^(UIImage *image) {
//        NSDictionary *options = @{@"language_type": @"CHN_ENG", @"detect_direction": @"true"};
//        [[AipOcrService shardService] detectTextBasicFromImage:image withOptions:options successHandler:^(id result) {
//            [self ocrOnGeneralSuccessful:result];
//        } failHandler:^(NSError *err) {
//            [self ocrOnFail:err];
//        }];
//
//    }];
//    [self presentViewController:vc animated:YES completion:nil];
//}
//
//- (void)drivingLicenseOCR{
//
//    UIViewController * vc = [AipGeneralVC ViewControllerWithHandler:^(UIImage *image) {
//
//        [[AipOcrService shardService] detectDrivingLicenseFromImage:image withOptions:nil successHandler:^(id result) {
//            [self ocrOnDrivingLicenseSuccessful:result];
//        } failHandler:^(NSError *err) {
//            [self ocrOnFail:err];
//        }];
//
//    }];
//    [self presentViewController:vc animated:YES completion:nil];
//}
//
//- (void)vehicleLicenseOCR{
//
//    UIViewController * vc = [AipGeneralVC ViewControllerWithHandler:^(UIImage *image) {
//
//        [[AipOcrService shardService] detectVehicleLicenseFromImage:image withOptions:nil successHandler:^(id result) {
//            [self ocrOnVehicleLicenseSuccessful:result];
//        } failHandler:^(NSError *err) {
//            [self ocrOnFail:err];
//        }];
//
//    }];
//    [self presentViewController:vc animated:YES completion:nil];
//}
//
//- (void)plateLicenseOCR{
//
//    UIViewController * vc = [AipGeneralVC ViewControllerWithHandler:^(UIImage *image) {
//
//        [[AipOcrService shardService] detectPlateLicenseFromImage:image withOptions:nil successHandler:^(id result) {
//            [self ocrOnPlateLicenseSuccessful:result];
//        } failHandler:^(NSError *err) {
//            [self ocrOnFail:err];
//        }];
//
//    }];
//    [self presentViewController:vc animated:YES completion:nil];
//}

- (void)mockBundlerIdForTest {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [self mockClass:[NSBundle class] originalFunction:@selector(bundleIdentifier) swizzledFunction:@selector(sapicamera_bundleIdentifier)];
#pragma clang diagnostic pop
}

- (void)mockClass:(Class)class originalFunction:(SEL)originalSelector swizzledFunction:(SEL)swizzledSelector {
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.actionList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    NSArray *actions = self.actionList[indexPath.row];
    cell = [tableView dequeueReusableCellWithIdentifier:@"DemoActionCell" forIndexPath:indexPath];
    cell.textLabel.text = actions[0];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 55;
    } else {
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == self.actionList.count - 1) {
        //选择相册
        [self chooseAlbumPhoto];
    }else{
        SEL funSel = NSSelectorFromString(self.actionList[indexPath.row][1]);
        if (funSel) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:funSel];
#pragma clang diagnostic pop
        }
    }
    
}

#pragma mark - 相册选择照片
-(void)chooseAlbumPhoto{
    UIImagePickerController * pick = [[UIImagePickerController alloc]init];
    pick.delegate = self;
    pick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:pick animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    NSAssert(image, @" ");
    if (image) {
        albumImage = image;
        [picker dismissViewControllerAnimated:YES completion:nil];
        [self openBAIDUPhoto];
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 进入
-(void)openBAIDUPhoto{
    UIViewController * vc = [AipCaptureCardVC ViewControllerWithCardType:CardTypeIdCardFont andDelegate:self isPushTypeOrAlbum:albumImage];
    [self presentViewController:vc animated:YES completion:nil];
}
-(BOOL)shouldAutorotate{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - 结束选择
-(void)disMissSelf{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark AipOcrResultDelegate

- (void)ocrOnIdCardSuccessful:(id)result AndImage:(UIImage *)carImage{
    NSLog(@"%@", result);
    NSString *title = nil;
    NSMutableString *message = [NSMutableString string];

    if(result[@"words_result"]){
        [result[@"words_result"] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [message appendFormat:@"%@: %@\n", key, obj[@"words"]];
        }];
    }

    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }];
}

- (void)ocrOnBankCardSuccessful:(id)result {
    NSLog(@"%@", result);
    NSString *title = nil;
    NSMutableString *message = [NSMutableString string];
    title = @"银行卡信息";
//    [message appendFormat:@"%@", result[@"result"]];
    [message appendFormat:@"卡号：%@\n", result[@"result"][@"bank_card_number"]];
    [message appendFormat:@"类型：%@\n", result[@"result"][@"bank_card_type"]];
    [message appendFormat:@"发卡行：%@\n", result[@"result"][@"bank_name"]];

    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }];
}

- (void)ocrOnGeneralSuccessful:(id)result {
    NSLog(@"%@", result);
    NSMutableString *message = [NSMutableString string];
    if(result[@"words_result"]){
        for(NSDictionary *obj in result[@"words_result"]){
            [message appendFormat:@"%@", obj[@"words"]];
        }
    }else{
        [message appendFormat:@"%@", result];
    }

    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[[UIAlertView alloc] initWithTitle:@"识别结果" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    }];

}

- (void)ocrOnDrivingLicenseSuccessful:(id)result {
    NSLog(@"%@", result);
    NSMutableString *message = [NSMutableString string];
    if(result[@"words_result"]){
        [result[@"words_result"] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [message appendFormat:@"%@: %@\n", key, obj[@"words"]];
        }];
    }else{
        [message appendFormat:@"%@", result];
    }

    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[[UIAlertView alloc] initWithTitle:@"识别结果" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    }];

}

- (void)ocrOnVehicleLicenseSuccessful:(id)result {
    NSLog(@"%@", result);
    NSMutableString *message = [NSMutableString string];
    if(result[@"words_result"]){
        [result[@"words_result"] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [message appendFormat:@"%@: %@\n", key, obj[@"words"]];
        }];
    }else{
        [message appendFormat:@"%@", result];
    }

    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[[UIAlertView alloc] initWithTitle:@"识别结果" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    }];

}

- (void) ocrOnPlateLicenseSuccessful:(id)result {
    NSLog(@"%@", result);
    NSString *title = @"";
    NSMutableString *message = [NSMutableString string];
    if(result[@"words_result"]){
        [result[@"words_result"] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [message appendFormat:@"%@: %@\n", key, obj];
        }];
    }
    NSLog(@"%@", message);
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }];
}


- (void)ocrOnFail:(NSError *)error {
    NSLog(@"%@", error);
    NSString *msg = [NSString stringWithFormat:@"%li:%@", (long)[error code], [error localizedDescription]];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [[[UIAlertView alloc] initWithTitle:@"识别失败" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    }];
}


@end
