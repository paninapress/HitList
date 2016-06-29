describe('Routes', function(){
	var $route,
	$location,
	$rootScope,
	$httpBackend;

	beforeEach(module('HitListRoute'));

	beforeEach(inject(function(_$route_,_$location_,_$rootScope_,_$httpBackend_){
		$route = _$route_;
		$location = _$location_;
		$rootScope = _$rootScope_;
		$httpBackend = _$httpBackend_;
	}));

	it('/ should navigate to root', function(){
		$httpBackend.expectGET('/views/index.html').respond(200);
		$rootScope.$apply(function() { $location.path('/'); });
    	
		expect($location.path()).toBe('/');
    	expect($route.current.templateUrl).toBe('/views/index.html');
	});

	it('/users/sign_in should navigate to login.html', function(){
		$httpBackend.expectGET('/views/login.html').respond(200);
		$rootScope.$apply(function() { $location.path('/users/sign_in'); });

		expect($location.path()).toBe('/users/sign_in');
    	expect($route.current.templateUrl).toBe('/views/login.html');
	});
});