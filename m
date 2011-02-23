From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 2/4] staging: hv: Fix the code depending on struct
	netvsc_driver_context data order
Date: Wed, 23 Feb 2011 12:19:56 -0800
Message-ID: <1298492398-16522-2-git-send-email-haiyangz__38040.9588142813$1298492375$gmane$org@microsoft.com>
References: <1298492398-16522-1-git-send-email-haiyangz@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1298492398-16522-1-git-send-email-haiyangz@microsoft.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: haiyangz@microsoft.com, hjanssen@microsoft.com, kys@microsoft.com, v-abkane@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, vir
List-Id: virtualization@lists.linuxfoundation.org

The patch fixed the code depending on the exact order of fields in the
struct netvsc_driver_context. Now, we use container_of() instead of type
casting from the first field to the container struct.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>

---
 drivers/staging/hv/netvsc_drv.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index 364b6c7..c78624c 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -49,8 +49,6 @@ struct net_device_context {
 };
 
 struct netvsc_driver_context {
-	/* !! These must be the first 2 fields !! */
-	/* Which is a bug FIXME! */
 	struct driver_context drv_ctx;
 	struct netvsc_driver drv_obj;
 };
@@ -137,8 +135,8 @@ static int netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
 	struct net_device_context *net_device_ctx = netdev_priv(net);
 	struct driver_context *driver_ctx =
 	    driver_to_driver_context(net_device_ctx->device_ctx->device.driver);
-	struct netvsc_driver_context *net_drv_ctx =
-		(struct netvsc_driver_context *)driver_ctx;
+	struct netvsc_driver_context *net_drv_ctx = container_of(driver_ctx,
+		struct netvsc_driver_context, drv_ctx);
 	struct netvsc_driver *net_drv_obj = &net_drv_ctx->drv_obj;
 	struct hv_netvsc_packet *packet;
 	int ret;
@@ -342,8 +340,8 @@ static int netvsc_probe(struct device *device)
 {
 	struct driver_context *driver_ctx =
 		driver_to_driver_context(device->driver);
-	struct netvsc_driver_context *net_drv_ctx =
-		(struct netvsc_driver_context *)driver_ctx;
+	struct netvsc_driver_context *net_drv_ctx = container_of(driver_ctx,
+		struct netvsc_driver_context, drv_ctx);
 	struct netvsc_driver *net_drv_obj = &net_drv_ctx->drv_obj;
 	struct vm_device *device_ctx = device_to_vm_device(device);
 	struct hv_device *device_obj = &device_ctx->device_obj;
@@ -414,8 +412,8 @@ static int netvsc_remove(struct device *device)
 {
 	struct driver_context *driver_ctx =
 		driver_to_driver_context(device->driver);
-	struct netvsc_driver_context *net_drv_ctx =
-		(struct netvsc_driver_context *)driver_ctx;
+	struct netvsc_driver_context *net_drv_ctx = container_of(driver_ctx,
+		struct netvsc_driver_context, drv_ctx);
 	struct netvsc_driver *net_drv_obj = &net_drv_ctx->drv_obj;
 	struct vm_device *device_ctx = device_to_vm_device(device);
 	struct net_device *net = dev_get_drvdata(&device_ctx->device);
-- 
1.6.3.2
