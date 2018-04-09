//
//  UserMoney.h
//  CardYouXi
//
//  Created by bb on 2017/5/15.
//  Copyright © 2017年 com.what. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuiZeAction.h"

@interface RoleMoney: NSObject

@property (nonatomic, assign) RedChoosePuKe JiaoSe;

@property (nonatomic, assign) double JinQian;

@property (nonatomic, assign) double Bi;

@property (nonatomic, assign) BOOL isWin;

- initWithBi:(double)Bi money:(double)JinQian JiaoSe:(RedChoosePuKe)JiaoSe;

- (double)getResultMoney;

@end


@interface YongHuBean : NSObject

@property (nonatomic, copy) NSString *YongHuID;

@property (nonatomic, copy) NSString *YongHuXingMing;

@property (nonatomic, assign) double totalMoney;

@property (nonatomic, strong) NSArray *JiaoSeJinQian;

- initWithYongHuID:(NSString *)YongHuID YongHuXingMing:(NSString *)YongHuXingMing;

- (double)winMoney;

@end
