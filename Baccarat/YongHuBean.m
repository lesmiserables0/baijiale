//
//  UserMoney.m
//  CardYouXi
//
//  Created by bb on 2017/5/15.
//  Copyright © 2017年 com.what. All rights reserved.
//

#import "YongHuBean.h"

@implementation RoleMoney

- (id)initWithBi:(double)Bi money:(double)JinQian JiaoSe:(RedChoosePuKe)JiaoSe
{
    self = [super init];
    if (self) {
        self.JiaoSe = JiaoSe;
        self.JinQian =JinQian ;
        self.Bi = Bi;
    }
    return self;
}

- (double)getResultMoney
{
    double tempMoney = _JinQian;
    if (_Bi != 0) {
        if (_isWin) {
            tempMoney += tempMoney * _Bi;
        } else {
            tempMoney -= tempMoney;
        }
    }
    return tempMoney;
}

@end


@implementation YongHuBean

- (double)winMoney
{
    double sum = 0;
    for (int i=0; i<_JiaoSeJinQian.count; i++) {
        RoleMoney *roleMoney = _JiaoSeJinQian[i];
        sum += [roleMoney getResultMoney];
    }
    return sum;
}

- (double)totalMoney
{
    double sum = 0;
    for (int i=0; i<_JiaoSeJinQian.count; i++) {
        RoleMoney *roleMoney = _JiaoSeJinQian[i];
        sum += [roleMoney getResultMoney];
    }
    _totalMoney += sum;
    return _totalMoney;
}

- initWithYongHuID:(NSString *)YongHuID YongHuXingMing:(NSString *)YongHuXingMing
{
    self = [super init];
    if (self) {
        self.YongHuID = YongHuID;
        self.YongHuXingMing = YongHuXingMing;
    }
    return self;
}

@end
