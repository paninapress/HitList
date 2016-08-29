angular.module('DashboardApp', ['ngResource'])
	.factory(
		'friendApiService',
		['$resource', function($resource){
			return $resource('/friends/:id', {id:'@id'});
		}
	])
	.controller('DashboardCtrl',['$scope','friendApiService',
		function($scope, friendApiService) {
			friendApiService
				.query()
				.$promise
				.then(function(friendsResponse){
					$scope.friends = friendsResponse;
				});
		}
	]);