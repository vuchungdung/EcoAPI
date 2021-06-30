(function () {
    angular.module('Admin',
        ['Admin.common'])
        .config(config)
        .config(configAuthentication);
    config.$inject = ['$stateProvider', '$urlRouterProvider'];

    function config($stateProvider, $urlRouterProvider) {
        $stateProvider
            .state('base', {
                url: '',
                templateUrl: 'modules/components/views/base.view.html',
                abstract: true
            })
            .state('dashboard', {
                url: '/dashboard',
                templateUrl: 'modules/components/dashboards/dashboards.view.html',
                parent: 'base',
                controller: "dashboardController"
            })
            .state('add_product', {
                url: '/add_product',
                templateUrl: 'modules/components/products/add-products.view.html',
                parent: 'base',
                controller: "productAddController"
            })
            .state('list_product', {
                url: '/list_product',
                templateUrl: 'modules/components/products/list-products.view.html',
                parent: 'base',
                controller: "productListController"
            })
            .state('edit_product', {
                url: '/edit_product/:id',
                templateUrl: 'modules/components/products/edit-products.view.html',
                parent: 'base',
                controller: "productEditController"
            })
            .state('add_category', {
                url: '/add_category',
                templateUrl: 'modules/components/categories/add-categories.view.html',
                parent: 'base',
                controller: "categoryAddController"
            })
            .state('list_category', {
                url: '/list_category',
                templateUrl: 'modules/components/categories/list-categories.view.html',
                parent: 'base',
                controller: "categoryListController"
            })
            .state('edit_category', {
                url: '/edit_category/:id',
                templateUrl: 'modules/components/categories/edit-categories.view.html',
                parent: 'base',
                //controller: "loginController"
            })
            .state('add_order', {
                url: '/add_order',
                templateUrl: 'modules/components/orders/add-orders.view.html',
                parent: 'base',
                controller: "orderAddController"
            })
            .state('list_order', {
                url: '/list_order',
                templateUrl: 'modules/components/orders/list-orders.view.html',
                parent: 'base',
                controller: "orderListController"
            })
            .state('edit_order', {
                url: '/edit_order/:id',
                templateUrl: 'modules/components/orders/edit-orders.view.html',
                parent: 'base',
                controller: "orderEditController"
            })
            .state('add_user', {
                url: '/add_user',
                templateUrl: 'modules/components/users/add-users.view.html',
                parent: 'base',
                controller: "userAddController"
            })
            .state('list_user', {
                url: '/list_user',
                templateUrl: 'modules/components/users/list-users.view.html',
                parent: 'base',
                controller: "userListController"
            })
            .state('edit_user', {
                url: '/edit_user/:id',
                templateUrl: 'modules/components/users/edit-users.view.html',
                parent: 'base',
                controller: "userEditController"
            })
            .state('login', {
                url: "/login",
                templateUrl: "modules/components/logins/login.view.html",
                controller: "loginController"
            })
        $urlRouterProvider.otherwise('/login');
    };
    function configAuthentication($httpProvider) {
        $httpProvider.interceptors.push(function ($q, $location) {
            return {
                request: function (config) {
                    return config;
                },
                requestError: function (rejection) {

                    return $q.reject(rejection);
                },
                response: function (response) {
                    if (response.status == "401") {
                        $location.path('/login');
                    }
                    return response;
                },
                responseError: function (rejection) {

                    if (rejection.status == "401") {
                        $location.path('/login');
                    }
                    return $q.reject(rejection);
                }
            };
        });
    }
})();