(function (app) {
    app.controller('logoutController', logoutController);

    logoutController.$inject = ['$scope','$state'];

    function logoutController($scope,$state) {
        $scope.logout = function () {           
            localStorage.clear();
            $state.go('login');  
        }
    }

})(angular.module('Admin'));