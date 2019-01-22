function outInComment(comment_id){
    //coReply为回复框对象
    var coReply = document.getElementById("co-comment" + comment_id);
    //coA为回复a标签对象
    var coA = document.getElementById("comment" + comment_id);
    if(coReply.style.display == "none"){
    coReply.style.display = "block";
    coA.innerHTML = "取消回复";
    }
    else{
    coReply.style.display = "none";
    coA.innerHTML = "回复";
    }
}


function outInReply(reply_id){
    //coReply为回复框对象
    var coReply = document.getElementById("co-reply" + reply_id);
    //coA为回复a标签对象
    var coA = document.getElementById("reply" + reply_id);
    if(coReply.style.display == "none"){
    coReply.style.display = "block";
    coA.innerHTML = "取消回复";
    }
    else{
    coReply.style.display = "none";
    coA.innerHTML = "回复";
    }
}


function addPoint(oldA){
  var href = oldA.href;
  var arr_point = href.split("/")[6];
  oldA.href = href.substring(0, href.length - 1) + (parseInt(arr_point)+ 1);
}
