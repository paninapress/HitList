angular.module('DashboardApp', ['ngResource']);

angular.module('DashboardApp').factory(
	'friendApiService',
	['$resource', function($resource){
		return $resource('/friends/:id', {id:'@id'});
	}
]);
angular.module('DashboardApp').controller(
	'DashboardCtrl',['$scope','friendApiService',
	function($scope, friendApiService) {
		friendApiService
			.query()
			.$promise
			.then(function(friendsResponse){
				$scope.friends = friendsResponse;
			});
	}
]);
