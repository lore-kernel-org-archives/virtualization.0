From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 094/117] Staging: hv: netvsc: Get rid of
	release_inbound_net_device() by inlining the code
Date: Fri, 15 Jul 2011 10:47:22 -0700
Message-ID: <1310752065-27895-94-git-send-email-kys@microsoft.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1310752065-27895-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of release_inbound_net_device() by inlining the code.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/netvsc.c |   32 ++++----------------------------
 1 files changed, 4 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
index 3975219..6805137 100644
--- a/drivers/staging/hv/netvsc.c
+++ b/drivers/staging/hv/netvsc.c
@@ -98,30 +98,6 @@ static void put_net_device(struct hv_device *device)
 	spin_unlock_irqrestore(&device->ext_lock, flags);
 }
 
-static struct netvsc_device *release_inbound_net_device(
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
-	/* Busy wait until the ref drop to 1, then set it to 0 */
-	while (atomic_cmpxchg(&net_device->refcnt, 1, 0) != 1)
-		udelay(100);
-
-	spin_lock_irqsave(&device->ext_lock, flags);
-	device->ext = NULL;
-	spin_unlock_irqrestore(&device->ext_lock, flags);
-	return net_device;
-}
-
 static int netvsc_destroy_recv_buf(struct netvsc_device *net_device)
 {
 	struct nvsp_message *revoke_packet;
@@ -423,8 +399,10 @@ int netvsc_device_remove(struct hv_device *device)
 
 	netvsc_disconnect_vsp(net_device);
 
-	/* Stop inbound traffic ie receives and sends completions */
-	net_device = release_inbound_net_device(device);
+	spin_lock_irqsave(&device->ext_lock, flags);
+	atomic_dec(&net_device->refcnt);
+	device->ext = NULL;
+	spin_unlock_irqrestore(&device->ext_lock, flags);
 
 	/*
 	 * Wait until the ref cnt falls to 0.
@@ -990,8 +968,6 @@ cleanup:
 			kfree(packet);
 		}
 
-		release_inbound_net_device(device);
-
 		kfree(net_device);
 	}
 
-- 
1.7.4.1
