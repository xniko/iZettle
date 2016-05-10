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

        if (paymentInfo != nil) {

            NSString* msg = [NSString stringWithFormat: @"GOOD, %@", _lastReference];
            CDVPluginResult* result = [CDVPluginResult
                                       resultWithStatus:CDVCommandStatus_OK
                                       messageAsString:msg];


            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];



        } else {

            NSString* msg = [NSString stringWithFormat: @"BAD, %@", _lastReference];
            CDVPluginResult* result = [CDVPluginResult
                                       resultWithStatus:CDVCommandStatus_OK
                                       messageAsString:msg];

            [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
        }

    }];
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
