(function (app) {
    app.controller('orderAddController', orderAddController);

    orderAddController.$inject = ['$http', '$scope', '$state'];

    function orderAddController($http, $scope) {

        var current_url = "https://localhost:44374";

        $scope.pageSize_item = '6';

        $scope.page_item = '1';

        $scope.currentPage_item = '1';

        $scope.listItems_item = [];

        $scope.loadItem = function (page) {

            $scope.currentPage_item = page;

            $http({
                method: 'POST',
                data: {
                    pageIndex: page,
                    pageSize: $scope.pageSize_item
                },
                url: current_url + '/api/Itemapi/search',
            }).then(function (response) {
                $scope.totalItems_item = response.data[0].recordCount;
                $scope.listItems_item = response.data;
            });
        };

        $scope.loadItem($scope.currentPage_item);

        // --------------------------------------

        $scope.pageSize = '4';

        $scope.page = '1';

        $scope.currentPage = '1';

        $scope.listItems = [];

        $scope.listItemLocal = [];

        $scope.item_count;

        var Id = "";

        $scope.Item = function (id) {
            Id = id;
        }

        $scope.addItem = function () {
            const item = {};
            $http({
                method: 'GET',
                data: {},
                url: current_url + '/api/Itemapi/item/' + Id,
            }).then(function (response) {
                item.item_id = response.data.item_id;
                item.item_image = response.data.item_image;
                item.item_name = response.data.item_name;
                item.item_price = response.data.item_price;
                item.so_luong = $scope.item_count;
                item.total = $scope.item_count * item.item_price;
                $scope.listItemLocal.push(item);
                $scope.item_count = angular.copy();
            });
        }
        $scope.deleteLocal = function (id) {
            for (var i = 0; i < $scope.listItemLocal.length; i++) {
                console.log($scope.listItemLocal[i]);
                if ($scope.listItemLocal[i].item_id == id) {
                    $scope.listItemLocal.splice(i, 1);
                }
            }

        }
        $scope.addOrder = function () {
            item = {};
            item.ho_ten = $scope.ho_ten;
            item.dia_chi = $scope.dia_chi;
            item.listjson_chitiet = $scope.listItemLocal;
            $http({
                method: 'POST',
                data: item,
                url: current_url + '/api/Orderapi/create',
            }).then(function (response) {
                $scope.ho_ten = "";
                $scope.dia_chi = "";
                $scope.so_luong = "";
                $scope.listItemLocal = [];
                alert('Thực hiện thành công');
            });

        };

        $scope.ReLoad = function(){
            $scope.ho_ten = "";
            $scope.dia_chi = "";
            $scope.listItemLocal = [];
        }
    }

})(angular.module('Admin'));