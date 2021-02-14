var currentCode = "";
var audioPlayer = null;

$(document).ready(function(){  

    if (audioPlayer != null) {
        audioPlayer.pause();
    }

    audioPlayer = new Howl({src: ["numField.mp3"]});
    audioPlayer.volume(50.0);
    
    $("#key1").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "1";
    }); 
    $("#key2").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "2";
    }); 
    $("#key3").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "3";
    }); 
    $("#key4").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "4";
    }); 
    $("#key5").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "5";
    }); 
    $("#key6").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "6";
    }); 
    $("#key7").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "7";
    }); 
    $("#key8").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "8";
    }); 
    $("#key9").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "9";
    }); 
    $("#key0").click(function(){
        audioPlayer.play();
        currentCode = currentCode + "0";
    }); 

    $("#keyCancel").click(function(){
        audioPlayer.play();
        $('body').css('display', "none")
        $.post('http://vrp_doorlock/escape', JSON.stringify({}));
    }); 

    $("#keyClear").click(function(){
        audioPlayer.play();
        currentCode = "";
    });

    $("#keyEnter").click(function(){
        audioPlayer.play();
        $.post('http://vrp_doorlock/try', JSON.stringify({
            code: currentCode
        }));

        currentCode = "";        
    });

    window.addEventListener('message', function(event) {
        var data = event.data;
        currentCode = "";
        
        if (event.data.type == "enableui") {
            $('body').css('display', event.data.enable ? "block" : "none")
        }
    });
});