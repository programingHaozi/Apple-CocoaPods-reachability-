//
//  AppDelegate.m
//  CocoaPodsDemo
//
//  Created by chenhao on 14/11/12.
//  Copyright (c) 2014年 chenhao. All rights reserved.
//


/*
 
 参考：http://code4app.com/article/cocoapods-install-usage
 
      http://blog.csdn.net/totogo2010/article/details/8198694
 
      http://www.360doc.com/content/14/0309/10/11029609_358969797.shtml
 
      http://www.cnblogs.com/SnailFish/archive/2012/09/18/SCNetworkReachability.html
 */



#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    Reachability *reachability = [Reachability reachabilityWithHostname:@"www.apple.com"];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    [reachability startNotifier];
    [self updateInterfaceWithReachability:reachability];
    
    
    return YES;
}

- (void)reachabilityChanged:(NSNotification *)noti
{
    Reachability *curReach = [noti object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}

- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    if (reachability) {
        NetworkStatus netStatus = [reachability currentReachabilityStatus];
        
        BOOL isNetConnect = [reachability connectionRequired];
        
        
        if (netStatus == NotReachable && isNetConnect) {    //无网络状态
           
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                  
                                                            message:@"没有网络"
                                  
                                                           delegate:nil
                                  
                                                  cancelButtonTitle:@"YES" otherButtonTitles:nil];
            
            [alert show];

            
        }else if(netStatus == ReachableViaWiFi){            //wifi环境
            //流量转WiFi
            if (m_netStatus !=netStatus &&m_netStatus == ReachableViaWWAN) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                      
                                                                message:@"网络从3G转到WIFI"
                                      
                                                               delegate:nil
                                      
                                                      cancelButtonTitle:@"YES" otherButtonTitles:nil];
                
                [alert show];

            }
            
        }else if (netStatus == ReachableViaWWAN){           //流量环境
           //wifi转流量
            if (m_netStatus != netStatus && m_netStatus == ReachableViaWiFi) {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                      
                                                                message:@"网络从WIFI转到3G模式，注意流量"
                                      
                                                               delegate:nil
                                      
                                                      cancelButtonTitle:@"YES" otherButtonTitles:nil];
                
                [alert show];
            }
            
        }
        
        m_netStatus = netStatus;
        
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
