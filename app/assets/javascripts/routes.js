angular.module('HitListRoute', ['ngRoute','public.ctrl.signIn', 'public.ctrl.register', 'public.ctrl.sessions'])
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
			.when('/users/sign_up', {
				templateUrl: '/views/signup.html'
			})
			.when('/dashboard', {
				templateUrl: '/views/dashboard.html'
			});
		$locationProvider.html5Mode(true);
		}]);