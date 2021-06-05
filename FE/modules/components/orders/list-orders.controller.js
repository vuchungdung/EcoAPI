(function (app) {
    app.controller('orderListController', orderListController);

    orderListController.$inject = ['$http', '$scope','$state'];

    function orderListController($http, $scope) {

        var current_url = "https://localhost:44374";

        $scope.pageSize = '8';

        $scope.currentPage = '1';

        $scope.page = '1';

        $scope.listItems = [];

        $scope.hoten;

        $scope.diachi;

        $scope.loadItem = function (page) {
            $scope.currentPage = page;
            $http({
                method: 'POST',           
                data: { pageIndex: page, pageSize: $scope.pageSize, hoten:$scope.hoten, diachi: $scope.diachi},
                url: current_url + '/api/OrderApi/search',
            }).then(function (response) {
                console.log(response);
                // $scope.totalItems = response.data[0].recordCount;
                // $scope.listItems = response.data;
            });
        }
        $scope.loadItem($scope.currentPage);
    }

})(angular.module('Admin'));