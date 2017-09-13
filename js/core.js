jQuery.fn.centerTop = function () {
    this.css("position","absolute");
    this.css("top", "0px");
    this.css("left", (($(window).width() - this.outerWidth()) / 2) + $(window).scrollLeft() + "px");
    return this;
}
jQuery.fn.centerRight = function () {
    this.css("position","absolute");
    this.css("right", "0px");
    this.css("top", (($(window).height() - this.outerHeight()) / 2) + $(window).scrollTop() + "px");
    return this;
}

var IEMODE;
var RSEED;
var SNAME;
var STARMAP;
var STARS;
var WORLDS;
var NPCS;
var CORPS;
var RELS;
var POLS;
var ALIENS;
var CLICKMAP;
var MAPCTRS = [];
var CLICKED = [];

var legalSeedPattern = /^[0-9A-Za-z]+$/;

function getSector() {
    RSEED = document.generator.seedId.value.toUpperCase();

    if (RSEED.length > 7) {
        alert('Seed "' + RSEED + '" is too long. Max length is 7 characters.');
        RSEED = '';
	return;
    }
    if (!legalSeedPattern.test(RSEED)) {
        alert('Seed "' + RSEED + '" does not contain legal values. Letters and numbers only.');
        RSEED = '';
	return;
    }

    $("#genSec").attr('disabled', true);
    $("#wait").dialog('open');

    $.ajax({
        type:     'POST',
        url:      '/CGI/sectorgen.cgi',
        dataType: 'json',
        timeout:  30000,
	data:     { action: 'display',
	            token:  RSEED,
                    isie:   IEMODE,
                  },
        success:  function(data){
	    SNAME   = data.name[0];
            STARMAP = data.map;
            STARS   = data.stars;
	    WORLDS  = data.worlds;
            NPCS    = data.npcs;
	    CORPS   = data.corps;
	    RELS    = data.rels;
	    POLS    = data.pols;
	    ALIENS  = data.aliens;
        },
        error:    function(){
            alert("Could not retrieve sector data from the server.");
        },
        complete: function() {
            $("#s-overview").html('<p class="sector-name">Sector ' + SNAME + '<span style="font-size: 10px; font-style: italic;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Click stars to move / swap them]</span></p><img id="starchart" height="820" width="563" style="display: block; margin-left: auto; margin-right: auto;" src="Includes/swnmap.png" />');
            $("#s-worlds").html(makeWorldsHTML());
            $("#s-npcs").html(makeNPCsHTML());
            $("#s-corps").html(makeCorpsHTML());
            $("#s-rels").html(makeRelsHTML());
            $("#s-pols").html(makePolsHTML());
            $("#s-aliens").html(makeAliensHTML());
            $("#sector").tabs({ selected: 0 });
            if ($("#sector-frame").is(":visible")) {
                $("#wait").dialog('close');
                drawStars();
            }
            else {
                $("#sector-frame").fadeToggle('300', 'swing', function() { $("#wait").dialog('close'); drawStars(); });
            }
        }
    });
}

function makeWorldsHTML(myIdx, myOldHTML) {
    return makeTable(WORLDS);
}

function makeNPCsHTML(myIdx, myOldHTML) {
    return make2ColHTML(NPCS);
}

function makeCorpsHTML(myIdx, myOldHTML) {
    return make2ColHTML(CORPS);
}

function makeRelsHTML(myIdx, myOldHTML) {
    return make2ColHTML(RELS);
}

function makePolsHTML(myIdx, myOldHTML) {
    return makeTable(POLS);
}

function makeAliensHTML(myIdx, myOldHTML) {
    return makeTable(ALIENS);
}

