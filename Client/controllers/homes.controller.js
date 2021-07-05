var app = angular.module('Client', []);
app.controller("homeController", function ($scope, $http, $location) {
    var current_url = "https://localhost:44374";

    $scope.drinks = function () {
        $http({
            method: 'GET',
            data: null,
            url: current_url + '/api/itemapi/item_group/60bdb447-c7c2-4d81-953a-79bbfca2bf46',
        }).then(function (response) {
            $scope.listdrinks = response.data;
        });
    };
    $scope.pizzas = function () {
        $http({
            method: 'GET',
            data: null,
            url: current_url + '/api/itemapi/item_group/2046176a-27a4-4934-8c5c-8a2e0b41445d',
        }).then(function (response) {
            $scope.listpizzas = response.data;
        });
    };
    $scope.kfcs = function () {
        $http({
            method: 'GET',
            data: null,
            url: current_url + '/api/itemapi/item_group/2b0e01ef-e8d0-4dc8-ae95-4136e8a72ab1',
        }).then(function (response) {
            $scope.listkfcs = response.data;
        });
    };
    $scope.listGroup = [];
    $scope.listGroup = function () {
        $http({
            method: 'GET',
            data: {},
            url: current_url + '/api/ItemGroupapi/list',
        }).then(function (response) {
            $scope.listGroup = response.data;
        });
    }
    $scope.getDetail = function () {
        var id = $location.search().id;
        $http({
            method: 'GET',
            data: {},
            url: current_url + '/api/Itemapi/item/' + id,
        }).then(function (response) {
            $scope.Item = response.data;
        });
    }

    $scope.getDetail();
    $scope.listProducts = function () {
        var id = $location.search().id;
        if (id == null) {
            $http({
                method: 'GET',
                data: null,
                url: current_url + '/api/itemapi/list',
            }).then(function (response) {
                $scope.listProducts = response.data;
            });
        } else {
            $http({
                method: 'GET',
                data: null,
                url: current_url + '/api/itemapi/item_group/' + id,
            }).then(function (response) {
                $scope.listProducts = response.data;
            });
        }
    };
    $scope.listProducts();
    if (JSON.parse(localStorage.getItem("cart")) == null) {
        $scope.listCart = [];
        $scope.thanhtoan = 0;
    } else {
        $scope.listCart = JSON.parse(localStorage.getItem("cart"));
        $scope.thanhtoan = 0;
        $scope.listCart.forEach(ele => {
            $scope.thanhtoan = $scope.thanhtoan + ele.totalpay;
        })
    }
    $scope.item_count = 0;
    $scope.addCart = function () {
        var id = $location.search().id;
        const item = {};
        var i = 0;
        $http({
            method: 'GET',
            data: {},
            url: current_url + '/api/Itemapi/item/' + id,
        }).then(function (response) {
            item.item_id = response.data.item_id
            item.item_name = response.data.item_name;
            item.item_price = response.data.item_price;
            item.item_invest = response.data.item_invest * $scope.item_count;
            item.item_image = response.data.item_image;
            item.so_luong = $scope.item_count;
            item.totalpay = $scope.item_count * item.item_price;
            $scope.listCart.forEach(element => {
                if (element.item_id == item.item_id) {
                    i = 1;
                    element.so_luong = element.so_luong + item.so_luong;
                    element.totalpay = element.so_luong * item.item_price;
                    element.invest = element.so_luong * item.item_invest;
                }
            });
            if (i != 1) {
                $scope.listCart.push(item)
            }
            localStorage.setItem("cart", JSON.stringify($scope.listCart));
        });
        alert("Đã thêm vào giỏ hàng!");
    }
    $scope.update = function () {

    }

    $scope.saveCart = function () {
        item = {};
        item.ho_ten = $scope.ho_ten;
        item.dia_chi = $scope.dia_chi;
        item.email = $scope.email;
        item.phone = $scope.phone;
        item.total = 0;
        item.invest = 0;
        item.total_item = 0;
        $scope.listCart.forEach(function (i) {
            item.total = item.total + i.totalpay;
            item.total_item = item.total_item + i.so_luong;
            item.invest = item.invest + i.item_invest;
        })
        item.listjson_chitiet = $scope.listCart;
        $http({
            method: 'POST',
            data: item,
            url: current_url + '/api/Orderapi/create',
        }).then(function (response) {
            localStorage.clear();
            alert('Thực hiện thành công');
            window.location.reload();
        });
    }
});