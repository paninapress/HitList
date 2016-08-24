angular.module('HitListRoute', ['ngRoute','public.ctrl.signIn', 'public.ctrl.sessions','myAuthIntercept'])
	.config(['$routeProvider', '$locationProvider',
		function($routeProvider, $locationProvider){
			$routeProvider
			.when('/', {
				templateUrl: '/views/index.html'
			})
			.when('/users/sign_in', {
				templateUrl:'/views/login.html'
			})
			.when('/sign_in', {
				templateUrl:'/views/login.html'
			})
			.when('/dashboard', {
				templateUrl: '/views/dashboard.html'
			});
		$locationProvider.html5Mode(true);
		}]);