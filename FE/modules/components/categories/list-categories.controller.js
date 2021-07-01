(function (app) {
    app.controller('categoryListController', categoryListController);

    categoryListController.$inject = ['$http', '$scope','$state'];

    function categoryListController($http, $scope) {
        var user = JSON.parse(localStorage.getItem("user"));

        var current_url = "https://localhost:44374";

        $scope.pageSize = '8';

        $scope.currentPage = '1';

        $scope.page = '1';

        $scope.listCategories = [];

        $scope.loadItem = function (page) {
            $scope.currentPage = page;
            $http({
                method: 'POST',           
                headers: { "Authorization": 'Bearer ' + user.token },
                data: { pageIndex: page, pageSize: $scope.pageSize},
                url: current_url + '/api/ItemGroupApi/search',
            }).then(function (response) {
                $scope.totalCategories = response.data[0].recordCount;
                $scope.listCategories = response.data;
            }).catch(function(err){
                console.log(err);
            })
        }
        $scope.loadItem($scope.currentPage);
    }

})(angular.module('Admin'));