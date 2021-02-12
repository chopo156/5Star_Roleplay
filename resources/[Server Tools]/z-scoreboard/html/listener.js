/* Need Help? Join my discord @ discord.gg/yWddFpQ */ 
$(function()
{
    window.addEventListener('message', function(event)
    {
        var data = event.data;
        var wrap = $('#wrap');
        wrap.find('table').append("<tr style='text-allign: center;' class=\"heading\"><th>ID</th><th>Name</th></tr>");
        if (data.meta && data.meta == 'close')
        {
            document.getElementById("ptbl").innerHTML = "";
            $('#wrap').hide();
            return;
        }
        wrap.find('table').append(data.text);
        $('#wrap').show();
    }, false);
});
