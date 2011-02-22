//----------------------------------------------------------------------------
//
//  $Id: PreviewAndPrintLabel.js 11419 2010-04-07 21:18:22Z vbuzuev $ 
//
// Project -------------------------------------------------------------------
//
//  DYMO Label Framework
//
// Content -------------------------------------------------------------------
//
//  DYMO Label Framework JavaScript Library Samples: Print label
//
//----------------------------------------------------------------------------
//
//  Copyright (c), 2010, Sanford, L.P. All Rights Reserved.
//
//----------------------------------------------------------------------------


(function () {
    // called when the document completly loaded
    function onload() {
        var printButton = document.getElementById('printButton');

        // prints the label
        printButton.onclick = function () {
            try {
                // open label
                var labelXml = '\
                            <DieCutLabel Version="8.0" Units="twips">\
	                            <PaperOrientation>Landscape</PaperOrientation>\
	                            <Id>Address</Id>\
	                            <PaperName>30252 Address</PaperName>\
	                            <DrawCommands>\
		                            <RoundRectangle X="0" Y="0" Width="1581" Height="5040" Rx="270" Ry="270" />\
	                            </DrawCommands>\
	                            <ObjectInfo>\
		                            <BarcodeObject>\
			                            <Name>BARCODE</Name>\
			                            <ForeColor Alpha="255" Red="0" Green="0" Blue="0" />\
			                            <BackColor Alpha="0" Red="255" Green="255" Blue="255" />\
			                            <LinkedObjectName></LinkedObjectName>\
			                            <Rotation>Rotation0</Rotation>\
			                            <IsMirrored>False</IsMirrored>\
			                            <IsVariable>True</IsVariable>\
			                            <Text>0</Text>\
			                            <Type>Code39</Type>\
			                            <Size>Medium</Size>\
			                            <TextPosition>Bottom</TextPosition>\
			                            <TextFont Family="Arial" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" />\
			                            <CheckSumFont Family="Arial" Size="8" Bold="False" Italic="False" Underline="False" Strikeout="False" />\
			                            <TextEmbedding>None</TextEmbedding>\
			                            <ECLevel>0</ECLevel>\
			                            <HorizontalAlignment>Center</HorizontalAlignment>\
			                            <QuietZonesPadding Left="0" Top="0" Right="0" Bottom="0" />\
		                            </BarcodeObject>\
		                            <Bounds X="331" Y="132.9" Width="4382" Height="1320" />\
	                            </ObjectInfo>\
                            </DieCutLabel>';
                var label = dymo.label.framework.openLabelXml(labelXml);

                //Get the value from bcdata field.
                label.setObjectText("BARCODE", document.getElementById('OldPhysicalRecordNumber').value);
                
                // select printer to print on
                // for simplicity sake just use the first LabelWriter printer
                var printers = dymo.label.framework.getPrinters();
                if (printers.length == 0)
                    throw "No DYMO printers are installed. Install DYMO printers.";

                var printerName = "";
                for (var i = 0; i < printers.length; ++i) {
                    var printer = printers[i];
                    if (printer.printerType == "LabelWriterPrinter") {
                        printerName = printer.name;
                        break;
                    }
                }

                if (printerName == "")
                    throw "No LabelWriter printers found. Install LabelWriter printer";

                // finally print the label
                label.print(printerName);
            }
            catch (e) {
                alert(e.message || e);
            }
        }
    };

    // register onload event
    if (window.addEventListener)
        window.addEventListener("load", onload, false);
    else if (window.attachEvent)
        window.attachEvent("onload", onload);
    else
        window.onload = onload;

} ());