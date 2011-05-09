From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 183/206] Staging: hv: Include the new header files in the network driver
Date: Mon,  9 May 2011 14:57:45 -0700
Message-ID: <1304978288-22999-183-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Include the new header files in the network driver.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/netvsc.c       |    7 ++-----
 drivers/staging/hv/netvsc_drv.c   |    8 +++-----
 drivers/staging/hv/rndis_filter.c |    8 ++++----
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
index 4eb4482..e489a32 100644
--- a/drivers/staging/hv/netvsc.c
+++ b/drivers/staging/hv/netvsc.c
@@ -27,12 +27,9 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/slab.h>
-#include "hv_api.h"
-#include "logging.h"
-#include "netvsc.h"
-#include "rndis_filter.h"
-#include "channel.h"
 
+#include <linux/hyperv.h>
+#include "hyperv_net.h"
 
 /* Globals */
 static const char *driver_name = "netvsc";
diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index c5e7b93..aac6748 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -38,11 +38,9 @@
 #include <net/route.h>
 #include <net/sock.h>
 #include <net/pkt_sched.h>
-#include "hv_api.h"
-#include "logging.h"
-#include "version_info.h"
-#include "vmbus.h"
-#include "netvsc_api.h"
+
+#include <linux/hyperv.h>
+#include "hyperv_net.h"
 
 struct net_device_context {
 	/* point back to our device context */
diff --git a/drivers/staging/hv/rndis_filter.c b/drivers/staging/hv/rndis_filter.c
index 2037836..727b810 100644
--- a/drivers/staging/hv/rndis_filter.c
+++ b/drivers/staging/hv/rndis_filter.c
@@ -26,10 +26,10 @@
 #include <linux/io.h>
 #include <linux/if_ether.h>
 #include <linux/netdevice.h>
-#include "logging.h"
-#include "hv_api.h"
-#include "netvsc_api.h"
-#include "rndis_filter.h"
+
+#include <linux/hyperv.h>
+#include "hyperv_net.h"
+
 
 /* Data types */
 struct rndis_filter_driver_object {
-- 
1.7.4.1
