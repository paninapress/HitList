angular.module('HitListRoute', ['ngRoute', 'loginFuncMod'])
	.config(['$routeProvider', '$locationProvider',
		function($routeProvider, $locationProvider){
			$routeProvider
			.when('/', {
				templateUrl: '/views/index.html'
			})
			.when('/users/sign_in', {
				templateUrl:'/views/users/sessions/login.html',
				controller: 'loginFuncCtrl'
			})
			.when('/users/sign_up', {
				templateUrl: '/views/users/registrations/signup.html',
				controller: 'loginFuncCtrl'
			})
			// .when('/users/password/new', {
			// 	templateUrl: '/views/users/passwords/new.html',
			// 	controller: 'loginFuncCtrl'
			// })
			// .when('/users/password/edit', {
			// 	templateUrl: '/views/users/passwords/edit.html',
			// 	controller: 'loginFuncCtrl'
			// })
			.when('/users/confirmation/new',{
				templateUrl: '/views/users/confirmations/new.html',
				controller: 'loginFuncCtrl'
			})
			.when('/dashboard', {
				templateUrl: '/views/dashboard.html'
			});
		$locationProvider.html5Mode(true);
		}]);