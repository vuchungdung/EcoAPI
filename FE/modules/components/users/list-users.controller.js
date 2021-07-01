(function (app) {
    app.controller('userListController', userListController);

    userListController.$inject = ['$http', '$scope','$state'];

    function userListController($http, $scope, $state) {
        var user = JSON.parse(localStorage.getItem("user"));

        var current_url = "https://localhost:44374";

        $scope.user = {}

        $scope.List = function(){
            $http({
                method: 'POST',
                data: $scope.user,
                headers: { "Authorization": 'Bearer ' + user.token },
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