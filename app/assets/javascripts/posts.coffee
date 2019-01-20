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
      
      
