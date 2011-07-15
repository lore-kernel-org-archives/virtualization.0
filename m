From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 093/117] Staging: hv: netvsc: Get rid of release_outbound_net_device() by inlining the code
Date: Fri, 15 Jul 2011 10:47:21 -0700
Message-ID: <1310752065-27895-93-git-send-email-kys@microsoft.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
 <1310752065-27895-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1310752065-27895-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of release_outbound_net_device() by inlining the code.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/netvsc.c |   45 ++++++++++++++++--------------------------
 1 files changed, 17 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
index 7c3d7ac..3975219 100644
--- a/drivers/staging/hv/netvsc.c
+++ b/drivers/staging/hv/netvsc.c
@@ -98,28 +98,6 @@ static void put_net_device(struct hv_device *device)
 	spin_unlock_irqrestore(&device->ext_lock, flags);
 }
 
-static struct netvsc_device *release_outbound_net_device(
-		struct hv_device *device)
-{
-	struct netvsc_device *net_device;
-	unsigned long flags;
-
-	spin_lock_irqsave(&device->ext_lock, flags);
-	net_device = device->ext;
-	if (net_device == NULL) {
-		spin_unlock_irqrestore(&device->ext_lock, flags);
-		return NULL;
-	}
-
-	spin_unlock_irqrestore(&device->ext_lock, flags);
-
-	/* Busy wait until the ref drop to 2, then set it to 1 */
-	while (atomic_cmpxchg(&net_device->refcnt, 2, 1) != 2)
-		udelay(100);
-
-	return net_device;
-}
-
 static struct netvsc_device *release_inbound_net_device(
 		struct hv_device *device)
 {
@@ -424,13 +402,13 @@ int netvsc_device_remove(struct hv_device *device)
 	unsigned long flags;
 
 
-	/* Stop outbound traffic ie sends and receives completions */
-	net_device = release_outbound_net_device(device);
-	if (!net_device) {
-		dev_err(&device->device, "No net device present!!");
+	spin_lock_irqsave(&device->ext_lock, flags);
+	net_device = (struct netvsc_device *)device->ext;
+	if (net_device == NULL) {
+		spin_unlock_irqrestore(&device->ext_lock, flags);
 		return -ENODEV;
 	}
-	spin_lock_irqsave(&device->ext_lock, flags);
+	atomic_dec(&net_device->refcnt);
 	net_device->destroy = true;
 	spin_unlock_irqrestore(&device->ext_lock, flags);
 
@@ -448,6 +426,18 @@ int netvsc_device_remove(struct hv_device *device)
 	/* Stop inbound traffic ie receives and sends completions */
 	net_device = release_inbound_net_device(device);
 
+	/*
+	 * Wait until the ref cnt falls to 0.
+	 * We have already stopped any new references
+	 * for outgoing traffic. Also, at this point we don't have any
+	 * incoming traffic as well. So this must be outgoing refrences
+	 * established prior to marking the device as being destroyed.
+	 * Since the send path is non-blocking, it is reasonable to busy
+	 * wait here.
+	 */
+	while (atomic_read(&net_device->refcnt))
+		udelay(100);
+
 	/* At this point, no one should be accessing netDevice except in here */
 	dev_notice(&device->device, "net device safe to remove");
 
@@ -1000,7 +990,6 @@ cleanup:
 			kfree(packet);
 		}
 
-		release_outbound_net_device(device);
 		release_inbound_net_device(device);
 
 		kfree(net_device);
-- 
1.7.4.1
