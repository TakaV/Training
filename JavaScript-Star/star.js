window.requestAnimationFrame = (function(){
    return window.requestAnimationFrame ||
        window.webkitRequestAnimationFrame ||
        window.mozRequestAnimationFrame ||
        window.oRequestAnimationFrame ||
        window.msRequestAnimationFrame ||
        function(callback, element){
            window.setTimeout(callback, 1000 / 60);
        };
})();

var star1, star2, star3, star4, star5;
$(function() {
    star1 = $("#star1");
    star2 = $("#star2");
    star3 = $("#star3");
    star4 = $("#star4");
    star5 = $("#star5");
});

var mouseStalker = function (event) {
    var starIds = [ star1, star2, star3, star4, star5 ];

    var addPoint = 0;
    for (var i = 0; i < starIds.length; ++i) {
        starIds[i].css("left", event.pageX + addPoint).css("top", event.pageY + addPoint);
        addPoint += 15;
    }
}

var moveStar = function(event) {
    _.delay(function() {
        mouseStalker(event)
    }, 200);
    //setTimeout(function() {
    //    mouseStalker(event)
    //}, 200);
    //requestAnimationFrame(function() {
    //    mouseStalker(event)
    //}, 200);
};

$(document).on('mousemove', moveStar);
