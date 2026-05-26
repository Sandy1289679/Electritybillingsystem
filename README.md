(function execute(inputs, outputs) {

    var sysIds = inputs.server_sys_id.toString().split(',');

    var serverGr = new GlideRecord('cmdb_ci_server');
    serverGr.addQuery('sys_id', 'IN', sysIds);
    serverGr.query();

    outputs.group_email = '';
    outputs.email_body = '';

    while (serverGr.next()) {

        var managedBy = serverGr.getValue('managed_by');

        if (managedBy) {

            var userGr = new GlideRecord('sys_user');

            if (userGr.get(managedBy)) {

                outputs.group_email = userGr.getValue('email');

                outputs.email_body =
                    "Stale server found: " +
                    serverGr.getValue('name');

                break;
            }
        }
    }

    if (!outputs.group_email) {

        outputs.group_email = "yourmail@gmail.com";
        outputs.email_body = "No stale servers found";
    }

})(inputs, outputs);
