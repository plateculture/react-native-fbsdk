// Copyright (c) 2015-present, Facebook, Inc. All rights reserved.
//
// You are hereby granted a non-exclusive, worldwide, royalty-free license to use,
// copy, modify, and distribute this software in source code or binary form for use
// in connection with the web services and APIs provided by Facebook.
//
// As with any software that integrates with the Facebook platform, your use of
// this software is subject to the Facebook Developer Principles and Policies
// [http://developers.facebook.com/policy/]. This copyright notice shall be
// included in all copies or substantial portions of the software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "RCTFBSDKAppEvents.h"

#import "RCTConvert+FBSDKAccessToken.h"

@implementation RCTConvert (RCTFBSDKAppEvents)

RCT_ENUM_CONVERTER(FBSDKAppEventsFlushBehavior, (@{
  @"auto": @(FBSDKAppEventsFlushBehaviorAuto),
  @"explicit-only": @(FBSDKAppEventsFlushBehaviorExplicitOnly),
}), FBSDKAppEventsFlushBehaviorAuto, unsignedIntegerValue)

@end

@implementation RCTFBSDKAppEvents

RCT_EXPORT_MODULE(FBAppEventsLogger);

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}

#pragma mark - React Native Methods

RCT_EXPORT_METHOD(logEvent:(NSString *)eventName
                valueToSum:(nonnull NSNumber *)valueToSum
                parameters:(NSDictionary *)parameters)
{
  [FBSDKAppEvents logEvent:eventName
                valueToSum:valueToSum
                parameters:parameters
               accessToken:nil];
}

RCT_EXPORT_METHOD(logPurchase:(double)purchaseAmount
                     currency:(NSString *)currency
                   parameters:(NSDictionary *)parameters)
{
  [FBSDKAppEvents logPurchase:purchaseAmount
                     currency:currency
                   parameters:parameters
                  accessToken:nil];
}

RCT_EXPORT_METHOD(setFlushBehavior:(FBSDKAppEventsFlushBehavior)flushBehavior)
{
  [FBSDKAppEvents setFlushBehavior:flushBehavior];
}

RCT_EXPORT_METHOD(flush)
{
  [FBSDKAppEvents flush];
}

RCT_EXPORT_METHOD(logSearchedEvent:(NSString *)contentType
                  searchString:(NSString *)searchString
                  success: (BOOL) success)
{
    NSDictionary *params =
        [[NSDictionary alloc] initWithObjectsAndKeys:
         contentType, FBSDKAppEventParameterNameContentType,
         searchString, FBSDKAppEventParameterNameSearchString,
         [NSNumber numberWithInt:success ? 1 : 0], FBSDKAppEventParameterNameSuccess, nil
        ];

    [FBSDKAppEvents logEvent: FBSDKAppEventNameSearched parameters: params];
}

RCT_EXPORT_METHOD(logAddedToCartEvent :(NSString*)contentId
    contentType :(NSString*)contentType
    currency :(NSString*)currency
    valToSum :(double)price)
{

    NSDictionary *params =
        [[NSDictionary alloc] initWithObjectsAndKeys:
            contentId, FBSDKAppEventParameterNameContentID,
            contentType, FBSDKAppEventParameterNameContentType,
            currency, FBSDKAppEventParameterNameCurrency,
            nil];

    [FBSDKAppEvents logEvent: FBSDKAppEventNameAddedToCart
        valueToSum: price
        parameters: params];
}

RCT_EXPORT_METHOD(logViewedContentEvent :(NSString*)contentType
   contentId :(NSString*)contentId
   currency :(NSString*)currency
   valToSum :(double)price)
{

   NSDictionary *params =
       [[NSDictionary alloc] initWithObjectsAndKeys:
           contentType, FBSDKAppEventParameterNameContentType,
           contentId, FBSDKAppEventParameterNameContentID,
           currency, FBSDKAppEventParameterNameCurrency,
           nil];

   [FBSDKAppEvents logEvent: FBSDKAppEventNameViewedContent
       valueToSum: price
       parameters: params];
}

RCT_EXPORT_METHOD(logAddedToWishlistEvent :(NSString*)contentId
   contentType :(NSString*)contentType
   currency :(NSString*)currency
   valToSum :(double)price)
{

   NSDictionary *params =
       [[NSDictionary alloc] initWithObjectsAndKeys:
           contentId, FBSDKAppEventParameterNameContentID,
           contentType, FBSDKAppEventParameterNameContentType,
           currency, FBSDKAppEventParameterNameCurrency,
           nil];

   [FBSDKAppEvents logEvent: FBSDKAppEventNameAddedToWishlist
       valueToSum: price
       parameters: params];
}

RCT_EXPORT_METHOD(logAddedPaymentInfoEvent :(BOOL)success)
{

   NSDictionary *params =
       [[NSDictionary alloc] initWithObjectsAndKeys:
           [NSNumber numberWithInt:success ? 1 : 0], FBSDKAppEventParameterNameSuccess,
           nil];

   [FBSDKAppEvents logEvent: FBSDKAppEventNameAddedPaymentInfo
       parameters: params];
}

RCT_EXPORT_METHOD(logInitiatedCheckoutEvent :(NSString*)contentId
   contentType :(NSString*)contentType
   numItems :(int)numItems
   paymentInfoAvailable :(BOOL)paymentInfoAvailable
   currency :(NSString*)currency
   valToSum :(double)totalPrice)
{

   NSDictionary *params =
       [[NSDictionary alloc] initWithObjectsAndKeys:
           contentId, FBSDKAppEventParameterNameContentID,
           contentType, FBSDKAppEventParameterNameContentType,
           [NSNumber numberWithInt:numItems], FBSDKAppEventParameterNameNumItems,
           [NSNumber numberWithInt:paymentInfoAvailable ? 1 : 0], FBSDKAppEventParameterNamePaymentInfoAvailable,
           currency, FBSDKAppEventParameterNameCurrency,
           nil];

   [FBSDKAppEvents logEvent: FBSDKAppEventNameInitiatedCheckout
       valueToSum: totalPrice
       parameters: params];
}

RCT_EXPORT_METHOD(logCompletedRegistrationEvent :(NSString*)registrationMethod)
{

   NSDictionary *params =
       [[NSDictionary alloc] initWithObjectsAndKeys:
           registrationMethod, FBSDKAppEventParameterNameRegistrationMethod,
           nil];

   [FBSDKAppEvents logEvent: FBSDKAppEventNameCompletedRegistration
       parameters: params];
}

@end
