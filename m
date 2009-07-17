From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 15/54] Staging: hv: make the Hyper-V virtual network driver
	build
Date: Fri, 17 Jul 2009 11:09:05 -0700
Message-ID: <20090717180918.271727173@mini.kroah.org>
References: <20090717180850.873962925@mini.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=staging-hv-make-the-hyper-v-virtual-network-driver-build.patch
In-Reply-To: <20090720160025.GA20249@kroah.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, virtualization@lists.osdl.org
Cc: Sam Ramji <sramji@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>, shemminger@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Greg Kroah-Hartman <gregkh@suse.de>

The #define KERNEL_2_6_27 needs to be set, and I adjusted the include
directories a bit to get things to build properly.

The driver was changed to use net_device_ops, as that is needed to build
and operate properly now.

The hv_netvsc code should now build with no errors.

Cc: Hank Janssen <hjanssen@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/staging/hv/NetVsc.c               |    3 ++-
 drivers/staging/hv/NetVsc.h               |    8 ++++----
 drivers/staging/hv/RndisFilter.c          |    5 +++--
 drivers/staging/hv/RndisFilter.h          |    4 ++--
 drivers/staging/hv/include/nvspprotocol.h |    2 +-
 drivers/staging/hv/netvsc_drv.c           |   21 +++++++++++++--------
 6 files changed, 25 insertions(+), 18 deletions(-)

--- a/drivers/staging/hv/include/nvspprotocol.h
+++ b/drivers/staging/hv/include/nvspprotocol.h
@@ -24,7 +24,7 @@
 
 #pragma once
 
-#include <VmbusChannelInterface.h>
+#include "VmbusChannelInterface.h"
 
 #define NVSP_INVALID_PROTOCOL_VERSION           ((UINT32)0xFFFFFFFF)
 
--- a/drivers/staging/hv/NetVsc.c
+++ b/drivers/staging/hv/NetVsc.c
@@ -20,8 +20,9 @@
  *
  */
 
+#define KERNEL_2_6_27
 
-#include "logging.h"
+#include "include/logging.h"
 #include "NetVsc.h"
 #include "RndisFilter.h"
 
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -20,6 +20,7 @@
  *
  */
 
+#define KERNEL_2_6_27
 
 #include <linux/init.h>
 #include <linux/module.h>
@@ -41,10 +42,10 @@
 #include <net/sock.h>
 #include <net/pkt_sched.h>
 
-#include "logging.h"
-#include "vmbus.h"
+#include "include/logging.h"
+#include "include/vmbus.h"
 
-#include "NetVscApi.h"
+#include "include/NetVscApi.h"
 
 MODULE_LICENSE("GPL");
 
@@ -158,6 +159,14 @@ static void netvsc_set_multicast_list(UN
 }
 
 
+static const struct net_device_ops device_ops = {
+	.ndo_open = netvsc_open,
+	.ndo_stop = netvsc_close,
+	.ndo_start_xmit	= netvsc_start_xmit,
+	.ndo_get_stats = netvsc_get_stats,
+	.ndo_set_multicast_list = netvsc_set_multicast_list,
+};
+
 /*++
 
 Name:	netvsc_probe()
@@ -225,11 +234,7 @@ static int netvsc_probe(struct device *d
 
 	memcpy(net->dev_addr, device_info.MacAddr, ETH_ALEN);
 
-	net->open				= netvsc_open;
-	net->hard_start_xmit	= netvsc_start_xmit;
-	net->stop				= netvsc_close;
-	net->get_stats			= netvsc_get_stats;
-	net->set_multicast_list = netvsc_set_multicast_list;
+	net->netdev_ops = &device_ops;
 
 #if !defined(KERNEL_2_6_27)
 	SET_MODULE_OWNER(net);
--- a/drivers/staging/hv/NetVsc.h
+++ b/drivers/staging/hv/NetVsc.h
@@ -24,12 +24,12 @@
 #ifndef _NETVSC_H_
 #define _NETVSC_H_
 
-#include "VmbusPacketFormat.h"
-#include "nvspprotocol.h"
+#include "include/VmbusPacketFormat.h"
+#include "include/nvspprotocol.h"
 
-#include "List.h"
+#include "include/List.h"
 
-#include "NetVscApi.h"
+#include "include/NetVscApi.h"
 //
 // #defines
 //
--- a/drivers/staging/hv/RndisFilter.c
+++ b/drivers/staging/hv/RndisFilter.c
@@ -21,10 +21,11 @@
  *
  */
 
+#define KERNEL_2_6_27
 
-#include "logging.h"
+#include "include/logging.h"
 
-#include "NetVscApi.h"
+#include "include/NetVscApi.h"
 #include "RndisFilter.h"
 
 //
--- a/drivers/staging/hv/RndisFilter.h
+++ b/drivers/staging/hv/RndisFilter.h
@@ -27,10 +27,10 @@
 
 #define __struct_bcount(x)
 
-#include "osd.h"
+#include "include/osd.h"
 #include "NetVsc.h"
 
-#include "rndis.h"
+#include "include/rndis.h"
 
 #define RNDIS_HEADER_SIZE	(sizeof(RNDIS_MESSAGE) - sizeof(RNDIS_MESSAGE_CONTAINER))
