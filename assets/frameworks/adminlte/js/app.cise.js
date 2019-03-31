/*
* table of content
* - commons
* - form
* - model
* - filter
*
*
* */

// commons
(function ($) {

    Common = function () {

    };

    Common.prototype.setTitle = function (title) {
        document.title = (title !== undefined ? title : "");
    };

    // covert from json to object
    Common.prototype.fromJson = function (json) {
        return json === undefined ? json : JSON.parse(json);
    };

    // covert from object to json
    Common.prototype.toJson = function (value) {
        return value === undefined ? value : JSON.stringify(value);
    };

    // cookies
    Common.prototype.setCookie = function (key, val) {
        // Cookies.set(key, val, {expires: 1});
        Cookies.set(key, val);
    };

    Common.prototype.getCookie = function (key) {
        return this.fromJson(Cookies.get(key));
    };

    Common.prototype.removeCookie = function (key) {
        Cookies.remove(key);
    };

    // delete dialog
    Common.prototype.dialogDelete = function (callback) {
        $.confirm({
            title: 'Confirmation!',
            content: 'Are you sure delete this row?',
            buttons: {
                confirm: {
                    btnClass: 'btn-red',
                    action: callback
                },
                cancel: function () {
                    $.alert('Delete cancel!');
                }
            }
        });
    };

    // loader
    Common.prototype.loading = function () {
        $.alert({
            lazyOpen: true,
            title: 'Loading... ',
            content: "Loading... ",
            columnClass: 'col-md-2 col-md-offset-5 col-xs-3 col-xs-offset-5',
            //containerFluid: true,
            isAjax: true,
            buttons: {
                confirm: function () {
                    $.alert('Confirmed!');
                },
                close: function () {

                    $.alert('Canceled!');
                }
            }
        });

    };

    Common.prototype.loadingClose = function () {
        $("div.jconfirm").remove();
    }

    // url
    Common.prototype.baseURL = function (path = "") {
        let base_url = window.location.origin;
        let pathArray = window.location.pathname.split("/");
        return base_url + "/" + pathArray[1] + "/" + path;
    };

    Common.prototype.direct = function (path = "") {
        window.location = this.baseURL(path);
    };

    // http
    Common.prototype.get = function (url, callback) {
        $.getJSON(url, callback);
    };

    Common.prototype.post = function (url, data, callback) {
        $.post(url, JSON.stringify(data), callback, "json");
    };

    Common.prototype.removeFilter = function (names) {
        names.forEach(function (value, index, arr) {
            $("input[name='" + value + "'].datagrid-filter").remove();
        });
    }

    Common.prototype.replaceGridFilterPrefix = function (form, pref) {
        if (form.filterRules !== undefined) {
            let rows = JSON.parse(form.filterRules);
            let result = [];
            rows.forEach(function (value, index, arr) {
                value.field = pref + "." + value.field;
                result.push(value);
            });
            form.filterRules = JSON.stringify(result);
        }
        return form;
    };


    Common.prototype.replaceGridFilter = function (form, names, alias) {
        if (form.filterRules !== undefined) {
            let rows = JSON.parse(form.filterRules);
            let result = [];
            rows.forEach(function (value, index, arr) {
                for (var i = 0; i < names.length; i++) {
                    if (value.field === names[i]) {
                        value.field = alias[i];
                        break;
                    }
                }
                result.push(value);
            });
            form.filterRules = JSON.stringify(result);
        }
        return form;
    }

}(jQuery));

// http
(function ($) {

    HttpResolver = function () {

    };

    HttpResolver.prototype.fail = function (data, textStatus, jqXHR) {
        $("div.jconfirm").remove();
        $.alert({
            title: textStatus + ", " + jqXHR,
            content: data.responseText,
            columnClass: 'col-xs-6 col-xs-offset-3 col-md-6 col-md-offset-3 col-sm-6 col-sm-offset-3',
            containerFluid: true
        });
    };

}(jQuery));

