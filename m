From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH V2 07/18] Tools: hv: Gather address family information
Date: Mon, 13 Aug 2012 10:06:56 -0700
Message-ID: <1344877627-21779-7-git-send-email-kys@microsoft.com>
References: <1344877584-21738-1-git-send-email-kys@microsoft.com>
 <1344877627-21779-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1344877627-21779-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, olaf@aepfle.de, apw@canonical.com, ben@decadent.org.uk
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Now, gather address family information for the specified interface.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Olaf Hering <olaf@aepfle.de>
Reviewed-by: Ben Hutchings <ben@decadent.org.uk>
---
 tools/hv/hv_kvp_daemon.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index 3dc989f..13ae098 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -589,6 +589,17 @@ kvp_get_ip_address(int family, char *if_name, int op,
 			continue;
 		}
 
+		if (op == KVP_OP_GET_IP_INFO) {
+			/*
+			 * Gather info other than the IP address.
+			 * IP address info will be gathered later.
+			 */
+			if (curp->ifa_addr->sa_family == AF_INET)
+				ip_buffer->addr_family |= ADDR_FAMILY_IPV4;
+			else
+				ip_buffer->addr_family |= ADDR_FAMILY_IPV6;
+		}
+
 		error = kvp_process_ip_address(curp->ifa_addr,
 						curp->ifa_addr->sa_family,
 						buffer,
-- 
1.7.4.1
