function setImageClickFunction(){
    var imgs = document.getElementsByTagName("img");
    for (var i=0;i<imgs.length;i++){
        var src = imgs[i].src;
        imgs[i].setAttribute("onClick","click(src)");
    }
    document.location = imgs;
}

function click(src){
    var url="ClickImage:"+src;
    document.location = url;
}