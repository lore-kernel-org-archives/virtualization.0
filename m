From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH V3 06/14] Tools: hv: Represent the ipv6 mask using CIDR
 notation
Date: Thu, 16 Aug 2012 18:32:17 -0700
Message-ID: <1345167145-5513-6-git-send-email-kys@microsoft.com>
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

Transform ipv6 subnet information to CIDR notation.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 tools/hv/hv_kvp_daemon.c |   46 ++++++++++++++++++++++++++++++++++++----------
 1 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index de1724c..a63e83a 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -491,6 +491,15 @@ done:
 	return;
 }
 
+static unsigned int hweight32(unsigned int *w)
+{
+	unsigned int res = *w - ((*w >> 1) & 0x55555555);
+	res = (res & 0x33333333) + ((res >> 2) & 0x33333333);
+	res = (res + (res >> 4)) & 0x0F0F0F0F;
+	res = res + (res >> 8);
+	return (res + (res >> 16)) & 0x000000FF;
+}
+
 static int kvp_process_ip_address(void *addrp,
 				int family, char *buffer,
 				int length,  int *offset)
@@ -535,10 +544,15 @@ kvp_get_ip_address(int family, char *if_name, int op,
 	struct ifaddrs *curp;
 	int offset = 0;
 	int sn_offset = 0;
-	const char *str;
 	int error = 0;
 	char *buffer;
 	struct hv_kvp_ipaddr_value *ip_buffer;
+	char cidr_mask[5]; /* /xyz */
+	int weight;
+	int i;
+	unsigned int *w;
+	char *sn_str;
+	struct sockaddr_in6 *addr6;
 
 	if (op == KVP_OP_ENUMERATE) {
 		buffer = out_buffer;
@@ -611,18 +625,30 @@ kvp_get_ip_address(int family, char *if_name, int op,
 					goto gather_ipaddr;
 			} else {
 				ip_buffer->addr_family |= ADDR_FAMILY_IPV6;
+
 				/*
-				 * Get subnet info.
+				 * Get subnet info in CIDR format.
 				 */
-				error = kvp_process_ip_address(
-							     curp->ifa_netmask,
-							     AF_INET6,
-							     (char *)
-							     ip_buffer->sub_net,
-							     length,
-							     &sn_offset);
-				if (error)
+				weight = 0;
+				sn_str = (char *)ip_buffer->sub_net;
+				addr6 = (struct sockaddr_in6 *)
+					curp->ifa_netmask;
+				w = addr6->sin6_addr.s6_addr32;
+
+				for (i = 0; i < 4; i++)
+					weight += hweight32(&w[i]);
+
+				sprintf(cidr_mask, "/%d", weight);
+				if ((length - sn_offset) <
+					(strlen(cidr_mask) + 1))
 					goto gather_ipaddr;
+
+				if (sn_offset == 0)
+					strcpy(sn_str, cidr_mask);
+				else
+					strcat(sn_str, cidr_mask);
+				strcat((char *)ip_buffer->sub_net, ";");
+				sn_offset += strlen(sn_str) + 1;
 			}
 		}
 
-- 
1.7.4.1
