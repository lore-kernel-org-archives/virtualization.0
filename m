From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 3/4] staging: hv: Fix the code depending on struct
	blkvsc_driver_context data order
Date: Wed, 23 Feb 2011 12:19:57 -0800
Message-ID: <1298492398-16522-3-git-send-email-haiyangz__2545.15776546231$1298491975$gmane$org@microsoft.com>
References: <1298492398-16522-1-git-send-email-haiyangz@microsoft.com>
	<1298492398-16522-2-git-send-email-haiyangz@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1298492398-16522-2-git-send-email-haiyangz@microsoft.com>
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
struct blkvsc_driver_context. Now, we use container_of() instead of type
casting from the first field to the container struct.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>

---
 drivers/staging/hv/blkvsc_drv.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 293ab8e..8f38895 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -117,8 +117,6 @@ struct block_device_context {
 
 /* Per driver */
 struct blkvsc_driver_context {
-	/* !! These must be the first 2 fields !! */
-	/* FIXME this is a bug! */
 	struct driver_context drv_ctx;
 	struct storvsc_driver_object drv_obj;
 };
@@ -248,7 +246,7 @@ static int blkvsc_probe(struct device *device)
 	struct driver_context *driver_ctx =
 				driver_to_driver_context(device->driver);
 	struct blkvsc_driver_context *blkvsc_drv_ctx =
-				(struct blkvsc_driver_context *)driver_ctx;
+		container_of(driver_ctx, struct blkvsc_driver_context, drv_ctx);
 	struct storvsc_driver_object *storvsc_drv_obj =
 				&blkvsc_drv_ctx->drv_obj;
 	struct vm_device *device_ctx = device_to_vm_device(device);
@@ -733,7 +731,7 @@ static int blkvsc_remove(struct device *device)
 	struct driver_context *driver_ctx =
 				driver_to_driver_context(device->driver);
 	struct blkvsc_driver_context *blkvsc_drv_ctx =
-				(struct blkvsc_driver_context *)driver_ctx;
+		container_of(driver_ctx, struct blkvsc_driver_context, drv_ctx);
 	struct storvsc_driver_object *storvsc_drv_obj =
 				&blkvsc_drv_ctx->drv_obj;
 	struct vm_device *device_ctx = device_to_vm_device(device);
@@ -856,7 +854,7 @@ static int blkvsc_submit_request(struct blkvsc_request *blkvsc_req,
 	struct driver_context *driver_ctx =
 			driver_to_driver_context(device_ctx->device.driver);
 	struct blkvsc_driver_context *blkvsc_drv_ctx =
-			(struct blkvsc_driver_context *)driver_ctx;
+		container_of(driver_ctx, struct blkvsc_driver_context, drv_ctx);
 	struct storvsc_driver_object *storvsc_drv_obj =
 			&blkvsc_drv_ctx->drv_obj;
 	struct hv_storvsc_request *storvsc_req;
-- 
1.6.3.2
