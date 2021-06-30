(function (app) {
    app.controller('userAddController', userAddController);

    userAddController.$inject = ['$http', '$scope','$state'];

    function userAddController($http, $scope, $state) {

        var current_url = "https://localhost:44374";

        $scope.user = {}

        $scope.add = function(){
            $http({
                method: 'POST',
                data: $scope.user,
                url: current_url + '/api/AuthenApi/add',
            }).then(function (response) {
                if(response){
                    $scope.user = angular.copy({});
                    alert("Thêm người dùng thành công!")
                    $state.go('list_user');
                }
            })
        }
    }

})(angular.module('Admin'));