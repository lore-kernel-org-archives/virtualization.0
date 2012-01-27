From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 4/6] tools: hv: Use hyperv.h to get the KVP definitions
Date: Fri, 27 Jan 2012 15:56:00 -0800
Message-ID: <1327708562-26964-4-git-send-email-kys@microsoft.com>
References: <1327708522-26914-1-git-send-email-kys@microsoft.com>
 <1327708562-26964-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1327708562-26964-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com, zbr@ioremap.net
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Now use hyperv.h to get the KVP defines in the KVP user-mode code.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 tools/hv/hv_kvp_daemon.c |   28 +---------------------------
 1 files changed, 1 insertions(+), 27 deletions(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index 2b6a2d9..b75523c 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -34,17 +34,12 @@
 #include <errno.h>
 #include <arpa/inet.h>
 #include <linux/connector.h>
+#include <linux/hyperv.h>
 #include <linux/netlink.h>
 #include <ifaddrs.h>
 #include <netdb.h>
 #include <syslog.h>
 
-/*
- *
- * The following definitions are shared with the in-kernel component; do not
- * change any of this without making the corresponding changes in
- * the KVP kernel component.
- */
 
 /*
  * KVP protocol: The user mode component first registers with the
@@ -56,25 +51,8 @@
  * We use this infrastructure for also supporting queries from user mode
  * application for state that may be maintained in the KVP kernel component.
  *
- * XXXKYS: Have a shared header file between the user and kernel (TODO)
  */
 
-enum kvp_op {
-	KVP_REGISTER = 0, /* Register the user mode component*/
-	KVP_KERNEL_GET, /*Kernel is requesting the value for the specified key*/
-	KVP_KERNEL_SET, /*Kernel is providing the value for the specified key*/
-	KVP_USER_GET, /*User is requesting the value for the specified key*/
-	KVP_USER_SET /*User is providing the value for the specified key*/
-};
-
-#define HV_KVP_EXCHANGE_MAX_KEY_SIZE	512
-#define HV_KVP_EXCHANGE_MAX_VALUE_SIZE	2048
-
-struct hv_ku_msg {
-	__u32	kvp_index;
-	__u8  kvp_key[HV_KVP_EXCHANGE_MAX_KEY_SIZE]; /* Key name */
-	__u8  kvp_value[HV_KVP_EXCHANGE_MAX_VALUE_SIZE]; /* Key  value */
-};
 
 enum key_index {
 	FullyQualifiedDomainName = 0,
@@ -89,10 +67,6 @@ enum key_index {
 	ProcessorArchitecture
 };
 
-/*
- * End of shared definitions.
- */
-
 static char kvp_send_buffer[4096];
 static char kvp_recv_buffer[4096];
 static struct sockaddr_nl addr;
-- 
1.7.4.1
