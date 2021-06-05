(function () {
    angular.module('Admin',
        ['Admin.common'])
        .config(config);

    config.$inject = ['$stateProvider', '$urlRouterProvider'];

    function config($stateProvider, $urlRouterProvider) {
        $stateProvider
            .state('dasboard', {
                url: '/dasboard',
                templateUrl: 'modules/components/dashboards/dashboards.view.html',
                //controller: "loginController"
            })
            .state('add_product', {
                url: '/add_product',
                templateUrl: 'modules/components/products/add-products.view.html',
                controller: "productAddController"
            })
            .state('list_product', {
                url: '/list_product',
                templateUrl: 'modules/components/products/list-products.view.html',
                controller: "productListController"
            })
            .state('edit_product', {
                url: '/edit_product',
                templateUrl: 'modules/components/products/edit-products.view.html',
                //controller: "loginController"
            })
            .state('add_category', {
                url: '/add_category',
                templateUrl: 'modules/components/categories/add-categories.view.html',
                controller: "categoryAddController"
            })
            .state('list_category', {
                url: '/list_category',
                templateUrl: 'modules/components/categories/list-categories.view.html',
                controller: "categoryListController"
            })
            .state('edit_category', {
                url: '/edit_category',
                templateUrl: 'modules/components/categories/edit-categories.view.html',
                //controller: "loginController"
            })
            .state('add_order', {
                url: '/add_order',
                templateUrl: 'modules/components/orders/add-orders.view.html',
                controller: "orderAddController"
            })
            .state('list_order', {
                url: '/list_order',
                templateUrl: 'modules/components/orders/list-orders.view.html',
                controller: "orderListController"
            })
            .state('edit_order', {
                url: '/edit_order',
                templateUrl: 'modules/components/orders/edit-orders.view.html',
                //controller: "loginController"
            })
        $urlRouterProvider.otherwise('/dasboard');
    };
})();