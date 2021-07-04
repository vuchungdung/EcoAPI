(function (app) {
    app.controller('orderListController', orderListController);

    orderListController.$inject = ['$http', '$scope','$state'];

    function orderListController($http, $scope) {
        var user = JSON.parse(localStorage.getItem("user"));

        var current_url = "https://localhost:44374";

        $scope.pageSize = '8';

        $scope.currentPage = '1';

        $scope.page = '1';

        $scope.listOrders = [];

        $scope.hoten;

        $scope.loadItem = function (page) {
            $scope.currentPage = page;
            $http({
                method: 'POST',           
                headers: { "Authorization": 'Bearer ' + user.token },
                data: { pageIndex: page, pageSize: $scope.pageSize, hoten:$scope.keyword},
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
                    headers: { "Authorization": 'Bearer ' + user.token },
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
                headers: { "Authorization": 'Bearer ' + user.token },
                url: current_url + '/api/OrderApi/download/'+id,
                responseType: 'blob'
            }).then(function (response) {
                var blob = response.data; 
                saveAs(blob, 'hoa-don.doc');
            })
        }
        $scope.output = function(date){
            $http({
                method: 'POST',           
                headers: { "Authorization": 'Bearer ' + user.token },
                data: date,
                url: current_url + '/api/OrderApi/statistic',
            }).then(function (response) {
                console.log(response);
            });
        }
        $scope.search = function(){
            $scope.loadItem($scope.currentPage);
        }
    }

})(angular.module('Admin'));