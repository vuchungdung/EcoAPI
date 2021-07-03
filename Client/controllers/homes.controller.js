var app = angular.module('Client', []);
app.controller("homeController", function ($scope, $http) {
    var current_url = "https://localhost:44374";

    $scope.products = function () {
        $http({
            method: 'GET',
            data: null,
            url: current_url + '/api/itemapi/list',
        }).then(function (response) {
            $scope.listproducts = response.data;
            console.log($scope.listproducts);
        });
    };

});