// form
(function ($) {

    const common = new Common();

    $.fn.initForm = function (options) {

        // Establish our default settings
        var settings = $.extend({
            //uiForm : null,
            url: null,
            param: {},
            rules: {},
            message: {},
            beforeSubmit: function (form, opt) {
                return true;
            },
            afterSuccess: null,
            directUrl: null,
            initEasyui: true
        }, options);

        if (settings.uiForm === null) {
            throw new Error('Form not defined');
        }
        if (settings.url === null) {
            throw new Error('Url not defined');
        }

        return this.each(function () {
            if (settings.initEasyui) {
                $(this).form('load', settings.param);
            }
            $(this).validate({
                // onfocusout: false,
                focusCleanup: false,
                rules: settings.rules,
                messages: settings.message,
                submitHandler: function (form) {
                    let loading = $.alert({
                        title: 'Loading... ',
                        content: "Loading... ",
                        columnClass: 'col-md-2 col-md-offset-5 col-xs-3 col-xs-offset-5',
                        containerFluid: true,
                        isAjax: true,
                        isAjaxLoading: true
                    });
                    $(form).ajaxSubmit({
                        url: settings.url,
                        dataType: 'json',
                        beforeSubmit: settings.beforeSubmit,
                        error: function showInfo(xhr, status, text) {
                            let htmlString = $.parseHTML(xhr.responseText);
                            $.alert({
                                title: xhr.status + ", " + text,
                                content: htmlString,
                                columnClass: 'col-xs-8 col-xs-offset-2 col-md-8 col-md-offset-2 col-sm-8 col-sm-offset-2',
                                containerFluid: true
                            });
                            loading.close();

                        },
                        success: function showResponse(text, status, xhr) {
                            let response = xhr.responseJSON;
                            if ((200 === response.code && null != settings.directUrl)) {
                                common.direct(settings.directUrl);
                            } else if (200 === response.code && null != settings.afterSuccess) {
                                settings.afterSuccess(response);
                            } else if (200 === response.code) {
                                console.warn("no action defined, or url redirect after success request not set!")
                            } else {
                                $.alert({
                                    title: 'Error ',
                                    content: status + " : " + xhr,
                                    columnClass: 'col-xs-8 col-xs-offset-2 col-md-8 col-md-offset-2 col-sm-8 col-sm-offset-2',
                                    containerFluid: true
                                });
                            }
                            loading.close();
                        }
                    });
                    return false;
                }
            });
        });
    }

}(jQuery));

// model filter rule
(function ($) {

    FilterRule = function (field, op, value) {
        this.field = field;
        this.op = operation(op);
        this.value = value;
    };

    function operation(op) {
        if ("=" === op) {
            return "equal";
        } else if ("!=" === op) {
            return "notequal";
        } else if (">" === op) {
            return "greater";
        } else if ("<" === op) {
            return "less";
        } else if (">=" === op) {
            return "greaterequal";
        } else if ("<=" === op) {
            return "lessequal";
        } else if ("like" === op) {
            return "contains";
        } else {
            return op;
        }
    }

}(jQuery));

// model filter rule
(function ($) {

    let value = {
        page: undefined,
        rows: undefined,
        sort: undefined,
        order: undefined,
        filterRules: undefined
    };
    //
    let filterRules = [];

    Filter = function () {

    };

    Filter = function (page, rows) {
        if (page !== undefined && isNaN(page) && page < 1) {
            throw "page number min 1"
        }
        if (rows !== undefined && isNaN(rows) && rows < 1) {
            throw "rows number min 1"
        }
        value.page = page;
        value.rows = rows;
        value.filterRules = JSON.stringify(filterRules);

    };

    Filter = function (page, rows, sort, order) {
        if (page !== undefined && isNaN(page) && page < 1) {
            throw "page number min 1"
        }
        if (rows !== undefined && isNaN(rows) && rows < 1) {
            throw "rows number min 1"
        }
        value.page = page;
        value.rows = rows;
        value.sort = sort;
        value.order = order;
        value.filterRules = JSON.stringify(filterRules);
    };

    Filter.prototype.add = function (field, op, value) {
        filterRules.push(new FilterRule(field, op, value));
    };

    Filter.prototype.build = function () {
        if (value.page === undefined) {
            delete value.page;
        }
        if (value.rows === undefined) {
            delete value.rows;
        }
        if (value.order === undefined) {
            delete value.order;
        }
        if (value.filterRules === undefined) {
            delete value.filterRules;
        } else {
            value.filterRules = JSON.stringify(filterRules);
        }
        return value;
    };


}(jQuery));
