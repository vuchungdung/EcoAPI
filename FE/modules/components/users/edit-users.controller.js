(function (app) {
    app.controller('userEditController', userEditController);

    userEditController.$inject = ['$http', '$scope','$state'];

    function userEditController($http, $scope, $state) {
        var user = JSON.parse(localStorage.getItem("user"));

        var current_url = "https://localhost:44374";

        $scope.user = {}

        $scope.Edit = function(){
            $http({
                method: 'POST',
                data: $scope.user,
                headers: { "Authorization": 'Bearer ' + user.token },
                url: current_url + '/api/UserGroupApi/Edit',
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