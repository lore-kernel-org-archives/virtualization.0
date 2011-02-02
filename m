From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH] staging: hv: Enable sending GARP packet after live migration
Date: Wed,  2 Feb 2011 13:42:58 -0800
Message-ID: <1296682978-19223-1-git-send-email-haiyangz@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: haiyangz@microsoft.com, hjanssen@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: stable <stable@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

The hv_netvsc gets RNDIS_STATUS_MEDIA_CONNECT event after the VM
is live migrated. Adding call to netif_notify_peers() for this event
to send GARP (Gratuitous ARP) to notify network peers. Otherwise,
the VM's network connection may stop after a live migration.

This patch should also be applied to stable kernel 2.6.32 and later.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
Cc: stable <stable@kernel.org>
---
 drivers/staging/hv/netvsc_drv.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index 54706a1..b41c964 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -236,6 +236,7 @@ static void netvsc_linkstatus_callback(struct hv_device *device_obj,
 	if (status == 1) {
 		netif_carrier_on(net);
 		netif_wake_queue(net);
+		netif_notify_peers(net);
 	} else {
 		netif_carrier_off(net);
 		netif_stop_queue(net);
-- 
1.5.5.6
