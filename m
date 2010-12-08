From: "Ky Srinivasan" <ksrinivasan@novell.com>
Subject: [PATCH 1/4] Add a connector Index to support HyperV KVP functionality
Date: Wed, 08 Dec 2010 15:20:59 -0700
Message-ID: <4CFFA25B02000030000918BE@novprvoes0310.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: devel@linuxdriverproject.org, Virtualization@lists.osdl.org
Cc: Zbr@ioremap.net, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <shemminger@vyatta.com>, Greg KH <gregkh@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

From 5b7c16baf2f310a1e7e119c3df8fd976ca0e2f57 Mon Sep 17 00:00:00 2001
From: ksrinivasan <ksrinivasan@novell.com>
Date: Wed, 8 Dec 2010 09:35:13 -0700

Added a connector index to support key value/pair (KVP) functionality
for Linux guests hosted on a HyperV platform. All KVP related
data gathering will be done in a user-level daemon. The kernel 
component of KVP communicates with the data gathering daemon using this
connector index.


Signed-off-by: ksrinivasan <ksrinivasan@novell.com>
---
 include/linux/connector.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/include/linux/connector.h b/include/linux/connector.h
index 7e8ca75..2e9759c 100644
--- a/include/linux/connector.h
+++ b/include/linux/connector.h
@@ -42,8 +42,9 @@
 #define CN_VAL_DM_USERSPACE_LOG		0x1
 #define CN_IDX_DRBD			0x8
 #define CN_VAL_DRBD			0x1
+#define CN_KVP_IDX			0x9	/* HyperV KVP */
 
-#define CN_NETLINK_USERS		8
+#define CN_NETLINK_USERS		9
 
 /*
  * Maximum connector's message size.
-- 
1.7.1
