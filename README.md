# Electritybillingsystem

(function execute(inputs, outputs) {

    var groupedServers = {};

    var servers = inputs.server || [];

    // Group servers by Managed By Group
    for (var i = 0; i < servers.length; i++) {

        var rec = servers[i];

        var groupName = "No Group";

        if (rec.managed_by && rec.managed_by.display_value) {
            groupName = rec.managed_by.display_value;
        }

        // Create group array if not exists
        if (!groupedServers[groupName]) {
            groupedServers[groupName] = [];
        }

        // Add server name into that group
        groupedServers[groupName].push(rec.name);
    }

    // Final mail body
    var finalBody = "";

    for (var group in groupedServers) {

        finalBody += "Group : " + group + "\n";

        finalBody += "Servers:\n";

        for (var j = 0; j < groupedServers[group].length; j++) {

            finalBody += "- " + groupedServers[group][j] + "\n";
        }

        finalBody += "\n----------------------\n\n";
    }

    // Send output to notification
    outputs.mailbody = finalBody;

})(inputs, outputs);
