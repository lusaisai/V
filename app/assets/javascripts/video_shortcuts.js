/**
 * Created by lusaisai on 14-3-9.
 */
(function(){
    $(document).keydown( function(e){
        var video = $('video')[0];
        var code = e.which;

        // space
        if( video && code == 32 ) {
            e.preventDefault();
            if(video.paused) {
                video.play();
            } else {
                video.pause();
            }
        }

        // right arrow
        var progressStep = 10;
        if( video && code == 39 ) {
            e.preventDefault();
            var target = video.currentTime + progressStep;
            video.currentTime =  target <= video.duration ? target : video.duration;
        }

        // left arrow
        if( video && code == 37 ) {
            e.preventDefault();
            var target = video.currentTime - progressStep;
            video.currentTime =  target >= 0 ? target : 0;
        }

        // up arrow
        var volumeStep = 0.05;
        if( video && code == 38 ) {
            e.preventDefault();
            var target = video.volume + volumeStep;
            video.volume =  target <= 1 ? target : 1;
        }

        //down arrow
        if( video &&  code == 40 ) {
            e.preventDefault();
            var target = video.volume - volumeStep;
            video.volume =  target >= 0 ? target : 0;
        }
    });
})();