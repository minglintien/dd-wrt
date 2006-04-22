<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=iso-8859-1" />
		<title><% nvram_get("router_name"); %> - Services</title>
		<link type="text/css" rel="stylesheet" href="style/<% nvram_get("router_style"); %>/style.css" />
		<!--[if IE]><link type="text/css" rel="stylesheet" href="style/<% nvram_get("router_style"); %>/style_ie.css" /><![endif]-->
		<script type="text/javascript" src="common.js"></script>
		<script type="text/javascript" src="lang_pack/english.js"></script>
		<script type="text/javascript" src="lang_pack/language.js"></script>
		<script type="text/javascript">
var EN_DIS1 = '<% nvram_get("remote_management"); %>'
var wan_proto = '<% nvram_get("wan_proto"); %>'

function lease_add_submit(F) {
	F.change_action.value = "gozila_cgi";
	F.submit_button.value = "Services";
	F.submit_type.value = "add_lease";
 	F.action.value = "Apply";
	F.submit();
}

function lease_remove_submit(F) {
	F.change_action.value = "gozila_cgi";
	F.submit_button.value = "Services";
	F.submit_type.value = "remove_lease";
 	F.action.value = "Apply";
	F.submit();
}

function to_reboot(F) {
	F.action.value = "Reboot";
	F.submit();
	return true;
}

function to_submit(F) {
	F.submit_button.value = "Services";
	F.save_button.value = "Saved";
	F.save_button.disabled = true;

	F.action.value = "Apply";
	apply(F);
	return true;
}
		</script>
	</head>

	<body class="gui">
		<% showad(); %>
		<div id="wrapper">
			<div id="content">
				<div id="header">
					<div id="logo"><h1><% show_control(); %></h1></div>
						<div id="menu">
							<div id="menuMain">
								<ul id="menuMainList">
									<li><a href="index.asp">Setup</a></li>
									<li><a href="Wireless_Basic.asp">Wireless</a></li>
									<% nvram_invmatch("sipgate","1","<!--"); %>
									<li><a href="Sipath.asp">SIPatH</a></li>
									<% nvram_invmatch("sipgate","1","-->"); %>
									<li><a href="Firewall.asp">Security</a></li>
									<li><a href="Filters.asp">Access Restrictions</a></li>
									<li><a href="Forward.asp">Applications&nbsp;&amp;&nbsp;Gaming</a></li>
									<li class="current"><span>Administration</span><div id="menuSub">
										<ul id="menuSubList">
											<li><a href="Management.asp">Management</a></li>
											<li><a href="Hotspot.asp">Hotspot</a></li>
											<li><span>Services</span></li>
											<li><a href="Alive.asp">Keep Alive</a></li>
											<li><a href="Log.asp">Log</a></li>
											<li><a href="Diagnostics.asp">Diagnostics</a></li>
											<li><a href="Wol.asp">WOL</a></li>
											<li><a href="Factory_Defaults.asp">Factory Defaults</a></li>
											<li><a href="Upgrade.asp">Firmware Upgrade</a></li>
											<li><a href="config.asp">Backup</a></li>
										</ul>
									</div>
								</li>
								<li><a href="Status_Router.asp">Status</a></li>
							</ul>
						</div>
					</div>
				</div>
				<div id="main">
					<div id="contents">
						<form name="setup" action="applyuser.cgi" method="<% get_http_method(); %>">
							<input type="hidden" name="submit_button" />
							<input type="hidden" name="change_action" />
							<input type="hidden" name="submit_type" />
							<input type="hidden" name="action" />
							<input type="hidden" name="reboot_button" />
							<input type="hidden" name="commit" value="1" />
							<input type="hidden" name="static_leases" value="13" />
							<h2>Services Management</h2>
							<% show_modules(".webservices"); %>
							<div class="submitFooter">
								<input type="button" name="save_button" value="Save Settings" onclick="to_submit(this.form)" />
								<input type="reset" value="Cancel Changes" />
								<input type="button" value="Reboot Router" onclick="to_reboot(this.form)" />
							</div>
						</form>
					</div>
				</div>
				<div id="helpContainer">
					<div id="help">
						<div id="logo"><h2>Help</h2></div>
						<br/>
						<a href="javascript:openHelpWindow('HServices.asp')">More...</a>
					</div>
				</div>
				<div id="floatKiller"></div>
				<div id="statusInfo">
					<div class="info">Firmware: <script>document.write("<a title=\"" + share.about + "\" href=\"javascript:openAboutWindow()\"><% get_firmware_version(); %></a>");</script></div>
					<div class="info">Time: <% get_uptime(); %></div>
					<div class="info">WAN <% nvram_match("wl_mode","wet","disabled <!--"); %><% nvram_match("wan_proto","disabled","disabled <!--"); %>IP: <% nvram_status_get("wan_ipaddr"); %><% nvram_match("wan_proto","disabled","-->"); %><% nvram_match("wl_mode","wet","-->"); %></div>
				</div>
			</div>
		</div>
	</body>
</html>