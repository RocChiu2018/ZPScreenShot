//
//  ViewController.m
//  屏幕截图
//
//  Created by 赵鹏 on 2018/12/30.
//  Copyright © 2018 赵鹏. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+ZPScreenShot.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark ————— 点击"截屏"按钮 —————
- (IBAction)screenShot:(id)sender
{
    //当按下“截屏”按钮的时候，按钮会变成灰色，这个时候截屏的话效果不好。当按下“截屏”按钮后一秒再进行截屏效果会比较好。
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self directScreenShot];
        
        [self callCategoryMethod];
    });
}

#pragma mark ————— 直接截屏 —————
- (void)directScreenShot
{
    /**
     1、创建一个与屏幕大小相同的基于位图(bitmap)的图形上下文：可以把图形上下文看成是一个画板，以后所绘制的内容都画在这个画板上。
     size参数：图形上下文的尺寸；
     opaque参数：不透明度（YES：不透明；NO：透明）；
     scale参数：缩放比例。
     */
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
    
    /**
     2、获取图形上下文：
     */
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    /**
     3、把屏幕上的图层渲染到图形上下文中：
     图层(layer)只能渲染，不能绘制。
     */
    [self.view.layer renderInContext:ctx];
    
    /**
     4、从图形上下文中取出截好屏的图片：
     */
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    /**
     5、关闭图形上下文：
     */
    UIGraphicsEndImageContext();
    
    /**
     6、把截好屏的图片转换成NSData类型的二进制数据：
     "UIImagePNGRepresentation(UIImage * __nonnull image)"方法是把图片转换成以后将成为png格式的图片的NSData类型的二进制数据；
     "UIImageJPEGRepresentation(UIImage * __nonnull image, CGFloat compressionQuality)"方法是把图片转换成以后将成为JPEG格式的图片的NSData类型的二进制数据。方法中的"compressionQuality"参数是指在图片转换成二进制数据的过程中压缩图片的比例，一般"1"代表最高质量，即不对图片进行压缩。一般用此方法转换的时候对图片进行压缩。
     */
    NSData *data = UIImageJPEGRepresentation(image,1);
    
    /**
     7、把二进制数据写到电脑的桌面上：
     */
    [data writeToFile:@"/Users/zhaopeng/Desktop/screenShot.jpg" atomically:YES];
}

#pragma mark ————— 调用分类的方法截屏 —————
- (void)callCategoryMethod
{
    UIImage *image = [UIImage imageWithCaptureView:self.view];
    
    NSData *data = UIImageJPEGRepresentation(image,1);
    
    [data writeToFile:@"/Users/zhaopeng/Desktop/screenShot.jpg" atomically:YES];
}

@end
