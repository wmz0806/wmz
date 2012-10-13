// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require kindeditor


var s1;
var s2;
var s3;
var s4;
function chageUsername(obj){
    var reg=/^[a-zA-z][a-zA-z0-9]{5,11}$/;
    var usernameValue=obj.attr("value");
    s1=$("#s1");
    if(reg.test(usernameValue)){
        s1.load("/ajax/verification_username?username="+usernameValue);
    }else{
        s1.html("用户名格式错误！");
    }
}

function chagePWD(obj){
    var reg=/^[a-zA-z0-9]{6,12}$/;
    var pwdValue=obj.attr("value");
    s2=$("#s2");

    if(reg.test(pwdValue)){
        s2.html("密码格式正确！");
        if(s3!=undefined){
            chageAPWD($("#repeat_password"));
        }
    }else{
        s2.html("密码格式错误！");
    }
}

function chageAPWD(obj){
    var pwdValue=$("#user_password").attr("value");
    var apwdValue=obj.attr("value");
    s3=$("#s3");

    if(pwdValue!=""){
        if(pwdValue == apwdValue){
            s3.html("两次输入密码正确！");
        }else{
            s3.html("两次输入密码错误！");
        }
    }else{
        s3.html("密码未填！");
    }
}

function chageEmail(obj){
    var reg=/^[a-zA-Z\d_\.\-]{6,12}@[a-zA-Z\d\-]{2,6}\.(com||cn)$/;
     var emailValue=obj.attr("value");
    s4=$("#s4");

    if(reg.test(emailValue)){
        s4.html("邮箱格式正确！");
    }else{
        s4.html("邮箱格式错误！");
    }
}

function submitAll(){
    if(s1 && s2 && s3&&s4){
        var s1v=s1.html();
        var s2v=s2.html();
        var s3v=s3.html();
        var s4v=s4.html()
        if(s1v=="用户名可用！"){
            if(s2v=="密码格式正确！"){
                if(s3v=="两次输入密码正确！"){
                    if(s4v=="邮箱格式正确！"){
                       $("#new_user")[0].submit();
                    }else{
                      alert(s4v);
                    }
                 }else{
                    alert(s3v);
                }
            }else{
                alert(s2v);
            }
        }else{
            alert(s1v);
        }
    }
}

