From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH V3 04/14] Tools: hv: Gather address family information
Date: Thu, 16 Aug 2012 18:32:15 -0700
Message-ID: <1345167145-5513-4-git-send-email-kys@microsoft.com>
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

Now, gather address family information for the specified interface.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
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
