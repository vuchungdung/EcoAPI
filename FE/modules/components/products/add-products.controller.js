(function (app) {
    app.controller('productAddController', productAddController);

    productAddController.$inject = ['$http', '$scope','$state'];

    function productAddController($http, $scope, $state) {
        var user = JSON.parse(localStorage.getItem("user"));

        var current_url = "https://localhost:44374";

        $scope.product = {}

        $scope.ckeditorOptions = {
            languague: 'vi',
            height: '200px'
        }

        $scope.upLoad = function(){
            var file = document.getElementById('file').files[0];
            const formData = new FormData();
            formData.append('file', file);
            $http({
                method: 'POST',                               
                headers: {
                    'Content-Type': undefined,
                    'Accept': 'application/json'                                     
                },
                data: formData,
                url: current_url + '/api/ItemApi/upload'
            }).then(function (res) {
                if(res.status == 200){
                    $scope.product.item_image = res.data;
                    document.getElementById('avtpreview').setAttribute('src',current_url+"/"+res.data);
                }
            }).catch(function(){
                document.getElementById('avtpreview').setAttribute('src','../../../dist/img/no-image-available.jpg');
            })
        }

        $scope.add = function(){
            $http({
                method: 'POST',
                data: $scope.product,
                headers: { "Authorization": 'Bearer ' + user.token },
                url: current_url + '/api/ItemApi/create',
            }).then(function (response) {
                if(response){
                    $scope.product = angular.copy({});
                    new PNotify({
                        text: 'Thêm bài đăng thành công!',
                        addclass: 'bg-success'
                    });
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