From: "Ky Srinivasan" <ksrinivasan@novell.com>
Subject: [PATCH 1/3]: An implementation of HyperV KVP functionality
Date: Mon, 22 Nov 2010 13:21:20 -0700
Message-ID: <4CEA6E500200003000090BB1@novprvoes0310.provo.novell.com>
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
To: devel@driverdev.osuosl.org, Virtualization@lists.osdl.org
Cc: Zbr@ioremap.net, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <shemminger@vyatta.com>, Greg KH <gregkh@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

From: K. Y. Srinivasan <ksrinivasan@novell.com>
Subject: Reserve a connector index for implementing HyperV Key Value Pair
(KVP) functionality.

Signed-off-by: K. Y. Srinivasan <ksrinivasan@novell.com>

Index: linux.trees.git/include/linux/connector.h
===================================================================
--- linux.trees.git.orig/include/linux/connector.h	2010-11-15 06:50:30.000000000 -0500
+++ linux.trees.git/include/linux/connector.h	2010-11-15 07:00:52.000000000 -0500
@@ -42,8 +42,9 @@
 #define CN_VAL_DM_USERSPACE_LOG		0x1
 #define CN_IDX_DRBD			0x8
 #define CN_VAL_DRBD			0x1
+#define CN_KVP_IDX			0x9	/* HyperV KVP */
 
-#define CN_NETLINK_USERS		8
+#define CN_NETLINK_USERS		9
 
 /*
  * Maximum connector's message size.
