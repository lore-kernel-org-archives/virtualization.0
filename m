From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 17/40] Staging: hv: netvsc: Use the newly introduced lock in
	accessing ext field
Date: Wed, 29 Jun 2011 07:39:14 -0700
Message-ID: <1309358377-8537-17-git-send-email-kys@microsoft.com>
References: <1309358301-8488-1-git-send-email-kys@microsoft.com>
	<1309358377-8537-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1309358377-8537-1-git-send-email-kys@microsoft.com>
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
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

The current reference counting mechanism is broken; use the newly introduced
lock to access the net_device pointer in struct hv_device.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/netvsc.c |   24 ++++++++++++++++++++++--
 1 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
index f03018c..531de63 100644
--- a/drivers/staging/hv/netvsc.c
+++ b/drivers/staging/hv/netvsc.c
@@ -56,12 +56,15 @@ static struct netvsc_device *alloc_net_device(struct hv_device *device)
 static struct netvsc_device *get_outbound_net_device(struct hv_device *device)
 {
 	struct netvsc_device *net_device;
+	unsigned long flags;
 
+	spin_lock_irqsave(&device->ext_lock, flags);
 	net_device = device->ext;
 	if (net_device && atomic_read(&net_device->refcnt) > 1)
 		atomic_inc(&net_device->refcnt);
 	else
 		net_device = NULL;
+	spin_unlock_irqrestore(&device->ext_lock, flags);
 
 	return net_device;
 }
@@ -70,38 +73,50 @@ static struct netvsc_device *get_outbound_net_device(struct hv_device *device)
 static struct netvsc_device *get_inbound_net_device(struct hv_device *device)
 {
 	struct netvsc_device *net_device;
+	unsigned long flags;
 
+	spin_lock_irqsave(&device->ext_lock, flags);
 	net_device = device->ext;
 	if (net_device && atomic_read(&net_device->refcnt))
 		atomic_inc(&net_device->refcnt);
 	else
 		net_device = NULL;
 
+	spin_unlock_irqrestore(&device->ext_lock, flags);
 	return net_device;
 }
 
 static void put_net_device(struct hv_device *device)
 {
 	struct netvsc_device *net_device;
+	unsigned long flags;
+
+	spin_lock_irqsave(&device->ext_lock, flags);
 
 	net_device = device->ext;
 
 	atomic_dec(&net_device->refcnt);
+	spin_unlock_irqrestore(&device->ext_lock, flags);
 }
 
 static struct netvsc_device *release_outbound_net_device(
 		struct hv_device *device)
 {
 	struct netvsc_device *net_device;
+	unsigned long flags;
 
+	spin_lock_irqsave(&device->ext_lock, flags);
 	net_device = device->ext;
-	if (net_device == NULL)
+	if (net_device == NULL) {
+		spin_unlock_irqrestore(&device->ext_lock, flags);
 		return NULL;
+	}
 
 	/* Busy wait until the ref drop to 2, then set it to 1 */
 	while (atomic_cmpxchg(&net_device->refcnt, 2, 1) != 2)
 		udelay(100);
 
+	spin_unlock_irqrestore(&device->ext_lock, flags);
 	return net_device;
 }
 
@@ -109,16 +124,21 @@ static struct netvsc_device *release_inbound_net_device(
 		struct hv_device *device)
 {
 	struct netvsc_device *net_device;
+	unsigned long flags;
 
+	spin_lock_irqsave(&device->ext_lock, flags);
 	net_device = device->ext;
-	if (net_device == NULL)
+	if (net_device == NULL) {
+		spin_unlock_irqrestore(&device->ext_lock, flags);
 		return NULL;
+	}
 
 	/* Busy wait until the ref drop to 1, then set it to 0 */
 	while (atomic_cmpxchg(&net_device->refcnt, 1, 0) != 1)
 		udelay(100);
 
 	device->ext = NULL;
+	spin_unlock_irqrestore(&device->ext_lock, flags);
 	return net_device;
 }
 
-- 
1.7.4.1
