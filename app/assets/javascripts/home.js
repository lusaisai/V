$(document).on("page:change", function(){

    $('div.unit').hover(
        function(){
            $(this).find('.info').slideDown();
        },
        function() {
            $(this).find('.info').slideUp();
        }
    );

    $("img.lazy").lazyload({
        effect : "fadeIn"
    });


});
