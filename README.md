(function execute(inputs, outputs) {

    var sysIds = inputs.server_sys_id;

    if (!sysIds) {
        outputs.group_email = "";
        outputs.email_body = "No stale servers found";
        return;
    }

    var serverGr = new GlideRecord('cmdb_ci_server');
    serverGr.addQuery('sys_id', 'IN', sysIds);
    serverGr.query();

    var body = "Hello Team,\n\nBelow servers are stale:\n\n";

    while (serverGr.next()) {

        body += "Server Name : " + serverGr.getValue('name') + "\n";
        body += "Updated On  : " + serverGr.getDisplayValue('sys_updated_on') + "\n\n";

        var userId = serverGr.getValue('managed_by');

        if (userId) {

            var userGr = new GlideRecord('sys_user');

            if (userGr.get(userId)) {

                outputs.group_email = userGr.getValue('email');
            }
        }
    }

    outputs.email_body = body;

})(inputs, outputs);
