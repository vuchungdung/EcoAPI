var app = angular.module('Client', []);
app.controller("homeController", function ($scope, $http) {

    $scope.products = function () {
        var User = JSON.parse(localStorage.getItem("user"));
        $http({
            method: 'POST',
            headers: { "Authorization": 'Bearer ' + User.token },
            data: { page: $scope.page, pageSize: $scope.pageSize },
            url: current_url + '/api/HoaDon/search',
        }).then(function (response) {
            $scope.listOrder = response.data.data;
            console.log($scope.listOrder);
        });
    };
    
    $scope.categories = function () {
        if ($scope.submit == "Thêm mới") {
            Order = {};
            Order.hoten = $scope.hoten;
            Order.diachi = $scope.diachi;
            $http({
                method: 'POST',
                headers: { "Authorization": 'Bearer ' + User.token },
                data: Order,
                url: current_url + '/api/HoaDon/create-Order',
            }).then(function (response) {
                $scope.LoadOrder();
                alert('Thêm mới thành công');
            });
        } else {
            Order.hoten = $scope.hoten;
            Order.diachi = $scope.diachi;
            $http({
                method: 'POST',
                headers: { "Authorization": 'Bearer ' + User.token },
                data: $scope.Order,
                url: current_url + '/api/HoaDon/update-Order',
            }).then(function (response) {
                $scope.LoadOrder();
                alert('Thêm mới thành công');
            });
        }

    };

});