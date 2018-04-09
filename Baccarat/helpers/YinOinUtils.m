
#import "YinPinUtils.h"
#import <AVFoundation/AVFoundation.h>
#import "AudioToolBox/AudioToolBox.h"
#import "UserDefaults.h"


static SystemSoundID shake_sound_male_id = 0;

@implementation YinPinUtils

+ (void)play:(NSString *)MingZi{
    
    if ([self YunXuYingXiangWan]) {
        NSString *jc_path = [[NSBundle mainBundle] pathForResource:MingZi ofType:@"mp3"];
        if (jc_path) {
            //注册声音到系统
            AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain([NSURL fileURLWithPath:jc_path]),&shake_sound_male_id);
            AudioServicesPlaySystemSound(shake_sound_male_id);
            AudioServicesPlaySystemSound(shake_sound_male_id);//如果无法再下面播放，可以尝试在此播放
        }
        
        AudioServicesPlaySystemSound(shake_sound_male_id);   //播放注册的声音，（此句代码，可以在本类中的任意位置调用，不限于本方法中）
        
        //    YinPinServicesPlaySystemSound(kSystemSoundID_Vibrate);   //让手机震动
    }
}

+ (void)GuanBiYingXiangJuYouWanChengBlock:(void (^)(BOOL isAllow))completeBlock
{
    BOOL isAllow = [self YunXuYingXiangWan];
    [UserDefaults setBool:isAllow forKey:KEY_CLOSE_EFFECT];
    [UserDefaults synchronize];
    
    if (completeBlock) {
        completeBlock(!isAllow);
    }
}

+ (BOOL)YunXuYingXiangWan
{
    return ![UserDefaults boolForKey:KEY_CLOSE_EFFECT];
}


@end
