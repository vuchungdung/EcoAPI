(function (app) {
    app.controller('productEditController', productEditController);

    productEditController.$inject = ['$http', '$scope','$state','$stateParams'];

    function productEditController($http, $scope, $stateParams) {
        var user = JSON.parse(localStorage.getItem("user"));

        var current_url = "https://localhost:44374";

        $scope.product = {};

        $scope.Item = function () {
            $http({
                method: 'GET',
                data: null,
                headers: { "Authorization": 'Bearer ' + user.token },
                url: current_url + '/api/Itemapi/item/'+$stateParams.params.id,
            }).then(function (response) {
                console.log(response.data);
                $scope.product = response.data;
                document.getElementById('avtpreview').setAttribute('src',current_url+"/"+response.data.item_image);
            });
        };
        $scope.Item();

        $scope.save = function(){
            $http({
                method: 'POST',
                data: $scope.product,
                headers: { "Authorization": 'Bearer ' + user.token },
                url: current_url + '/api/ItemApi/edit',
            }).then(function (response) {
                if(response){
                    $scope.product = angular.copy({});
                    alert("Cập nhật sản phẩm thành công!");
                    $state.go('list_product');
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
                console.log($scope.listGroup);
            });
        }
    }

})(angular.module('Admin'));