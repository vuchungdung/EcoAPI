(function (app) {
    app.controller('orderListController', orderListController);

    orderListController.$inject = ['$http', '$scope','$state'];

    function orderListController($http, $scope) {

        var current_url = "https://localhost:44374";

        $scope.pageSize = '8';

        $scope.currentPage = '1';

        $scope.page = '1';

        $scope.listOrders = [];

        $scope.hoten;

        $scope.diachi;

        $scope.loadItem = function (page) {
            $scope.currentPage = page;
            $http({
                method: 'POST',           
                data: { pageIndex: page, pageSize: $scope.pageSize, hoten:$scope.hoten, diachi: $scope.diachi},
                url: current_url + '/api/OrderApi/search',
            }).then(function (response) {
                if(response.data.length > 0){
                    $scope.totalOrders = response.data[0].recordCount;
                    $scope.listOrders = response.data;
                }
                else{
                    alert("Danh sách hóa đơn trống!");
                }
            });
        }

        $scope.deleteConfirm = function(id){
            var result = confirm("BẠN ĐANG YÊU CẦU XÓA ĐƠN HÀNG ?");
            if(result == true){
                $http({
                    method: 'GET',           
                    data: null,
                    url: current_url + '/api/OrderApi/delete/'+id,
                }).then(function (response) {
                    if(response.status == 200){
                        $scope.loadItem($scope.currentPage);
                        alert("Bạn đã xóa đơn hàng thành công !")
                    }
                })
            }
        }
        $scope.loadItem($scope.currentPage);
        $scope.exportWord = function(id){
            $http({
                method: 'GET',           
                data: null,
                url: current_url + '/api/OrderApi/download/'+id,
                responseType: 'blob'
            }).then(function (response) {
                var blob = response.data; 
                saveAs(blob, 'hoa-don.doc');
            })
        }
    }

})(angular.module('Admin'));