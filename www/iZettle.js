module.exports = {
    initIZettle: function (api, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "iZettle", "initIZettle", [api]);
    },
    chargeAmount: function (amount, reference, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "iZettle", "chargeAmount", [api, amount, reference]);
    }
};
