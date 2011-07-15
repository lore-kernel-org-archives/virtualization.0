From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 096/117] Staging: hv: netvsc: Further cleanup reference
	counting of netvsc_device
Date: Fri, 15 Jul 2011 10:47:24 -0700
Message-ID: <1310752065-27895-96-git-send-email-kys@microsoft.com>
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

Further cleanup reference counting of netvsc_device. Since once the device
is marked for destruction, we only allow incoming traffic to drain out
outstanding sends, we can simplify reference counting.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/netvsc.c |   27 ++++++++++++++++++---------
 1 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
index 4ef17d8..16a80b1 100644
--- a/drivers/staging/hv/netvsc.c
+++ b/drivers/staging/hv/netvsc.c
@@ -17,6 +17,7 @@
  * Authors:
  *   Haiyang Zhang <haiyangz@microsoft.com>
  *   Hank Janssen  <hjanssen@microsoft.com>
+ *   K. Y. Srinivasan <kys@microsoft.com>
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
@@ -40,8 +41,7 @@ static struct netvsc_device *alloc_net_device(struct hv_device *device)
 	if (!net_device)
 		return NULL;
 
-	/* Set to 2 to allow both inbound and outbound traffic */
-	net_device->refcnt = 2;
+	net_device->refcnt = 1;
 
 	net_device->destroy = false;
 	net_device->dev = device;
@@ -50,7 +50,6 @@ static struct netvsc_device *alloc_net_device(struct hv_device *device)
 	return net_device;
 }
 
-/* Get the net device object iff exists and its refcount > 1 */
 static struct netvsc_device *get_outbound_net_device(struct hv_device *device)
 {
 	struct netvsc_device *net_device;
@@ -58,7 +57,7 @@ static struct netvsc_device *get_outbound_net_device(struct hv_device *device)
 
 	spin_lock_irqsave(&device->ext_lock, flags);
 	net_device = device->ext;
-	if (net_device && (net_device->refcnt > 1) &&
+	if (net_device && (net_device->refcnt) &&
 		!net_device->destroy)
 		net_device->refcnt++;
 	else
@@ -68,7 +67,6 @@ static struct netvsc_device *get_outbound_net_device(struct hv_device *device)
 	return net_device;
 }
 
-/* Get the net device object iff exists and its refcount > 0 */
 static struct netvsc_device *get_inbound_net_device(struct hv_device *device)
 {
 	struct netvsc_device *net_device;
@@ -76,11 +74,23 @@ static struct netvsc_device *get_inbound_net_device(struct hv_device *device)
 
 	spin_lock_irqsave(&device->ext_lock, flags);
 	net_device = device->ext;
-	if (net_device && net_device->refcnt)
-		net_device->refcnt++;
-	else
+
+	if (!net_device)
+		goto cleanup;
+
+	/*
+	 * If the device is being destroyed; allow incoming
+	 * traffic only to cleanup outstanding requests.
+	 */
+	if (net_device->destroy &&
+		(atomic_read(&net_device->num_outstanding_sends) == 0)) {
 		net_device = NULL;
+		goto cleanup;
+	}
 
+	net_device->refcnt++;
+
+cleanup:
 	spin_unlock_irqrestore(&device->ext_lock, flags);
 	return net_device;
 }
@@ -400,7 +410,6 @@ int netvsc_device_remove(struct hv_device *device)
 	netvsc_disconnect_vsp(net_device);
 
 	spin_lock_irqsave(&device->ext_lock, flags);
-	net_device->refcnt--;
 	device->ext = NULL;
 	spin_unlock_irqrestore(&device->ext_lock, flags);
 
-- 
1.7.4.1
