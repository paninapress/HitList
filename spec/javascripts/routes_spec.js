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

	it('/signup should navigate to signup.html', function(){
		$httpBackend.expectGET('/views/users/registrations/signup.html').respond(200);
		$rootScope.$apply(function(){ $location.path('/signup'); });

		expect($location.path()).toBe('/signup');
		expect($route.current.templateUrl).toBe('/views/users/registrations/signup.html');
	});

	it('/login should navigate to login.html', function(){
		$httpBackend.expectGET('/views/users/sessions/login.html').respond(200);
		$rootScope.$apply(function() { $location.path('/login'); });

		expect($location.path()).toBe('/login');
    	expect($route.current.templateUrl).toBe('/views/users/sessions/login.html');
	});

	it('/password/new should navigate to /passwords/new.html', function(){
		$httpBackend.expectGET('/views/users/passwords/new.html').respond(200);
		$rootScope.$apply(function() { $location.path('/password/new'); });

		expect($location.path()).toBe('/password/new');
    	expect($route.current.templateUrl).toBe('/views/users/passwords/new.html');
	});

	it('/password/edit should navigate to /passwords/edit.html', function(){
		$httpBackend.expectGET('/views/users/passwords/edit.html').respond(200);
		$rootScope.$apply(function() { $location.path('/password/edit'); });

		expect($location.path()).toBe('/password/edit');
    	expect($route.current.templateUrl).toBe('/views/users/passwords/edit.html');
	});

	it('/confirmation/new should navigate to /confirmations/new.html', function(){
		$httpBackend.expectGET('/views/users/confirmations/new.html').respond(200);
		$rootScope.$apply(function() { $location.path('/confirmation/new'); });

		expect($location.path()).toBe('/confirmation/new');
    	expect($route.current.templateUrl).toBe('/views/users/confirmations/new.html');
	});

	it('/dashboard should navigate to /dashboard.html', function(){
		$httpBackend.expectGET('/views/dashboard.html').respond(200);
		$rootScope.$apply(function() { $location.path('/dashboard'); });

		expect($location.path()).toBe('/dashboard');
    	expect($route.current.templateUrl).toBe('/views/dashboard.html');
	});
});