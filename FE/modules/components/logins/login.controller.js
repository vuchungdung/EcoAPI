(function (app) {
    app.controller('loginController', loginController);

    loginController.$inject = ['$http', '$scope','$state'];

    function loginController($http, $scope) {

        var current_url = "https://localhost:44374";

        $scope.login = function () {
            $http({
                method: 'POST',           
                data: { Username: $scope.username, Password: $scope.password},
                url: current_url + '/api/AuthenApi/login',
            }).then(function (response) {
                console.log(response);
            }).catch(function(err){
                console.log(err);
            })
        }
    }

})(angular.module('Admin'));