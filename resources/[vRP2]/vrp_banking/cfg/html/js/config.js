/* Config  for quick button ammounts */

$(function()
{
/* ############# Quick Deposit values ############# */
	var symbol =   "$ ";
	var deposit_1 = "100";
	var deposit_2 = "500";
	var deposit_3 = "1000";

/* ############# Quick withdraw values ############# */
	var withdraw_1 = "100";
	var withdraw_2 = "500";
	var withdraw_3 = "1000";

/* ############################################################# */
/* ################### Dont Change beyond this point ################# */

/* ############# Quick Deposit ############# */ 
	document.getElementById("d_1").innerHTML = symbol + deposit_1;
	document.getElementById("d_1").value = deposit_1;
	document.getElementById("d_1").style.color = "white";
	document.getElementById("d_1").style.fontSize = "x-large";

	document.getElementById("d_2").innerHTML = symbol + deposit_2;
	document.getElementById("d_2").value = deposit_2;
	document.getElementById("d_2").style.color = "white";
	document.getElementById("d_2").style.fontSize = "x-large";

	document.getElementById("d_3").innerHTML = symbol + deposit_3;
	document.getElementById("d_3").value = deposit_3;
	document.getElementById("d_3").style.color = "white";
	document.getElementById("d_3").style.fontSize = "x-large";

/* ############# Quick Withdraw ############# */
	document.getElementById("w_1").innerHTML = symbol + withdraw_1;
	document.getElementById("w_1").value = withdraw_1;
	document.getElementById("w_1").style.color = "white";
	document.getElementById("w_1").style.fontSize = "x-large";

	document.getElementById("w_2").innerHTML = symbol + withdraw_2;
	document.getElementById("w_2").value = withdraw_2;
	document.getElementById("w_2").style.color = "white";
	document.getElementById("w_2").style.fontSize = "x-large";

	document.getElementById("w_3").innerHTML = symbol + withdraw_3;
	document.getElementById("w_3").value = withdraw_3;
	document.getElementById("w_3").style.color = "white";
	document.getElementById("w_3").style.fontSize = "x-large";

/* ############# Quick Deposit variables ############# */ 
	var dp_1			= document.getElementById('d_1');
	var dp_2			= document.getElementById('d_2');
	var dp_3			= document.getElementById('d_3');
	
/* ############# Quick Withdraw variables ############# */	
	var wd_1			= document.getElementById('w_1');
	var wd_2			= document.getElementById('w_2');
	var wd_3			= document.getElementById('w_3');
	
/* ############# Quick Deposit handler #############*/ 	
	dp_1.addEventListener('click', function(e) {
		$.post('http://vrp_banking/deposit', JSON.stringify({
			amountd: $("#d_1").val()
		}));
	});
	dp_2.addEventListener('click', function(e) {
		$.post('http://vrp_banking/deposit', JSON.stringify({
			amountd: $("#d_2").val()
		}));
	});
	dp_3.addEventListener('click', function(e) {
		$.post('http://vrp_banking/deposit', JSON.stringify({
			amountd: $("#d_3").val()
		}));
	});
	
/* ############# Quick Withdraw handler ############# */
	wd_1.addEventListener('click', function(e) {
		$.post('http://vrp_banking/withdraw', JSON.stringify({
			amountw: $("#w_1").val()
		}));
	});
	wd_2.addEventListener('click', function(e) {
		$.post('http://vrp_banking/withdraw', JSON.stringify({
			amountw: $("#w_2").val()
		}));
	});
	wd_3.addEventListener('click', function(e) {
		$.post('http://vrp_banking/withdraw', JSON.stringify({
			amountw: $("#w_3").val()
		}));
	});
});