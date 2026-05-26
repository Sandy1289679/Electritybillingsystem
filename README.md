(function execute(inputs, outputs) {

    var sysIds = inputs.server_sys_ids;

    if (!sysIds) {
        outputs.group_mapping_json = "{}";
        return;
    }

    var serverGr = new GlideRecord('cmdb_ci_server');
    serverGr.addQuery('sys_id', 'IN', sysIds);
    serverGr.query();

    var map = {};

    while (serverGr.next()) {

        var groupId = serverGr.getValue('managed_by');

        if (!groupId) {
            groupId = serverGr.getValue('assignment_group');
        }

        if (!groupId) {
            groupId = "UNASSIGNED";
        }

        var serverInfo = {
            name: serverGr.getValue('name'),
            updated: serverGr.getDisplayValue('sys_updated_on')
        };

        if (!map[groupId]) {
            map[groupId] = [];
        }

        map[groupId].push(serverInfo);
    }

    outputs.group_mapping_json = JSON.stringify(map);

})(inputs, outputs);
