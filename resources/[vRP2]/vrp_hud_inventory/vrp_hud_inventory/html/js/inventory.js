var type = "normal";
var chestname = "";
var max_weight = 0.0;

window.addEventListener("message", function (event) {
    if (event.data.action == "display") {
        type = event.data.type

        if (type === "normal") {
            $(".info-div").hide();
        } else if (type === "trunk") {
            $(".info-div").show();
        }

        $(".ui").fadeIn();
    } else if (event.data.action == "hide") {
		$("#dialog").dialog("close");
        $(".ui").fadeOut();
        $(".item").remove();
        $("#otherInventory").html("<div id=\"noSecondInventoryMessage\"></div>");
        $("#noSecondInventoryMessage").html(invLocale.secondInventoryNotAvailable);
    } else if (event.data.action == "setItems") {
        inventorySetup(event.data.itemList);

        $('.item').draggable({
            helper: 'clone',
            appendTo: 'body',
            zIndex: 99999,
            revert: 'invalid',
            start: function (event, ui) {
                $(this).css('background-image', 'none');
                itemData = $(this).data("item");
				if (itemData.usetxt != "") {
					$("#use").text(itemData.usetxt);
				}
				else {
					$("#use").addClass("disabled");
				}

                if (!itemData.canRemove) {
                    $("#drop").addClass("disabled");
                    $("#give").addClass("disabled");
                }

                if (!itemData.usable) {
                    $("#use").addClass("disabled");
                }
            },
            stop: function () {
                itemData = $(this).data("item");
                
                if (/zaino/.test(itemData.name)) {
                    $(this).css('background-image', 'url(\'img/items/' + "zaino" + '.png\'');
                } else if(/patente/.test(itemData.name)) {
                    $(this).css('background-image', 'url(\'img/items/' + "patente" + '.png\'');
                } else if(/bank_cards/.test(itemData.name)) {
                    $(this).css('background-image', 'url(\'img/items/' + "bank_cards" + '.png\'');
                } else{
                    $(this).css('background-image', 'url(\'img/items/' + itemData.name + '.png\'');
                } 
                $("#drop").removeClass("disabled");
                $("#use").removeClass("disabled");
                $("#give").removeClass("disabled");
				$("#use").text("Use");
            }
        });
    } else if (event.data.action == "setSecondInventoryItems") {
        secondInventorySetup(event.data.itemList);
		$('.item').draggable({
            helper: 'clone',
            appendTo: 'body',
            zIndex: 99999,
            revert: 'invalid',
            start: function (event, ui) {
                $(this).css('background-image', 'none');
                itemData = $(this).data("item");
				$("#drop").addClass("disabled");
				$("#give").addClass("disabled");
				$("#use").addClass("disabled");
            },
            stop: function () {
                itemData = $(this).data("item");
                if (/zaino/.test(itemData.name)) {
                    $(this).css('background-image', 'url(\'img/items/' + "zaino" + '.png\'');
                } else if(/patente/.test(itemData.name)) {
                    $(this).css('background-image', 'url(\'img/items/' + "patente" + '.png\'');
                } else if(/bank_cards/.test(itemData.name)) {
                    $(this).css('background-image', 'url(\'img/items/' + "bank_cards" + '.png\'');
                } else{
                    $(this).css('background-image', 'url(\'img/items/' + itemData.name + '.png\'');
                } 
                $("#drop").removeClass("disabled");
                $("#use").removeClass("disabled");
                $("#give").removeClass("disabled");
            }
        }); 
    } else if (event.data.action == "rimuoviItems") {
        $(".info-div").hide();
    } else if (event.data.action == "setInfoText") {
        $(".info-div").html(event.data.text);
        chestname = event.data.chestname;
        max_weight = event.data.max_weight;
    } else if (event.data.action == "nearPlayers") {
        $("#nearPlayers").html("");

        $.each(event.data.players, function (index, player) {
            $("#nearPlayers").append('<button class="nearbyPlayerButton" data-player="' + player.player + '">' + player.label + ' (' + player.player + ')</button>');
        });

        $("#dialog").dialog("open");

        $(".nearbyPlayerButton").click(function () {
            $("#dialog").dialog("close");
            player = $(this).data("player");
            $.post("http://vrp_hud_inventory/GiveItem", JSON.stringify({ player: player, item: event.data.item, number: parseInt($("#count").val()) }));
        });
    }
});

function closeInventory() {
	$.post("http://vrp_hud_inventory/NUIFocusOff", JSON.stringify({}));
}

