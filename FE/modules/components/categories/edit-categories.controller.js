(function (app) {
    app.controller('categoryEditController', categoryEditController);

    categoryEditController.$inject = ['$http', '$scope','$state','$stateParams'];

    function categoryEditController($http, $scope, $state, $stateParams) {

        var user = JSON.parse(localStorage.getItem("user"));

        var current_url = "https://localhost:44374";

        $scope.category= {};
        
        $scope.Item = function(){
            console.log($stateParams);
            $http({
                method: 'GET',
                data: null,
                headers: { "Authorization": 'Bearer ' + user.token },
                url: current_url + '/api/ItemGroupApi/itemgroup/'+$stateParams.id,
            }).then(function (response) {
                $scope.category.item_group_name = response.data.item_group_name;
                $scope.category.parent_item_group_id = response.data.parent_item_group_id;
            });
        }
        $scope.Item();

        $scope.save = function(){
            
        }
    }

})(angular.module('Admin'));