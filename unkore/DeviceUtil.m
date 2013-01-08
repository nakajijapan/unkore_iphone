//
//  DeviceUtil.m
//  nakajima
//
//  Created by Nakajima Daichi on 13/01/09.
//
//

#import "DeviceUtil.h"

@implementation DeviceUtil


+ (int) getHeightOffset {
    
    NSString* hardware_version = [self platform];
    
    //----------------------------
    // 幅を確定する
    //----------------------------
    if ([hardware_version isEqualToString:@"iPhone5,1"] || [hardware_version isEqualToString:@"x86_64"]) {
        return 100;
    }

    return 0;
}

+ (NSString *) platform
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    /*
     　　Possible values:
     　　"i386" = iPhone Simulator // add
     　　"iPhone1,1" = iPhone 1G
     　　"iPhone1,2" = iPhone 3G
     　　"iPhone2,1" = iPhone 3GS
     　　"iPhone3,1" = iPhone 4 // add
     　　"iPod1,1" = iPod touch 1G
     　　"iPod2,1" = iPod touch 2G
     　　"iPod3,1" = iPod touch 3G // add
     　　"iPod4,1" = iPod touch 4G // add
     */
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}
@end
