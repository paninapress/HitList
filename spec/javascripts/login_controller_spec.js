describe('Authentication: login functions controller', function() {
  var $rootScope,
      $scope,
      $httpBackend;
  
  beforeEach(module('loginFuncMod'));
  
  beforeEach(inject(function(_$rootScope_,_$httpBackend_,_$location_) {
    $rootScope = _$rootScope_;
    $httpBackend = _$httpBackend_;
    $location = _$location_;
  }));
  
  beforeEach(inject(function($controller) {
    $scope = $rootScope.$new();
    
    $controller('loginFuncCtrl', {
      '$scope': $scope
    });
  }));
  
  xdescribe('Register user', function(){
  	it('should do stuff', function(){
  	});
  });
});