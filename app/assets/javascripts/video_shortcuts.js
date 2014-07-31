/**
 * Created by lusaisai on 14-3-9.
 */
(function(){
    // notifications
    var hideSchedule;

    $(document).keydown( function(e){
        var video = $('video')[0];
        var code = e.which;

        if ( ! video ) return;

        // space
        if( code == 32 ) {
            e.preventDefault();
            if(video.paused) {
                video.play();
            } else {
                video.pause();
            }
        }

        // notifications
        var showNotifications = function(data){
            var JNote = $('#notifications');
            JNote.text(data);
            JNote.fadeIn();
            clearTimeout(hideSchedule);
            hideSchedule = setTimeout( function(){JNote.fadeOut();}, 2000 );
        };

        var showProgress = function(){
            var percentage = ( video.currentTime / video.duration * 100 ).toFixed(0) + '%';
            showNotifications( 'Progress: ' + percentage);
        };

        var showVolume = function(){
            var percentage = ( video.volume * 100 ).toFixed(0) + '%';
            showNotifications( 'Volume: ' + percentage);
        };

        // right arrow
        var progressStep = 8;
        if( code == 39 ) {
            e.preventDefault();
            var target = video.currentTime + progressStep;
            video.currentTime =  target <= video.duration ? target : video.duration;
            showProgress();
        }

        // left arrow
        if( code == 37 ) {
            e.preventDefault();
            var target = video.currentTime - progressStep;
            video.currentTime =  target >= 0 ? target : 0;
            showProgress();
        }

        // up arrow
        var volumeStep = 0.05;
        if( code == 38 ) {
            e.preventDefault();
            var target = video.volume + volumeStep;
            video.volume =  target <= 1 ? target : 1;
            showVolume();
        }

        //down arrow
        if(  code == 40 ) {
            e.preventDefault();
            var target = video.volume - volumeStep;
            video.volume =  target >= 0 ? target : 0;
            showVolume();
        }

        // f for fullscreen
        if ( code == 70 ) {
            if (!document.fullscreenElement &&    // alternative standard method
                !document.mozFullScreenElement && !document.webkitFullscreenElement && !document.msFullscreenElement ) {  // current working methods
                if (video.requestFullscreen) {
                    video.requestFullscreen();
                } else if (video.msRequestFullscreen) {
                    video.msRequestFullscreen();
                } else if (video.mozRequestFullScreen) {
                    video.mozRequestFullScreen();
                } else if (video.webkitRequestFullscreen) {
                    video.webkitRequestFullscreen(Element.ALLOW_KEYBOARD_INPUT);
                }
            } else {
                if (document.exitFullscreen) {
                    document.exitFullscreen();
                } else if (document.msExitFullscreen) {
                    document.msExitFullscreen();
                } else if (document.mozCancelFullScreen) {
                    document.mozCancelFullScreen();
                } else if (document.webkitExitFullscreen) {
                    document.webkitExitFullscreen();
                }
            }
        }
    });
})();