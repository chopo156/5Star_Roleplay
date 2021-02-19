$(function() {
	window.addEventListener('message', function(event) {
		if (event.data.type === "openAtm"){
			$('#atm').show();
			document.getElementById("input_pin").style.backgroundColor = "rgba(56, 56, 56, 0.900)";
			document.getElementById("input_pin_1").style.backgroundColor = "rgba(56, 56, 56, 0.900)";
			document.getElementById("input_pin_2").style.backgroundColor = "rgba(56, 56, 56, 0.900)";
			document.getElementById("input_pin_3").style.backgroundColor = "rgba(56, 56, 56, 0.900)";
		} 
		else if (event.data.type === "openBank"){
			$('#main').show();
		} 
		else if (event.data.type === "close"){
			$('#atm, #main, #nav_bar, #info, #deposit, #withdraw, #transfer').hide();
		} 
		else if (event.data.type === "closeAll"){
			$('#atm, #main, #nav_bar, #info, #deposit, #withdraw, #transfer').hide();
		}
		else if(event.data.type === "name"){
			$('.player').html(event.data.text);
		}
		else if(event.data.type === "balance"){
			$('.bal').html(event.data.text);
		}
	});
});
/* ############# toogle off ui #############*/
/*#############################################*/
$(document).keydown(function(e) {
    /* banking toggle handler */ 
    if (e.keyCode == 27) {
        $.post("http://vrp_banking/NUIFocusOff", JSON.stringify({}));
	}
});
/* #############  submit function ############# */
/*#############################################*/
/* #############  Deposit ############# */
$("#i_deposit").submit(function(e) {
	e.preventDefault(); // Prevent form from submitting
	$.post('http://vrp_banking/deposit', JSON.stringify({
		amountd: $("#amountd").val()
	}));
	$('#atm, #main, #nav_bar, #info, #deposit, #withdraw, #transfer, #home').hide();
	$('#nav_bar, #info').show();
	document.getElementById("sign-out").style.marginLeft = "50%";
	$("#amountd").val('');
});
/* #############  Withdraw ############# */
$("#i_withdraw").submit(function(e) {
	e.preventDefault(); // Prevent form from submitting
	$.post('http://vrp_banking/withdraw', JSON.stringify({
		amountw: $("#amountw").val()
	}));
	$('#atm, #main, #nav_bar, #info, #deposit, #withdraw, #transfer, #home').hide();
	$('#nav_bar, #info').show();
	document.getElementById("sign-out").style.marginLeft = "50%";
	$("#amountw").val('');
});

