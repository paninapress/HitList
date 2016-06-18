describe('DashboardCtrl', function() {
  var $q,
      $rootScope,
      $scope,
      mockFriendApiService,
      mockFriendsResponse = [{name: 'testee', category:3}, {name: 'testee2', category:1}];
  
  beforeEach(module('DashboardApp'));
  
  beforeEach(inject(function(_$q_, _$rootScope_) {
    $q = _$q_;
    $rootScope = _$rootScope_;
  }));
  
  beforeEach(inject(function($controller) {
    $scope = $rootScope.$new();
    
    mockFriendApiService = {
      query: function() {
        queryDeferred = $q.defer();
        return {$promise: queryDeferred.promise};
      }
    }
    
    spyOn(mockFriendApiService, 'query').and.callThrough();
    
    $controller('DashboardCtrl', {
      '$scope': $scope,
      'friendApiService': mockFriendApiService
    });
  }));
  
  describe('friendApiService.query', function() {
    
    beforeEach(function() {
      queryDeferred.resolve(mockFriendsResponse);
      $rootScope.$apply();
    });
    
    it('should query the friendApiService', function() {
      expect(mockFriendApiService.query).toHaveBeenCalled();
    });
    
    it('should set the response from the friendApiServiceQuery to $scope.friends', function() {
      expect($scope.friends).toEqual(mockFriendsResponse);
    });
  });

  describe('displaying list of user\'s friends', function() {
    it('should make list-view active', function(){
      spyOn($.fn, 'addClass');
      $scope.nowDisplaying('list-view');
      expect($.fn.addClass).toHaveBeenCalled();
    });
    it('should hide stars views', function(){
      spyOn($.fn, 'removeClass');
      $scope.nowDisplaying('list-view');
      expect($.fn.removeClass).toHaveBeenCalled();
    });
  });

  describe('displaying stars view', function(){
    it('should make stars-view active', function(){
      spyOn($.fn, 'addClass');
      $scope.nowDisplaying('stars-view');
      expect($.fn.addClass).toHaveBeenCalled();
    });
    it('should hide list-view', function(){
      spyOn($.fn, 'removeClass');
      $scope.nowDisplaying('stars-view');
      expect($.fn.removeClass).toHaveBeenCalled();
    });
  });
});