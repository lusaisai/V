(function(){
    var current = 0;
    var total; // total video count
    var line; // video count in a line

    var moveto_relative = function(offset) {
        if( current == 0 || current + offset < 1 ) {
            current = 1;
        } else if ( current + offset > total ) {
            current = total;
        } else {
            current += offset;
        }

        highlight_current();
    };

    var highlight_current = function(){
        $( "div[data-seq]").removeClass('current');
        var JCurr = $( "div[data-seq=" + current + "]");
        JCurr.addClass('current');

        //scroll into view
        var scroll = $( "body").scrollTop();
        var abs_top = JCurr.position().top;
        var abs_bottom = JCurr.position().top + JCurr.height();
        if ( abs_top-scroll < 0 || abs_bottom-scroll > window.innerHeight ) {
            $('body').animate({ scrollTop: abs_top - ( window.innerHeight - JCurr.height() )/2 });
        }
    };

    var up = function(){ moveto_relative(-1 * line); };
    var down = function(){ moveto_relative( line); };
    var right = function(){ moveto_relative(1); };
    var left = function(){ moveto_relative(-1); };

    $(document).keydown(function (e) {
        var video = $('video')[0];
        var code = e.which;
        if (video) return;

        // right arrow
        if (code == 39) {
            e.preventDefault();
            right();
        }
        // left arrow
        if (code == 37) {
            e.preventDefault();
            left();
        }
        // down arrow
        if (code == 40) {
            e.preventDefault();
            down();
        }
        // up arrow
        if (code == 38) {
            e.preventDefault();
            up();
        }

        // Enter play
        if (code == 13) {
            e.preventDefault();
            $("div[data-seq=" + current + "] a").trigger('click');
        }

    });

    var calc = function(){
        current = 0;
        total = $( "div[data-seq]").length; // total video count
        line = Math.floor( $('#video-list').width() / 370 ); // video count in a line
    };
    $(document).on("ready page:load ", calc);
    $( window ).resize(calc);

}());
