From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH V2 08/18] Tools: hv: Gather subnet information
Date: Mon, 13 Aug 2012 10:06:57 -0700
Message-ID: <1344877627-21779-8-git-send-email-kys@microsoft.com>
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

Now, gather sub-net information for the specified interface.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Olaf Hering <olaf@aepfle.de>
Reviewed-by: Ben Hutchings <ben@decadent.org.uk>
---
 tools/hv/hv_kvp_daemon.c |   31 +++++++++++++++++++++++++++++--
 1 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index 13ae098..de1724c 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -534,6 +534,7 @@ kvp_get_ip_address(int family, char *if_name, int op,
 	struct ifaddrs *ifap;
 	struct ifaddrs *curp;
 	int offset = 0;
+	int sn_offset = 0;
 	const char *str;
 	int error = 0;
 	char *buffer;
@@ -594,12 +595,38 @@ kvp_get_ip_address(int family, char *if_name, int op,
 			 * Gather info other than the IP address.
 			 * IP address info will be gathered later.
 			 */
-			if (curp->ifa_addr->sa_family == AF_INET)
+			if (curp->ifa_addr->sa_family == AF_INET) {
 				ip_buffer->addr_family |= ADDR_FAMILY_IPV4;
-			else
+				/*
+				 * Get subnet info.
+				 */
+				error = kvp_process_ip_address(
+							     curp->ifa_netmask,
+							     AF_INET,
+							     (char *)
+							     ip_buffer->sub_net,
+							     length,
+							     &sn_offset);
+				if (error)
+					goto gather_ipaddr;
+			} else {
 				ip_buffer->addr_family |= ADDR_FAMILY_IPV6;
+				/*
+				 * Get subnet info.
+				 */
+				error = kvp_process_ip_address(
+							     curp->ifa_netmask,
+							     AF_INET6,
+							     (char *)
+							     ip_buffer->sub_net,
+							     length,
+							     &sn_offset);
+				if (error)
+					goto gather_ipaddr;
+			}
 		}
 
+gather_ipaddr:
 		error = kvp_process_ip_address(curp->ifa_addr,
 						curp->ifa_addr->sa_family,
 						buffer,
-- 
1.7.4.1
