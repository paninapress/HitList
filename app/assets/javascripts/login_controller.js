angular.module('loginFuncMod',['Devise'])
  .controller('loginFuncCtrl', ['$scope', '$http', '$location', '$window', '$timeout', 'Auth',
    function($scope, $http, $location, $window, $timeout, Auth){

      $scope.login_user = {
        email: null,
        password: null
      };

      $scope.login_error = {
        message: null,
        errors: {}
      };

      $scope.register_user = {
        username: null,
        email: null,
        password: null,
        password_confirmation: null
      };

      $scope.register_error = {
        username: null,
        email: null,
        password: null,
        password_confirmation: null,
        errors: {}
      };

      $scope.register = function() {
        $scope.submit({
          method: 'POST',
          url: '/signup.json',
          data: {
            user: { 
                    username: $scope.register_user.username,
                    email: $scope.register_user.email,
                    password: $scope.register_user.password,
                    password_confirmation: $scope.register_user.password_confirmation
            },
          },
          success_message: "You have been registered and logged in.  A confirmation e-mail has been sent to your e-mail address, your access will terminate in 2 days if you do not use the link in that e-mail.",
          error_entity: $scope.register_error
        },
          function (){
            $location.path("/");
            $window.location.reload();
          }
        );
      };

      $scope.login = function() {
        $scope.submit({
          method: 'POST',
          url: '/login.json',
          data: {
            user: { email: $scope.login_user.email,
            password: $scope.login_user.password
            }
          },
          success_message: "You have been logged in.",
          error_entity: $scope.login_error
        },
          function (){
            $location.path("/");
            $window.location.reload();
          }
        );
      };

      $scope.logout = function() {
        $scope.submit({
          method: 'DELETE',
          url: '/sign_out.json',
          success_message: 'You have been logged out.',
          error_entity: $scope.login_error
        },
          function (){
            $window.location.reload();
          }
        );
      };

      $scope.confirm = function(){
        $scope.submit({
          method: 'POST',
          url: '/confirmation.json',
          data: {
            user: { email: $scope.login_user.email }
          },
          success_message: "A new confirmation link has been sent to your e-mail address.",
          error_entity: $scope.login_error
        },
        function(){
          $timeout(function() {
            $location.path('/login');
          }, 2000);
        });
      };

      $scope.password_reset = function() {
        $scope.submit({
          method: 'POST',
          url: '/password.json',
          data: {
            user: { email: $scope.login_user.email
            }
          },
            success_message: "Reset instructions have been sent to your e-mail address.",
            error_entity: $scope.login_error
        },
        function(){
          $timeout(function() {
            $location.path('/login');
          }, 2000);
        });
      };

      // Doesn't work because 'email can't be blank'. I need to somehow use the reset_password_token to get the user email and then do the update
      // $scope.change_password = function() {
      //   $scope.submit({
      //     method: "POST",
      //     url: '/password.json',
      //     data: {
      //       user: { password: $scope.register_user.password,
      //         password_confirmation: $scope.register_user.password_confirmation,
      //         reset_password_token: /reset_password_token=(.+)/.exec($location.absUrl())[1]
      //       }
      //     },
      //     success_message: "Your password has been updated.",
      //     error_entity: $scope.register_error
      //   },
      //   function(){
      //     $timeout(function() {
      //       $location.path('/login');
      //     }, 2000);
      //   });
      // };

      // This works. requires 'Auth' and 'Devise' from angular-devise
      var parameters = {
        password: null,
        password_confirmation: null,
        reset_password_token: null,
      };
      $scope.change_password = function(){
        $scope.reset_messages();
        this.parameters.reset_password_token = /reset_password_token=(.+)/.exec($location.absUrl())[1];
        Auth.resetPassword(this.parameters).then(function(new_data){
          $scope.register_error.message = "Your password has been updated.";
          $timeout(function() {
            $location.path('/');
            $window.location.reload();
          }, 1500);
        }, function(error){
           if (error.status == 422){
            $scope.register_error.errors = error.data.errors;
          }
          else {
            if (error.data.error) {
              $scope.register_error.message = error.data.error;
            }
            else {
              $scope.register_error.message = "Unexplained error, potentially a server error, please report via support channels as this indicates a code defect. Server response was: " + JSON.stringify(data);
            }
          }
        });
      };

      $scope.$on('devise:reset-password-successfully', function(event){
      });

      $scope.submit = function(parameters, redirect){
        $scope.reset_messages();

        $http({
          method: parameters.method,
          url: parameters.url,
          data: parameters.data
        })
        .success(function(data, status){
          if (status == 201 || status == 204){
            parameters.error_entity.message = parameters.success_message;
            $scope.reset_users();
            redirect(parameters.error_entity.message);
          }
          else {
            if (data.error){
              parameters.error_entity.message = data.error;
            }
            else {
              parameters.error_entity.message = "Success, but with an unexpected success code, potentially a server error, please report via support channels as this indicates a code defect. Server response was: " + JSON.stringify(data);
            }
          }
        })
        .error(function(data, status){
          if (status == 422){
            console.log(data.errors)
            parameters.error_entity.errors = data.errors;
          }
          else {
            if (data.error) {
              parameters.error_entity.message = data.error;
            }
            else {
              parameters.error_entity.message = "Unexplained error, potentially a server error, please report via support channels as this indicates a code defect. Server response was: " + JSON.stringify(data);
            }
          }
        });
      };

      $scope.reset_messages = function(){
        $scope.login_error.message = null;
        $scope.login_error.errors = {};
        $scope.register_error.message = null;
        $scope.register_error.errors = {};
      };

      $scope.reset_users = function(){
        $scope.login_user.email = null;
        $scope.login_user.password = null;
        $scope.register_user.username = null;
        $scope.register_user.email = null;
        $scope.register_user.password = null;
        $scope.register_user.password_confirmation = null;
      };
    }
]);