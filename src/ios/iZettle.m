//
//  iZettle.m
//  POS
//
//  Created by Tue Topholm on 19/05/15.
//
//

#import <Foundation/Foundation.h>
#import "iZettle.h"
#import <Cordova/CDV.h>
#import <iZettleSDK/iZettleSDK.h>

@implementation iZettle

iZettleSDKPaymentInfo *_lastPaymentInfo;
NSDate *_timestamp;
NSError *_lastError;
NSNumberFormatter *_numberFormatter;

- (void) initIZettle:(CDVInvokedUrlCommand *)command {
    NSString* apiKey = [[command arguments] objectAtIndex:0];
    [[iZettleSDK shared] startWithAPIKey: apiKey];
}

- (void) chargeAmount:(CDVInvokedUrlCommand *)command {

    NSString* callbackId = [command callbackId];
    NSDecimalNumber* amount = [NSDecimalNumber decimalNumberWithString:[[command arguments] objectAtIndex:0]];
    NSString* _lastReference = [[command arguments] objectAtIndex:1];


    [[iZettleSDK shared] chargeAmount:amount currency:nil reference:_lastReference presentFromViewController:self.viewController completion:^(iZettleSDKPaymentInfo *paymentInfo, NSError *error) {
        _lastPaymentInfo = paymentInfo;
        _lastError = error;
        _timestamp = [NSDate date];

        CDVPluginResult* result = nil;
        NSString* msg = [NSString stringWithFormat: @"%@", _lastReference];

        if (paymentInfo != nil) {
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:msg];

        } else {
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:msg];
        }
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];

    }];
}

- (void) retrievePaymentInfoForReference:(CDVInvokedUrlCommand *)command {
    NSString* reference = [command.arguments objectAtIndex:0];
    [[iZettleSDK shared] retrievePaymentInfoForReference:reference completion:^(iZettleSDKPaymentInfo *paymentInfo, NSError *error) {
        if (paymentInfo != nil) {
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:[self convertPaymentInfo: paymentInfo]];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        } else {
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: error.localizedDescription ];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
    }];
}

- (void) settings:(CDVInvokedUrlCommand *)command {
    [[iZettleSDK shared] presentSettingsFromViewController:self.viewController];
}

- (void) setEnforcedUserAccount:(CDVInvokedUrlCommand*)command {
    NSString* email = [[command arguments] objectAtIndex:0];
    [iZettleSDK shared].enforcedUserAccount = email;
    NSLog(@"Forced account: %@", [iZettleSDK shared].enforcedUserAccount);
}

- (NSDictionary*) convertPaymentInfo:(iZettleSDKPaymentInfo *)paymentInfo {
    return @{
             @"referenceNumber": @"referenceNumber",
             @"entryMode": @"entryMode",
             @"obfuscatedPan": @"obfuscatedPan",
             @"panHash": @"panHash",
             @"cardBrand": @"cardBrand",
             @"AID": @"AID",
             @"TSI": @"TSI",
             @"TVR": @"TVR",
             @"applicationName": @"applicationName"
             };

}

@end
