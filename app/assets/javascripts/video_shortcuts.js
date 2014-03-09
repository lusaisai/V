/**
 * Created by lusaisai on 14-3-9.
 */
(function(){
    $(document).keydown( function(e){
        var video = $('video')[0];
        var code = e.which;
        console.log(code);

        if(video) e.preventDefault();

        // space
        if( code == 32 ) {
            if(video.paused) {
                video.play();
            } else {
                video.pause();
            }
        }

        // right arrow
        var progressStep = 10;
        if( code == 39 ) {
            var target = video.currentTime + progressStep;
            video.currentTime =  target <= video.duration ? target : video.duration;
        }

        // left arrow
        if( code == 37 ) {
            var target = video.currentTime - progressStep;
            video.currentTime =  target >= 0 ? target : 0;
        }

        // up arrow
        var volumeStep = 0.05;
        if(  code == 38 ) {
            var target = video.volume + volumeStep;
            video.volume =  target <= 1 ? target : 1;
        }

        //down arrow
        if(  code == 40 ) {
            var target = video.volume - volumeStep;
            video.volume =  target >= 0 ? target : 0;
        }
    });
})();