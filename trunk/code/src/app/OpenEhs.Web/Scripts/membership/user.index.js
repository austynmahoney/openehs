﻿/// <reference path="../jquery-1.4.4.js" />
/// <reference path="../jquery-ui.js" />


$(document).ready(function () {
    $("#SearchTerm").val("Search").addClass("blurSearchTextbox");

    $("#SearchTerm").focus(function () {
        $("#SearchTerm").removeClass("blurSearchTextbox");
        $("#SearchTerm").addClass("focusSearchTextbox");
        $("#SearchTerm").val("");
    });

    $("#SearchTerm").blur(function () {
        $("#SearchTerm").removeClass("focusSearchTextbox");
        $("#SearchTerm").addClass("blurSearchTextbox");
        $("#SearchTerm").val("Search");
    });

    $("#SelectedRole").change(function (data) {
        alert($("#SelectedRole option:selected").val() + " selected!");
    });

    $("#UserList tbody tr:odd").addClass("striped");

    $("#UserList tbody tr").click(function () {
        var href = $(this).find("a").attr("href");

        if (href) {
            window.location = href;
        }
    });

    $("#NewUserButton").click(function () {
        window.location = "/Account/Register";
    });

    $(".approvedCheckbox").click(function (event) {
        var id = 0;
        event.stopPropagation();
        if ($(this).is(":checked")) {
            // Approve the user.
            $.post("/User/ApproveUser/" + id, function (data) {
                alert("Success: " + data);
            });
        }
    });
});