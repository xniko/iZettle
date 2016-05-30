//
//  iZettle.h
//  POS
//
//  Created by Tue Topholm on 19/05/15.
//
//

#import <Cordova/CDV.h>
#import <iZettleSDK/iZettleSDK.h>

@interface iZettle : CDVPlugin

- (void) initIZettle:(CDVInvokedUrlCommand*)command;
- (void) chargeAmount:(CDVInvokedUrlCommand*)command;
- (void) setEnforcedUserAccount:(CDVInvokedUrlCommand*)command;
- (NSDictionary*) convertPaymentInfo:(iZettleSDKPaymentInfo *)paymentInfo;
- (void) retrievePaymentInfoForReference:(CDVInvokedUrlCommand*)command;
- (void) settings:(CDVInvokedUrlCommand*)command;

@end
