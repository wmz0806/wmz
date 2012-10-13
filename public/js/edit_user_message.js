/**
 * Created with JetBrains RubyMine.
 * User: Administrator
 * Date: 12-5-16
 * Time: 下午3:14
 * To change this template use File | Settings | File Templates.
 */
function init(){
    format($("#real_name"), 'real_name', 1);
    format($("#sex"), 'sex', 3);
    format($("#age"), 'age', 1);
    $("#head_img_div").show("500");
    birthday_initialize();

    format($("#address"), 'address', 1);
    format($("#info"), 'info', 2);

    $("#a").empty();
    $("#none_div").css("display", "block");
}

function format(obj, attr, type){
   var html_str=obj.html();
    if (type==1){
        obj.html("<input type='text' name='user["+attr+"]' value='"+html_str+"'/>")
    }else if(type==2){
        obj.html("<textarea rows='8' cols='80' name='user["+attr+"]'>"+html_str+"</textarea>")
    }else if (type==3){
        var opt_str;
        if(html_str=='男'){
            opt_str="<option value='1' selected='selected'>男</option><option value='0'>女</option>"
        }else{
            opt_str="<option value='1'>男</option><option value='0' selected='selected'>女</option>"
        }
        obj.html("<select name='user["+attr+"]'>"+opt_str+"</select>")
    }
}

function  birthday_initialize(){
    var y_str = $("#birthday_y").html();
    var m_str = $("#birthday_m").html();
    var d_str = $("#birthday_d").html();
    var c_year = new Date().getFullYear();
    var year_str="";
    var month_str="";
    var day_str="";
    for(var i=1950;i<=c_year;i++){
        if(i==y_str){
            year_str+="<option selected='selected' value='"+i+"'>"+i+"</option>";
        }else{
            year_str+="<option value='"+i+"'>"+i+"</option>";
        }
    }
    for(var i=1;i<=12;i++){
        if(i==m_str){
            month_str+="<option selected='selected' value='"+i+"'>"+i+"</option>";
        }else{
            month_str+="<option value='"+i+"'>"+i+"</option>";
        }
    }

    for(var i=1;i<=31;i++){
        if(i==d_str){
            day_str+="<option selected='selected' value='"+i+"'>"+i+"</option>";
        }else{
            day_str+="<option value='"+i+"'>"+i+"</option>";
        }
    }
    $("#birthday_y").html("<select name='year' id='year' onchange='birthday_format();'>"+year_str+"</select>");
    $("#birthday_m").html("<select name='month' id='month' onchange='birthday_format();'>"+month_str+"</select>");
    birthday_format( d_str);
}

function  birthday_format(d_str){
    var y_str = $("#year").val();
    var m_str = $("#month").val();

    var c_d=return_month_day(y_str, m_str);
    var day_str="";
    for(var i=1;i<=c_d;i++){
        if(i==d_str || i==$("#day").val()){
            day_str+="<option selected='selected' value='"+i+"'>"+i+"</option>";
        }else{
            day_str+="<option value='"+i+"'>"+i+"</option>";
        }
    }
    $("#birthday_d").html("<select name='day' id='day'>"+day_str+"</select>");


}

function judge_leap_year(year){
   return  ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) ? true : false;
}

function return_month_day(y_str, month){
    if(month==1 || month==3 || month==5 || month==7 || month==8 || month==10 || month==12){
        return 31;
    }else if(month==4 || month==6 || month==9 || month==11){
        return 30;
    }else{
       return  judge_leap_year(y_str) ? 29 : 28;
    }
}
