angular.module('HitListRoute', ['ngRoute','Devise','public.ctrl.signIn', 'public.ctrl.sessions'])
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
			});
		$locationProvider.html5Mode(true);
		}]);