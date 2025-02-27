function sendFollowUpEmails() {
    var ss = SpreadsheetApp.getActiveSpreadsheet();
    var dataSheet = ss.getSheetByName("DataSheet");
    var dataRange = dataSheet.getRange(2, 1, dataSheet.getMaxRows() - 1, dataSheet.getMaxColumns()); // 2 -> from row 2 1-> from col 1

    // Get template and configurations
    var templateSheet = ss.getSheetByName("Template");
    var bodyTemplate = templateSheet.getRange("B7").getValue();

    // Create one JavaScript object per row of data.
    var objects = getRowsData(dataSheet, dataRange);


    // For every row object, create a personalized email from a template and send
    // it to the appropriate person.
    for (var i = 0; i < objects.length; ++i) {
        // Get a row object
        var rowData = objects[i];


        var yesTxt = new Array("y", "yes");
        var sendFollowup = rowData.sendFollowup;
        if ((typeof sendFollowup == "undefined") || 
            ((typeof sendFollowup == "string") && (yesTxt.indexOf(toSend.toLowerCase()) == -1)) ||
            ((typeof sendFollowup == "boolean" && (!sendFollowup)))
        ){
        Logger.log("Skipped (not to send): "+rowData.emailAddress);
        continue;
        }
        
        var finish = rowData.finish;
        if ((typeof finish == "string") && (finish == "Finish")) {
        Logger.log("Skipped (done): "+rowData.emailAddress);
        continue;
        }

        var emailSubject = "Re: Follow-up regarding our last conversation";
        var emailBody = bodyTemplate;

        // use Reply-To to reply original email
        var opts = {
            replyTo: rowData.emailAddress,
            htmlBody: emailBody
          };
        
        MailApp.sendEmail(rowData.emailAddress, emailSubject, emailBody, opts);
        
        // Mark "Done" in DataSheet
        dataSheet.getRange(i+2,8).setValue("Finish"); // i is row read (from 0) 8 -> col 8 which is H
        SpreadsheetApp.flush();

        // Log this action
        Logger.log("Follow-up sent to " + rowData.emailAddress);
    }

    SpreadsheetApp.getUi().alert("Follow-up Emails Sent!");
}