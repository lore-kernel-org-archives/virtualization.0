From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 05/14] Tools: hv: Gather subnet information
Date: Thu, 16 Aug 2012 17:45:16 -0700
Message-ID: <1345164325-5198-6-git-send-email-kys@microsoft.com>
References: <1345164300-5146-1-git-send-email-kys@microsoft.com>
 <1345164325-5198-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1345164325-5198-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, olaf@aepfle.de, apw@canonical.com, ben@decadent.org.uk
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

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
