(function (app) {
    app.controller('productListController', productListController);

    productListController.$inject = ['$http', '$scope','$state'];

    function productListController($http, $scope) {

        var current_url = "https://localhost:44374";

        $scope.pageSize = '6';

        $scope.page = '1';

        $scope.currentPage = '1';

        $scope.listItems = [];

        $scope.loadItem = function (page) {

            $scope.currentPage = page;
            
            $http({
                method: 'POST',           
                data: { pageIndex: page, pageSize: $scope.pageSize},
                url: current_url + '/api/Itemapi/search',
            }).then(function (response) {
                $scope.totalItems = response.data[0].recordCount;
                $scope.listItems = response.data;
            });
        };

        $scope.loadItem($scope.currentPage);
    }

})(angular.module('Admin'));