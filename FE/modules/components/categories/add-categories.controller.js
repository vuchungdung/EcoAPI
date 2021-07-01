(function (app) {
    app.controller('categoryAddController', categoryAddController);

    categoryAddController.$inject = ['$http', '$scope','$state'];

    function categoryAddController($http, $scope, $state) {
        var user = JSON.parse(localStorage.getItem("user"));
        var current_url = "https://localhost:44374";

        $scope.category = {}

        $scope.add = function(){
            $http({
                method: 'POST',
                headers: { "Authorization": 'Bearer ' + user.token },
                data: $scope.category,
                url: current_url + '/api/ItemGroupApi/add',
            }).then(function (response) {
                if(response){
                    $scope.category = angular.copy({});
                    new PNotify({
                        text: 'Thêm bài đăng thành công!',
                        addclass: 'bg-success'
                    });
                    $state.go('list_category');
                }
            })
        }

        $scope.loadGroup = function() {
            $http({
                method: 'GET',           
                data: {},
                headers: { "Authorization": 'Bearer ' + user.token },
                url: current_url + '/api/ItemGroupapi/dropdown-add',
            }).then(function (response) {
                $scope.listGroup = response.data;
            });
        }
    }

})(angular.module('Admin'));