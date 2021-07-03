(function (app) {
    app.controller('orderEditController', orderEditController);

    orderEditController.$inject = ['$http', '$scope', '$state', '$stateParams'];

    function orderEditController($http, $scope, $stateParams) {
        var user = JSON.parse(localStorage.getItem("user"));

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
                headers: { "Authorization": 'Bearer ' + user.token },
                url: current_url + '/api/Itemapi/search',
            }).then(function (response) {
                $scope.totalItems_item = response.data[0].recordCount;
                $scope.listItems_item = response.data;
            });
        };

        $scope.loadItem($scope.currentPage_item);

        $scope.listItemLocal = [];

        $scope.Item = function () {
            $http({
                method: 'GET',
                data: null,
                headers: { "Authorization": 'Bearer ' + user.token },
                url: current_url + '/api/OrderApi/item/'+$stateParams.params.id,
            }).then(function (response) {
                $scope.ma_hoa_don = response.data.ma_hoa_don;
                $scope.ho_ten = response.data.ho_ten;
                $scope.dia_chi = response.data.dia_chi;
                $scope.email = response.data.email;
                $scope.phone = response.data.phone;
                $scope.listItemLocal = response.data.listjson_chitiet;
                console.log(response.data);
            });
        };
        $scope.Item();
        $scope.addItem = function (id) {
            const item = {};
            var result =  parseInt(prompt("Nhập số lượng sản phẩm mong muốn", 1));
            if(result >= 1){
                $http({
                    method: 'GET',
                    data: {},
                    headers: { "Authorization": 'Bearer ' + user.token },
                    url: current_url + '/api/Itemapi/item/' + id,
                }).then(function (response) {
                    console.log(response);
                    item.item_id = response.data.item_id;
                    item.item_image = response.data.item_image;
                    item.item_name = response.data.item_name;
                    item.item_price = response.data.item_price;
                    item.so_luong = result;
                    item.total = result * item.item_price;
                    item.status = 1;
                    item.invest = response.data.item_invest * result;
                    $scope.listItemLocal.push(item);
                });
            }            
        }

        $scope.deleteLocal = function (id) {
            for (var i = 0; i < $scope.listItemLocal.length; i++) {
                if ($scope.listItemLocal[i].item_id == id) {
                    $scope.listItemLocal.splice(i, 1);
                }
            }

        }

        $scope.ReLoad = function(){
            $scope.ho_ten = "";
            $scope.dia_chi = "";
            $scope.so_luong = "";
            $scope.email = "";
            $scope.phone = "";
            $scope.listItemLocal = [];
        }

        
        $scope.Save = function () {
            item = {};
            item.ma_hoa_don = $scope.ma_hoa_don;
            item.ho_ten = $scope.ho_ten;
            item.dia_chi = $scope.dia_chi;
            item.email  = $scope.email;
            item.phone = $scope.phone;
            item.total = 0;
            item.invest = 0;
            item.total_item = 0;
            $scope.listItemLocal.forEach(function(i){
                item.total = item.total + i.total;
                item.total_item = item.total_item + i.so_luong;
                item.invest = item.invest + i.invest;
            })
            item.listjson_chitiet = $scope.listItemLocal;
            $http({
                method: 'POST',
                data: item,
                headers: { "Authorization": 'Bearer ' + user.token },
                url: current_url + '/api/Orderapi/edit',
            }).then(function (response) {
                $scope.ho_ten = "";
                $scope.dia_chi = "";
                $scope.so_luong = "";
                $scope.email = "";
                $scope.phone = "";
                $scope.listItemLocal = [];
                $state.go('list_order');
                alert('Thực hiện thành công');
            });

        };
        $scope.listGroup = [];
        $scope.listGroup = function(){
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