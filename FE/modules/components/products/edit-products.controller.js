(function (app) {
    app.controller('productEditController', productEditController);

    productEditController.$inject = ['$http', '$scope','$state','$stateParams'];

    function productEditController($http, $scope, $stateParams) {
        var user = JSON.parse(localStorage.getItem("user"));

        var current_url = "https://localhost:44374";

        $scope.Item = function () {
            $http({
                method: 'GET',
                data: null,
                headers: { "Authorization": 'Bearer ' + user.token },
                url: current_url + '/api/Itemapi/item/'+$stateParams.params.id,
            }).then(function (response) {
                console.log(response);
            });
        };
        $scope.Item();

        $scope.Save = function () {
            item = {};
            item.listjson_chitiet = $scope.listItemLocal;
            $http({
                method: 'POST',
                data: item,
                headers: { "Authorization": 'Bearer ' + user.token },
                url: current_url + '/api/Itemapi/edit',
            }).then(function (response) {
                alert('Thực hiện thành công');
            });

        };
    }

})(angular.module('Admin'));