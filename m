From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 11/13] Tools: hv: Gather dhcp information
Date: Thu, 21 Jun 2012 14:31:43 -0700
Message-ID: <1340314305-27126-11-git-send-email-kys@microsoft.com>
References: <1340314200-27078-1-git-send-email-kys@microsoft.com>
 <1340314305-27126-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1340314305-27126-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com, apw@canonical.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Collect information on dhcp setting for the specified interface.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 tools/hv/hv_kvp_daemon.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index 68a4cc1..dcf67fa 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -524,6 +524,10 @@ static void kvp_get_ipconfig_info(char *if_name,
 	char cmd[512];
 	char *dns_config = "/var/opt/hyperv/.kvp_dns_cfg";
 	char *gw_config = "/var/opt/hyperv/.kvp_gw_cfg";
+	char if_cfg_file[256];
+	FILE *file;
+	char *p;
+	char buf[256];
 
 	memset(cmd, 0, 512);
 	strcat(cmd, "cat /etc/resolv.conf 2>/tmp/null | ");
@@ -569,6 +573,35 @@ static void kvp_get_ipconfig_info(char *if_name,
 	kvp_process_ipconfig_file(gw_config, (char *)buffer->gate_way,
 				(MAX_GATEWAY_SIZE * 2), INET6_ADDRSTRLEN,
 				strlen(gw_config));
+
+	/*
+	 * Get the boot protocol for the interface.
+	 * We will get the info from:
+	 * /etc/sysconfig/network-scripts/ifcfg-ethx
+	 * If need to parse other files to get
+	 * this info, we need to add code to parse
+	 * other files.
+	 */
+	memset(if_cfg_file, 0, sizeof(if_cfg_file));
+	strcat(if_cfg_file, "/etc/sysconfig/network-scripts/ifcfg-");
+	strcat(if_cfg_file, if_name);
+
+	file = fopen(if_cfg_file, "r");
+	if (file == NULL)
+		/*
+		 * Add code to parse other files.
+		 */
+		return;
+
+	while ((p = fgets(buf, sizeof(buf), file)) != NULL) {
+		if (strncmp(p, "BOOTPROTO", 9))
+			continue;
+		if (strncmp(p, "BOOTPROTO=none", 14))
+			buffer->dhcp_enabled = 0;
+		else
+			buffer->dhcp_enabled = 1;
+	}
+
 }
 
 
-- 
1.7.4.1
