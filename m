From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH V2 12/18] Tools: hv: Gather DHCP information
Date: Mon, 13 Aug 2012 10:07:01 -0700
Message-ID: <1344877627-21779-12-git-send-email-kys@microsoft.com>
References: <1344877584-21738-1-git-send-email-kys@microsoft.com>
 <1344877627-21779-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1344877627-21779-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, olaf@aepfle.de, apw@canonical.com, ben@decadent.org.uk
List-Id: virtualization@lists.linuxfoundation.org

Collect information on dhcp setting for the specified interface.
We invoke an external script to get this information.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Olaf Hering <olaf@aepfle.de>
Reviewed-by: Ben Hutchings <ben@decadent.org.uk>
---
 tools/hv/hv_kvp_daemon.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index 2f8e0b9..8a18819 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -525,6 +525,9 @@ static void kvp_get_ipconfig_info(char *if_name,
 				 struct hv_kvp_ipaddr_value *buffer)
 {
 	char cmd[512];
+	char dhcp_info[128];
+	char *p;
+	FILE *file;
 
 	/*
 	 * Get the address of default gateway (ipv4).
@@ -573,6 +576,34 @@ static void kvp_get_ipconfig_info(char *if_name,
 	 */
 	kvp_process_ipconfig_file(cmd, (char *)buffer->dns_addr,
 				(MAX_IP_ADDR_SIZE * 2), INET_ADDRSTRLEN, 0);
+
+	/*
+	 * Gather the DHCP state.
+	 * We will gather this state by invoking an external script.
+	 * The parameter to the script is the interface name.
+	 * Here is the expected output:
+	 *
+	 * Enabled: DHCP enabled.
+	 */
+
+	sprintf(cmd, "%s %s", "hv_get_dhcp_info", if_name);
+
+	file = popen(cmd, "r");
+	if (file == NULL)
+		return;
+
+	p = fgets(dhcp_info, sizeof(dhcp_info), file);
+	if (p == NULL) {
+		pclose(file);
+		return;
+	}
+
+	if (!strncmp(p, "Enabled", 7))
+		buffer->dhcp_enabled = 1;
+	else
+		buffer->dhcp_enabled = 0;
+
+	pclose(file);
 }
 
 
-- 
1.7.4.1
