# iZettle
Plugin for Cordova


Until I get the time, this is the quick install

1. Add platform ios
2. Add plugin
3. Build ios
4. Follow the instructions on https://github.com/iZettle/sdk-ios
5. Ready

#Functions

##Init

	initIZettle( apiKey );

##Force an account

	setEnforcedUserAccount( stringAccount );

**Need iZettle SDK 1.2.4+ on iPhone**

##Retrieve payment info for a reference

	retrievePaymentInfoForReference (reference, onSuccessCallback, onFailedCallback );

##Present settings

	settings();

##Charge
Perform a payment with an amount and a reference.
	
	chargeAmount( amount, reference, onSuccessCallback, onFailedCallback );

- **apiKey**: The API key from iZettle
- **amount**: The amount string to be charged in the logged in users currency.
- **currency**: Only used for validation. If the value of this parameter doesn't match the users currency the user will be notified and then logged out. For a complete list of valid currency codes, see [ISO 4217](http://www.xe.com/iso4217.php)
- **reference**: The payment reference. Used to identify an iZettle payment, used when retrieving payment information at a later time or performing a refund. Max length 128.
