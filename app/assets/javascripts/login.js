angular.module('public.ctrl.signIn', ['Devise'])
  .controller('signInCtrl', ['Auth', '$scope', '$location','$window',
    function(Auth, $scope, $location, $window) {
      this.credentials = { email: '', password: '' };

      this.signIn = function() {
        // Code to use 'angular-devise' component
        var config = {
            headers: {
                'X-HTTP-Method-Override': 'POST'
            }
        };
        Auth.login(this.credentials, config).then(function(user) {
          Auth.currentUser().then(function(user) {
            $scope.isAuthenticated = true;
          });
          alert('Successfully signed in user!');
          $location.path("/");
          $window.location.reload();


        }, function(error) {
          console.info('Error in authenticating user!');
          alert('Error in signing in user!');
        });
      }
    }

  ]);

angular.module('public.ctrl.sessions', ['Devise'])
  .controller('sessionCtrl', ['Auth', '$scope', '$location', '$window',
    function(Auth, $scope, $location, $window) {
      // Check on load if user signed in
      if($location.path() == '/dashboard'){
        var config = {
          interceptAuth: false
        };
        Auth.currentUser(config).then(function(user) {
          $scope.isAuthenticated = true;
        }, function(error) {
          // Log on console to check out what the error is.
          console.log(error)
        });
      }


      $scope.$on('devise:login', function(event, currentUser) {
        $scope.isAuthenticated = true;
        // You can get data of current user (getting user's name and etc.)
        console.log(currentUser);
      });

      $scope.$on('devise:new-session', function(event, currentUser) {
        $scope.isAuthenticated = true;
      });

      $scope.$on('devise:logout', function(event, oldCurrentUser) {
        $scope.isAuthenticated = false;
      });

      $scope.$on('devise:new-registration', function(event, user) {
        $scope.isAuthenticated = true;
      });



      this.logout = function() {
        var config = {
          headers: {
              'X-HTTP-Method-Override': 'DELETE'
          }
        };
        Auth.logout(config).then(function(oldUser) {
          alert("Successfully logged out!");
          $window.location.reload();
        }, function(error) {
          // An error occurred logging out.
        });
      }
    }
  ]);

  angular.module('myAuthIntercept', ['Devise'])
    .controller('myCtrl', function($scope, Auth, $http) {

        // Catch unauthorized requests and recover.
        $scope.$on('devise:unauthorized', function(event, xhr, deferred) {
            // Disable interceptor on _this_ login request,
            // so that it too isn't caught by the interceptor
            // on a failed login.
            var config = {
                interceptAuth: false
            };

            // Ask user for login credentials
            Auth.login(credentials, config).then(function() {
                // Successfully logged in.
                // Redo the original request.
                return $http(xhr.config);
            }).then(function(response) {
                // Successfully recovered from unauthorized error.
                // Resolve the original request's promise.
                deferred.resolve(response);
            }, function(error) {
                // There was an error logging in.
                // Reject the original request's promise.
                deferred.reject(error);
            });
        });
    });