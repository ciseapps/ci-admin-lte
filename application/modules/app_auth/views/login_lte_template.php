<div class="login-box">
    <div class="login-logo">
        <a href="#"><b>Base Apps</b> </a>
    </div>
    <!-- /.login-logo -->
    <div class="login-box-body">
        <p class="login-box-msg">(Base Applications)</p>
        <form id="login-form" method="post" action>
            <div class="form-group">
                <input type="username" name="username" class="form-control" placeholder="Username">

            </div>
            <div class="form-group">
                <input type="password" name="password" class="form-control" placeholder="Password">

            </div>
            <div class="row">
                <div class="col-xs-12">
                    <label id="error-login" class="error-login"></label>
                </div>
                <div class="col-xs-4">
                    <button type="submit" class="btn btn-primary btn-block btn-flat">Sign In</button>
                </div>
            </div>

        </form>
    </div>
</div>
<script>
    (function () {

        const common = new Common();
        let errorLabel = $("#error-login");
        let formLogin = $("#login-form");

        //errorLabel.hide();
        formLogin.initForm({
            url: common.baseURL("/app_auth/verify"),
            initEasyui: false,
            beforeSubmit: function(form, opt){
                errorLabel.text(null);
                return true;
            },
            afterSuccess: function (response) {
                let result = response.result;
                if (200 === result.status_login) {
                    location.replace(common.baseURL("app_menu"));
                } else {
                    errorLabel.text(result.message);
                    //errorLabel.show();
                }
            }
        });

    })()
</script>