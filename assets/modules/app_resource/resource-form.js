(function () {

    const common = new Common();
    common.setTitle("Resource");
    // declare dom
    let uiForm = $("#fm-resource");
    let uiBtnCancel = $("#btn-cancel-form");
    let uiSelectRole = $("#role-id");
    // define from *-content.js
    let param = common.getCookie("module.resource.update");
    let isUpdate = param !== undefined; // flag create update

    setupFormUI();
    initialize();
    initializeParam();

    function initialize() {
        let url = param === undefined ? common.baseURL("app_resource/create") : common.baseURL("app_resource/update");
        uiForm.initForm({
            url: url,
            param: param,
            directUrl: "app_resource",
            beforeSubmit: function (form, options) {
                if (param !== undefined) {
                    form.push({name: 'resource_id', value: param.resource_id});
                }
                return true; // MANDATORY!
            }
        });
    }

    function initializeParam() {
        common.loading();
        let resolver = new HttpResolver();
        let param = new Filter();
        $.when(
            $.post(common.baseURL("app_role/load"), param.build()),
        ).done(function (data, textStatus, jqXHR) {
            console.log("done");
        }).then(function (r1, r2) {
            common.loadingClose();
            setupForm(r1);
        }).fail(resolver.fail);
    }

    function setupFormUI() {
        uiBtnCancel.click(function () {
            common.direct("app_resource");
        });
        uiSelectRole.select2({
            placeholder: 'Select role'
        });
    }

    function setupForm(r1, r2) {
        let rows = r1.rows;
        uiSelectRole.select2({
            data: $.map(rows, function (o) {
                o.id = o.role_id; // replace name with the property used for the text
                o.text = o.role_name; // replace name with the property used for the text
                return o;
            }),
        });
        if (isUpdate) {
            uiSelectRole.val(param.role_id).trigger('change');
            $("input[name='username']").attr("disabled", true);
            $("input[name='password']").attr("disabled", true);
        }
    }

})();