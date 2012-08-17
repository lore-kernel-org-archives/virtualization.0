From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH V3 07/14] Tools: hv: Gather ipv[4,6] gateway information
Date: Thu, 16 Aug 2012 18:32:18 -0700
Message-ID: <1345167145-5513-7-git-send-email-kys@microsoft.com>
References: <1345167068-5461-1-git-send-email-kys@microsoft.com>
 <1345167145-5513-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1345167145-5513-1-git-send-email-kys@microsoft.com>
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

Gather information on the default gateways - ipv4/ipv6.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 tools/hv/hv_kvp_daemon.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index a63e83a..65d54c8 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -491,6 +491,68 @@ done:
 	return;
 }
 
+static void kvp_process_ipconfig_file(char *cmd,
+					char *config_buf, int len,
+					int element_size, int offset)
+{
+	char buf[256];
+	char *p;
+	char *x;
+	FILE *file;
+
+	/*
+	 * First execute the command.
+	 */
+	file = popen(cmd, "r");
+	if (file == NULL)
+		return;
+
+	if (offset == 0)
+		memset(config_buf, 0, len);
+	while ((p = fgets(buf, sizeof(buf), file)) != NULL) {
+		if ((len - strlen(config_buf)) < (element_size + 1))
+			break;
+
+		x = strchr(p, '\n');
+		*x = '\0';
+		strcat(config_buf, p);
+		strcat(config_buf, ";");
+	}
+	pclose(file);
+}
+
+static void kvp_get_ipconfig_info(char *if_name,
+				 struct hv_kvp_ipaddr_value *buffer)
+{
+	char cmd[512];
+
+	/*
+	 * Get the address of default gateway (ipv4).
+	 */
+	sprintf(cmd, "%s %s", "ip route show dev", if_name);
+	strcat(cmd, " | awk '/default/ {print $3 }'");
+
+	/*
+	 * Execute the command to gather gateway info.
+	 */
+	kvp_process_ipconfig_file(cmd, (char *)buffer->gate_way,
+				(MAX_GATEWAY_SIZE * 2), INET_ADDRSTRLEN, 0);
+
+	/*
+	 * Get the address of default gateway (ipv6).
+	 */
+	sprintf(cmd, "%s %s", "ip -f inet6  route show dev", if_name);
+	strcat(cmd, " | awk '/default/ {print $3 }'");
+
+	/*
+	 * Execute the command to gather gateway info (ipv6).
+	 */
+	kvp_process_ipconfig_file(cmd, (char *)buffer->gate_way,
+				(MAX_GATEWAY_SIZE * 2), INET6_ADDRSTRLEN, 1);
+
+}
+
+
 static unsigned int hweight32(unsigned int *w)
 {
 	unsigned int res = *w - ((*w >> 1) & 0x55555555);
@@ -650,6 +712,12 @@ kvp_get_ip_address(int family, char *if_name, int op,
 				strcat((char *)ip_buffer->sub_net, ";");
 				sn_offset += strlen(sn_str) + 1;
 			}
+
+			/*
+			 * Collect other ip related configuration info.
+			 */
+
+			kvp_get_ipconfig_info(if_name, ip_buffer);
 		}
 
 gather_ipaddr:
-- 
1.7.4.1
