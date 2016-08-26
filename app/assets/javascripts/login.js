angular.module('public.ctrl.signIn', ['Devise'])
  .controller('signInCtrl', ['Auth', '$scope', '$location','$window',
    function(Auth, $scope, $location, $window) {
      var credentials = { email: null, password: null };

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

angular.module('public.ctrl.register', ['Devise'])
  .controller('registerCtrl', ['Auth', '$location','$scope', '$window',
    function(Auth, $location, $scope, $window){
      var credentials = {
        username: null, 
        email: null, 
        password: null, 
        password_confirmation: null
      };
      var config = {
            headers: {
                'X-HTTP-Method-Override': 'POST'
            }
        };
      this.register =function(){
          var creds = {email:this.credentials.email, password:this.credentials.password};
          Auth.register(this.credentials).then(
            function(registeredUser){
              Auth.login(creds, config).then(function(user) {
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
          }, function(error){
            // Registration failed...
            console.info('Error in registering user!');
            alert('Error in registering this user!');
          });   
      };
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