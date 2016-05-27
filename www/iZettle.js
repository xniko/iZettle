module.exports = {
    initIZettle: function (api, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "iZettle", "initIZettle", [api]);
    },
    setEnforcedUserAccount: function (emailUserAccount, successCallback, errorCallback){
		cordova.exec(successCallback, errorCallback, "iZettle", "setEnforcedUserAccount", [emailUserAccount]);
    },
    chargeAmount: function (amount, reference, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "iZettle", "chargeAmount", [amount, reference]);
    }
};