// Splits a list into a two column table.
function make2ColHTML (myList) {
    // Take off one for the header row
    var wLen  = myList.length - 1;
    var wOdd  = wLen % 2;
    var wlMax = Math.floor(wLen / 2);
    if (wOdd == 1) {
        wlMax = wlMax + 1;
    }
    // Add one back for the header row
    wlMax = wlMax + 1

    //Make 2 lists
    var ltCol = [myList[0]];
    var rtCol = [myList[0]];
    for (var i = 1; i < wlMax; i++) {
        ltCol[ltCol.length] = myList[i];
    }
    for (var i = wlMax; i < wLen; i++) {
        rtCol[rtCol.length] = myList[i];
    }

    var tTxt = '<table style="width: 100%;"><tr><td class="cols">';
    tTxt = tTxt + makeTable(ltCol);
    tTxt = tTxt + '</td><td class="cols">';
    tTxt = tTxt + makeTable(rtCol);
    tTxt = tTxt + '</td></tr></table>';
    return tTxt;
}

// Turns a list into a table. First row expected to contain headers.
function makeTable (myData) {
    var tHTML = '<table class="data"><tr>';
    for (var col = 0; col < myData[0].length; col++) {
        tHTML = tHTML + '<th class="data">' + myData[0][col] + '</th>';
    }
    tHTML = tHTML + '</tr>';
    for (var row = 1; row < myData.length; row++) {
        if (row % 2 == 1) {
            tHTML = tHTML + '<tr>';
        }
        else {
            tHTML = tHTML + '<tr class="alt">';
        }
        for (var col = 0; col < myData[row].length; col++) {
            tHTML = tHTML + '<td>' + myData[row][col] + '</td>';
        }
        tHTML = tHTML + '</tr>';
    }
    tHTML = tHTML + '</table>';

    return tHTML;
}

// Mostly based on trial and error, this makes a clickmap
// for the starmap.
function makeClickMap() {
    var xMarks = [1,21,68,89];
    var yMarks = [1,39,77];

    var cOff   = xMarks[2] + 1;
    var rOff   = yMarks[2] + 1;

    var mapTxt     = '<map name="chartmap">';
    var allColTweak = 0;
    for (var col = 0; col < 8; col++) {
        var colXoff = col * cOff;
        if (col > 1) {
            if (col % 2 == 0) {
                allColTweak = allColTweak + 2;
            }
            else {
                allColTweak = allColTweak + 1;
            }
        }
        MAPCTRS[col] = new Array();
        for (var row = 0; row < 10; row++) {
            var rowYoff = row * rOff;
            var wTweak  = 0;
            if (col % 2 == 1) {
                rowYoff = rowYoff + yMarks[1];
                wTweak  = 1;
            }
            var maxX = xMarks[3] + colXoff - allColTweak - wTweak;
            var minX = xMarks[0] + colXoff - allColTweak;
            var maxY = yMarks[2] + rowYoff;
            var minY = yMarks[0] + rowYoff;
            var cList = [ xMarks[1] + colXoff - allColTweak,
                          minY,
                          xMarks[2] + colXoff - allColTweak - wTweak,
                          minY,
                          maxX,
                          yMarks[1] + rowYoff,
                          xMarks[2] + colXoff - allColTweak - wTweak,
                          maxY,
                          xMarks[1] + colXoff - allColTweak,
                          maxY,
                          minX,
                          yMarks[1] + rowYoff,
                          xMarks[1] + colXoff - allColTweak,
                          minY,
                        ];
            var cellId = '0' + col+ '0' + row;
            mapTxt = mapTxt + '<area id="area' + cellId + '" alt="' + cellId + '" onclick="flipStar(' + col + ', ' + row + ')" shape="poly" coords="' + cList.join(',') + '" />';

            // Find the hex center point.
            var xCtr = Math.floor((maxX - minX) / 2) + minX;
            var yCtr = Math.floor((maxY - minY) / 2) + minY;

            MAPCTRS[col][row] = [xCtr, yCtr];
        }
    }
    mapTxt = mapTxt + '</map>';

    CLICKMAP = mapTxt;
}

