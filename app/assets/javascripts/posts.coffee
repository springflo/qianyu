# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
@praiseReplay=(thumbTag)->
    if(thumbTag.className == "fa fa-thumbs-up")
      thumbTag.className = "fa fa-thumbs-o-up"
      thumbTag.innerHTML = " " + (thumbTag.innerHTML.match(/\d+/)-1);
    else
      thumbTag.className = "fa fa-thumbs-up"
      # 写成+1会编译成字符串连接
      thumbTag.innerHTML = " " + (thumbTag.innerHTML.match(/\d+/)-(-1));
      
      
# @outIn=(comment_id,reply_id)->
#       var coReply,coA;
#       //coReply为回复框对象
#       coReply = document.getElementById("co-reply" + comment_id)
#       //coA为回复a标签对象
#       coA = document.getElementById("reply" + reply_id)
#       if(coReply.style.display == "none")
#         coReply.style.display = "block"
#         coA.innerHTML = "取消回复"

#       else
#         coReply.style.display = "none"
#         coA.innerHTML = "回复"
      


      
      
