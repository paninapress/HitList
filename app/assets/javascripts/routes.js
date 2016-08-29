angular.module('HitListRoute', ['ngRoute', 'loginFuncMod'])
	.config(['$routeProvider', '$locationProvider',
		function($routeProvider, $locationProvider){
			$routeProvider
			.when('/', {
				templateUrl: '/views/index.html'
			})
			.when('/signup', {
				templateUrl: '/views/users/registrations/signup.html',
				controller: 'loginFuncCtrl'
			})
			.when('/login', {
				templateUrl:'/views/users/sessions/login.html',
				controller: 'loginFuncCtrl'
			})
			.when('/password/new', {
				templateUrl: '/views/users/passwords/new.html',
				controller: 'loginFuncCtrl'
			})
			.when('/password/edit', {
				templateUrl: '/views/users/passwords/edit.html',
				controller: 'loginFuncCtrl'
			})
			.when('/confirmation/new',{
				templateUrl: '/views/users/confirmations/new.html',
				controller: 'loginFuncCtrl'
			})
			.when('/dashboard', {
				templateUrl: '/views/dashboard.html'
			});
		$locationProvider.html5Mode(true);
		}]);