function drawStars() {
    var oTxt = '<p class="sector-name">Sector ' + SNAME + '<span style="font-size: 10px; font-style: italic;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Click stars to move / swap them]</span></p><img id="starchart" height="820" width="563" style="display: block; margin-left: auto; margin-right: auto;" src="Includes/swnmap.png" />';

    var iOff = $("#starchart").position();

    var seenCells = [];

    var browserOffset = { left: 0, top: 0 };
    if (jQuery.browser.webkit == true || jQuery.browser.msie == true) {
        browserOffset = { left: 38.15, top: -2 };
    }

    for (var s = 0; s < STARS.length; s++) {
        var star = STARS[s];

        seenCells[star.cell] = 1;

        // Grep star map position from cell ID
        var cCol = star.cell.substring(1,2);
        var cRow = star.cell.substring(3);

        // Lookup center X,Y
        var cX = MAPCTRS[cCol][cRow][0] + iOff.left - 30 + browserOffset['left'];
        var cY = MAPCTRS[cCol][cRow][1] + iOff.top - 7 + browserOffset['top'];

        var myDiv = '<div id="cell' + star.cell + '" style="position: absolute; left: ' + cX + 'px; top: ' + cY + 'px; width: 60px; height: 35px; text-align: center;"><img style="height: 15px; width: 15px;" src="Includes/swndot.png" /><br /><span style="font-size: 8px;">' + star.name.toUpperCase() + '</span></div>';

        oTxt = oTxt + myDiv;
    }

    for (var col = 0; col < 8; col++) {
        for (var row = 0; row < 10; row++) {
            var cellID = new String('0' + col + '0' + row);
            if (seenCells[cellID] != 1) {
                // Lookup center X,Y
                var cX = MAPCTRS[col][row][0] + iOff.left - 30 + browserOffset['left'];
                var cY = MAPCTRS[col][row][1] + iOff.top - 7 + browserOffset['top'];

                var myDiv = '<div id="cell' + cellID + '" style="position: absolute; left: ' + cX + 'px; top: ' + cY + 'px; width: 60px; height: 35px; text-align: center;">&nbsp;</div>';

                oTxt = oTxt + myDiv;
            }
        }
    }

    oTxt = oTxt + '<img style="position: absolute; left: ' + (iOff.left + browserOffset['left']) + 'px; top: ' + (iOff.top + browserOffset['top']) + 'px;" height="820" width="563" src="Includes/clear.gif"  usemap="#chartmap" />' + CLICKMAP;

    $("#s-overview").html(oTxt);
}

function flipStar(myCol, myRow) {
    var cellID = String('0' + myCol + '0' + myRow);
    if (CLICKED.length == 0) {
        // Figure out if the clicked cell has a star in it.
        for (var i = 0; i < STARS.length; i++) {
            if (STARS[i].cell == cellID) {
                $("#cell" + cellID).css('color', '#F00', 'font-weight', 'bold');
                CLICKED = [cellID, STARS[i].id];
                break;
            }
        }
    }
    else {
        if (cellID == CLICKED[0]) {
            // Clicked the same cell again. Clear state.
            $("#cell" + cellID).css('color', '#000', 'font-weight', 'normal');
            CLICKED = [];
        }
        else {
            // See if there is a star in the target cell.
            // If so, swap. Otherwise, just move the first star.
            for (var i = 0; i < STARS.length; i++) {
                if (STARS[i].cell == cellID) {
                    STARS[i].cell = CLICKED[0];
                    break;
                }
            }
            STARS[CLICKED[1]].cell = cellID;
            CLICKED = [];
            drawStars();
        }
    }
}

/* On startup, grab a random seed. */
$(document).ready(function(){
    if ($.browser.msie) {
        IEMODE = 1;
    }
    else {
        IEMODE = 0;
    }
    $("#wait").dialog({ autoOpen: false, modal: true, position: 'center', resizable: false, height: 60, width: 100 });
    $("#svSec").click(function(e) {
        e.preventDefault();  //stop the browser from following
        var STARJSON = JSON.stringify(STARS);
        var ZIPURL = '/CGI/sectorgen.cgi?action=create&token=' + RSEED + '&isie=' + IEMODE + '&stars=' + STARJSON;
        window.location.href = ZIPURL;
    });
    makeClickMap();
});

