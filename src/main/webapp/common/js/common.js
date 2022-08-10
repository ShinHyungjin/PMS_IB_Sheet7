 try{top.D_$_ = null}catch(e){}; 
function detectmob() { 
 if( navigator.userAgent.match(/Android/i)
 || navigator.userAgent.match(/webOS/i)
 || navigator.userAgent.match(/iPhone/i)
 || navigator.userAgent.match(/iPad/i)
 || navigator.userAgent.match(/iPod/i)
 || navigator.userAgent.match(/BlackBerry/i)
 || navigator.userAgent.match(/Windows Phone/i)
 ){
    return true;
  }
 else {
    return false;
  }
}
document.write("<link rel='stylesheet' href='../../common/css/style.css'/>");
if(detectmob()){
	document.write("<script type='text/javascript' charset='utf-8' src='../../common/js/jquery.mobile-1.3.2.js'></script>");
}else{
	document.write("<script type='text/javascript' charset='utf-8' src='../../common/js/jquery-1.7.2.min.js'></script>");
	
}
//ibsheet7 license check file.
document.write("<script type='text/javascript' charset='utf-8' src='../../license/ibleaders.js'></script>");

document.write("<script type='text/javascript' charset='utf-8' src='../../common/js/jquery.cookie.js'></script>");
document.write("<script type='text/javascript' charset='utf-8' src='../../common/js/jquery.treeview.js'></script>");
document.write("<script type='text/javascript' charset='utf-8' src='../../common/js/jquery.easing.1.3.js'></script>");
document.write("<script type='text/javascript' charset='utf-8' src='../../common/js/iepngfix_tilebg.js'></script>");
document.write("<script type='text/javascript' charset='utf-8' src='../../common/js/contact.js'></script>");
document.write("<script type='text/javascript' charset='utf-8' src='../../common/js/debounce.js'></script>");
document.write("<script type='text/javascript' charset='utf-8' src='../../common/js/etc.js'></script>");



