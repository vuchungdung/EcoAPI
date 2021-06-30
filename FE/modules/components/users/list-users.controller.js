(function (app) {
    app.controller('userListController', userListController);

    userListController.$inject = ['$http', '$scope','$state'];

    function userListController($http, $scope, $state) {

        var current_url = "https://localhost:44374";

        $scope.user = {}

        $scope.List = function(){
            $http({
                method: 'POST',
                data: $scope.user,
                url: current_url + '/api/UserGroupApi/List',
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