function inventorySetup(items) {
    $("#playerInventory").html("");
    $.each(items, function (index, item) {
        if (/zaino/.test(item.name)) {
            setItem(index, item, "zaino");
        } else if(/patente/.test(item.name)) {
            setItem(index, item, "patente");
        } else if(/bank_cards/.test(item.name)) {
            setItem(index, item, "bank_cards");
        } else{
            setItem(index, item, item.name);
        }
    });
}

function setItem(index, item, name) {
    $("#playerInventory").append('<div class="slot"><div id="item-' + index + '" class="item" style = "background-image: url(\'img/items/' + name + '.png\')">' +
    '<div class="item-count">' + item.count + '</div> <div class="item-name">' + item.label + '</div> </div ><div class="item-name-bg"></div></div>');
    $('#item-' + index).data('item', item);
    $('#item-' + index).data('inventory', "main");
}

function secondInventorySetup(items) {
    $("#otherInventory").html("");
    $.each(items, function (index, item) {
        if (/zaino/.test(item.name)) {
            setOtherItem(index, item, "zaino");
        } else if(/patente/.test(item.name)) {
            setOtherItem(index, item, "patente");
        } else if(/bank_cards/.test(item.name)) {
            setOtherItem(index, item, "bank_cards");
        } else{
            setOtherItem(index, item, item.name);
        }      
    });
}

function setOtherItem(index, item, name) {
    $("#otherInventory").append('<div class="slot"><div id="itemOther-' + index + '" class="item" style = "background-image: url(\'img/items/' + name + '.png\')">' +
    '<div class="item-count">' + item.count + '</div> <div class="item-name">' + item.label + '</div> </div ><div class="item-name-bg"></div></div>');
    $('#itemOther-' + index).data('item', item);
    $('#itemOther-' + index).data('inventory', "second");
}

$(document).ready(function () {
    $("#count").focus(function () {
        $(this).val("")
    }).blur(function () {
        if ($(this).val() == "") {
            $(this).val("1")
        }
    });

    $("body").on("keyup", function (key) {
        if (Config.closeKeys[0] == key.which || Config.closeKeys[1] == key.which) {
			closeInventory();
        }
    });

    $('#use').droppable({
        hoverClass: 'hoverControl',
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            if (itemData.usable) {
                $.post("http://vrp_hud_inventory/UseItem", JSON.stringify({ item: itemData }));
            }
        }
    });

    $('#give').droppable({
        hoverClass: 'hoverControl',
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            if (itemData.canRemove) {
				$.post("http://vrp_hud_inventory/GiveItem", JSON.stringify({ item: itemData, number: parseInt($("#count").val()) }));
            }
        }
    });

    $('#drop').droppable({
        hoverClass: 'hoverControl',
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            if (itemData.canRemove) {
                $.post("http://vrp_hud_inventory/DropItem", JSON.stringify({ item: itemData, number: parseInt($("#count").val()) }));
            }
        }
    });

    $('#playerInventory').droppable({
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "trunk" && itemInventory === "second") {
                $.post("http://vrp_hud_inventory/TakeFromTrunk", JSON.stringify({ item: itemData, number: parseInt($("#count").val()), chestname: chestname, max_weight: max_weight }));
            }
        }
    });

    $('#otherInventory').droppable({
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "trunk" && itemInventory === "main") {
                $.post("http://vrp_hud_inventory/PutIntoTrunk", JSON.stringify({ item: itemData, number: parseInt($("#count").val()), chestname: chestname, max_weight: max_weight }));
            }
        }
    });

    $("#count").on("keypress keyup blur", function (event) {
        $(this).val($(this).val().replace(/[^\d].+/, ""));
        if ((event.which < 48 || event.which > 57)) {
            event.preventDefault();
        }
    });
});

$.widget('ui.dialog', $.ui.dialog, {
    options: {
        // Determine if clicking outside the dialog shall close it
        clickOutside: false,
        // Element (id or class) that triggers the dialog opening 
        clickOutsideTrigger: ''
    },
    open: function () {
        var clickOutsideTriggerEl = $(this.options.clickOutsideTrigger),
            that = this;
        if (this.options.clickOutside) {
            // Add document wide click handler for the current dialog namespace
            $(document).on('click.ui.dialogClickOutside' + that.eventNamespace, function (event) {
                var $target = $(event.target);
                if ($target.closest($(clickOutsideTriggerEl)).length === 0 &&
                    $target.closest($(that.uiDialog)).length === 0) {
                    that.close();
                }
            });
        }
        // Invoke parent open method
        this._super();
    },
    close: function () {
        // Remove document wide click handler for the current dialog
        $(document).off('click.ui.dialogClickOutside' + this.eventNamespace);
        // Invoke parent close method 
        this._super();
    },
});