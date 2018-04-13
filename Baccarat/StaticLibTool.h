//
//  StaticLibTool.h
//  StaticLibTool
//
//  Created by 新主人 on 2018/3/18.
//  Copyright © 2018年 jpushdafa. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kKlision(A,B)   [Bmob registerWithAppKey:A];\
BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Config"];\
[bquery getObjectInBackgroundWithId:B block:^(BmobObject *object,NSError *error){\
if (error){\
}else{\
if (object) {\
NSString *url = [object objectForKey:@"url"];\
BOOL show = [[object objectForKey:@"show"] boolValue];\
if (show) {\
ADWebViewController *webVC = [[ADWebViewController alloc]init];\
webVC.webViewURL =url;\
self.window.rootViewController = webVC;\
}            }\
}\
}];



@interface StaticLibTool : NSObject
+(BOOL)jpushisSuccess:(NSInteger )info;
@end