/*click functions */
/*#############################################*/
$(function()
{
	var input_d 		= document.getElementById('amountd');
	var input_w 		= document.getElementById('amountw');
/* ################## atm login ################## */	
	var login_btn 		= document.getElementById('login_btn');
/* ################## buttons/toggles ################## */	
	var fingerprint 	= document.getElementById('fingerprint-content');
/* ################## Nav ################## */	
	var sign_out		= document.getElementById('sign-out');
	var home			= document.getElementById('home');
/* ################## status/info screen ################## */
	var deposit 		= document.getElementById('deposit');
	var withdraw 		= document.getElementById('withdraw');
	var transfer 		= document.getElementById('transfer');
/* ################## Deposit Buttons ################## */
	var d_confirm		= document.getElementById('d_confirm');
	var d_clear			= document.getElementById('d_clear');
/* ################## Withdraw Buttons ################## */
	var w_confirm		= document.getElementById('w_confirm');
	var w_clear			= document.getElementById('w_clear');
/* ################## Transfer Buttons ################## */

	input_d.addEventListener('keydown', function(e) {
		if (e.keyCode === 13) {
			e.preventDefault();
			document.getElementById("d_confirm").click();
		}
	});
	input_w.addEventListener('keydown', function(e) {
		if (e.keyCode === 13) {
			e.preventDefault();
			document.getElementById("w_confirm").click();
		}
	});
/*########################################################*/
	login_btn.addEventListener('click', function(e) {
		setTimeout(function(){
			document.getElementById("input_pin").style.backgroundColor = " rgba(184, 184, 184, 0.9)";
		}, 400);
		setTimeout(function(){
			document.getElementById("input_pin_1").style.backgroundColor = "rgba(184, 184, 184, 0.9)";
		}, 500);
		setTimeout(function(){
			document.getElementById("input_pin_2").style.backgroundColor = "rgba(184, 184, 184, 0.9)";
		}, 600);
		setTimeout(function(){
			document.getElementById("input_pin_3").style.backgroundColor = "rgba(184, 184, 184, 0.9)";
		}, 700);
		setTimeout(function(){
			$('#atm, #home').hide();
			document.getElementById("sign-out").style.marginLeft = "50%";
			$('#nav_bar, #info').show();
		}, 1400);
	});
/* ############# fingerprint click/animation ############# */	
	fingerprint.addEventListener('click', function(e) {
		$('.fingerprint-active, .fingerprint-bar').addClass("active")
		setTimeout(function(){
			$('#main, #home').hide();
			document.getElementById("sign-out").style.marginLeft = "50%";
			$('.fingerprint-active, .fingerprint-bar').removeClass("active")
			$('#nav_bar, #info').show();
		}, 1400);
	});
/*########################################################*/
/* ################## Nav ################## */	
	sign_out.addEventListener('click', function(e) {
		$('#atm, #main, #nav_bar, #info, #deposit, #withdraw, #transfer').hide();
		$.post("http://vrp_banking/NUIFocusOff", JSON.stringify({}));
	});
	home.addEventListener('click', function(e) {
		$('#atm, #main, #nav_bar, #info, #deposit, #withdraw, #transfer, #home').hide();
		document.getElementById("sign-out").style.marginLeft = "50%";
		$('#nav_bar, #info').show();
	});
/*########################################################*/
/* ################## status/info buttons ################## */
	deposit_btn.addEventListener('click', function(e) {
		$('#nav_bar, #deposit, #home').show();
		document.getElementById("sign-out").style.marginLeft = "10%";
		$('#atm, #main, #info, #withdraw, #transfer').hide();
	});
	withdraw_btn.addEventListener('click', function(e) {
		$('#nav_bar, #withdraw, #home').show();
		document.getElementById("sign-out").style.marginLeft = "10%";
		$('#atm, #main, #info, #deposit, #transfer').hide();
	});
	transfer_btn.addEventListener('click', function(e) {
		$('#nav_bar, #transfer, #home').show();
		document.getElementById("sign-out").style.marginLeft = "10%";
		$('#atm, #main, #info, #deposit, #withdraw').hide();
	});
/*########################################################*/
/* ################## Deposit Buttons ################## */
	d_confirm.addEventListener('click', function(e) {
		e.preventDefault(); // Prevent form from submitting
		$.post('http://vrp_banking/deposit', JSON.stringify({
			amountd: $("#amountd").val()
		}));
		$('#atm, #main, #nav_bar, #info, #deposit, #withdraw, #transfer, #home').hide();
		$('#nav_bar, #info').show();
		document.getElementById("sign-out").style.marginLeft = "50%";
		$("#amountd").val('');
	});
	d_clear.addEventListener('click', function(e) {
		$("#amountd").val('');
	});
/*########################################################*/
/* ################### Withdraw Buttons ################## */
	w_confirm.addEventListener('click', function(e) {
		e.preventDefault(); // Prevent form from submitting
		$.post('http://vrp_banking/withdraw', JSON.stringify({
			amountw: $("#amountw").val()
		}));
		$('#atm, #main, #nav_bar, #info, #deposit, #withdraw, #transfer, #home').hide();
		$('#nav_bar, #info').show();
		document.getElementById("sign-out").style.marginLeft = "50%";
		$("#amountw").val('');
	});
	w_clear.addEventListener('click', function(e) {
		$("#amountw").val('');
	});
});

/*########################################################*/
/* ################ particle effects ##################### */
$(function() {
	window.addEventListener('message', function(event) {
		if (event.data.type === "snow"){
			$('#snow').show();
			document.getElementById("snow").style = "display: show;";
			var script = document.createElement('script');
			script.src = 'https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js';
			script.onload = function(){
				particlesJS("snow", {
					"particles": {
						"number": {
							"value": 200,
							"density": {
								"enable": true,
								"value_area": 800
							}
						},
						"color": {
							"value": "#ffffff"
						},
						"opacity": {
							"value": 0.7,
							"random": false,
							"anim": {
								"enable": false
							}
						},
						"size": {
							"value": 5,
							"random": true,
							"anim": {
								"enable": false
							}
						},
						"line_linked": {
							"enable": false
						},
						"move": {
							"enable": true,
							"speed": 5,
							"direction": "bottom",
							"random": true,
							"straight": false,
							"out_mode": "out",
							"bounce": false,
							"attract": {
								"enable": true,
								"rotateX": 300,
								"rotateY": 1200
							}
						}
					},
					"interactivity": {
						"events": {
							"onhover": {
								"enable": false
							},
							"onclick": {
								"enable": false
							},
							"resize": false
						}
					},
					"retina_detect": true
				});
			}
			document.head.append(script);
		}
		else if (event.data.type === "stopHoliday"){
			$('#snow').hide();
			document.getElementById("snow").style = "display: none;";
		} 
	});
});
