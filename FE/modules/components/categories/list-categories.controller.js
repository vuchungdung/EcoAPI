(function (app) {
    app.controller('categoryListController', categoryListController);

    categoryListController.$inject = ['$http', '$scope','$state'];

    function categoryListController($http, $scope) {

        var current_url = "https://localhost:44374";

        $scope.pageSize = '8';

        $scope.currentPage = '1';

        $scope.page = '1';

        $scope.listItems = [];

        $scope.loadItem = function (page) {
            $scope.currentPage = page;
            $http({
                method: 'POST',           
                data: { pageIndex: page, pageSize: $scope.pageSize},
                url: current_url + '/api/ItemGroupApi/search',
            }).then(function (response) {
                $scope.totalItems = response.data[0].recordCount;
                $scope.listItems = response.data;
            });
        }
        $scope.loadItem($scope.currentPage);
    }

})(angular.module('Admin'));