module.exports = {
    initIZettle: function (api, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "iZettle", "initIZettle", [api]);
    },
    chargeAmount: function (amount, reference, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "iZettle", "chargeAmount", [amount, reference]);
    },
    retrievePaymentInfoForReference: function(reference, successCallback, errorCallback) {
	   cordova.exec(successCallback, errorCallback, "iZettle", "retrievePaymentInfoForReference", [reference]);
    },
    settings: function () {
	    cordova.exec(function(){}, function(){}, "iZettle", "settings");
    },
    retrievePaymentInfoForReference: function(successCallback, errorCallback, api, rPIFR) {
	   cordova.exec(successCallback, errorCallback, "iZettle", "retrievePaymentInfoForReference", [api, rPIFR]);
    },
};
