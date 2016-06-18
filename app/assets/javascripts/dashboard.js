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

		$scope.nowDisplaying = function(viewThis){
			if(viewThis=='list-view'){
				$('.stars-view').addClass('hide');
				$('.list-view').removeClass('hide');
			}
			else if(viewThis=='stars-view'){
				$('.list-view').addClass('hide');
				$('.stars-view').removeClass('hide');
			}
		}
	}
]);
