From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 07/16] Staging: hv: Move the definition of
	stor_vsc_initialize()
Date: Wed, 23 Mar 2011 10:50:25 -0700
Message-ID: <1300902635-1347-7-git-send-email-kys@microsoft.com>
References: <1300902537-1290-1-git-send-email-kys@microsoft.com>
	<1300902635-1347-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1300902635-1347-1-git-send-email-kys@microsoft.com>
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

Since stor_vsc_initialize() is only used in storvs_drv.c, move this
function to storvsc_drv.c.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc.c     |   64 --------------------------------------
 drivers/staging/hv/storvsc_drv.c |   63 +++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 64 deletions(-)

diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index 1f05aa6..83d012b 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -33,18 +33,6 @@
 #include "channel.h"
 
 
-
-static const char *g_driver_name = "storvsc";
-
-/* {ba6163d9-04a1-4d29-b605-72e2ffb1dc7f} */
-static const struct hv_guid gStorVscDeviceType = {
-	.data = {
-		0xd9, 0x63, 0x61, 0xba, 0xa1, 0x04, 0x29, 0x4d,
-		0xb6, 0x05, 0x72, 0xe2, 0xff, 0xb1, 0xdc, 0x7f
-	}
-};
-
-
 static inline struct storvsc_device *alloc_stor_device(struct hv_device *device)
 {
 	struct storvsc_device *stor_device;
@@ -711,55 +699,3 @@ void stor_vsc_on_cleanup(struct hv_driver *driver)
 {
 }
 
-/*
- * stor_vsc_initialize - Main entry point
- */
-int stor_vsc_initialize(struct hv_driver *driver)
-{
-	struct storvsc_driver_object *stor_driver;
-
-	stor_driver = (struct storvsc_driver_object *)driver;
-
-	DPRINT_DBG(STORVSC, "sizeof(STORVSC_REQUEST)=%zd "
-		   "sizeof(struct storvsc_request_extension)=%zd "
-		   "sizeof(struct vstor_packet)=%zd, "
-		   "sizeof(struct vmscsi_request)=%zd",
-		   sizeof(struct hv_storvsc_request),
-		   sizeof(struct storvsc_request_extension),
-		   sizeof(struct vstor_packet),
-		   sizeof(struct vmscsi_request));
-
-	/* Make sure we are at least 2 pages since 1 page is used for control */
-
-	driver->name = g_driver_name;
-	memcpy(&driver->dev_type, &gStorVscDeviceType,
-	       sizeof(struct hv_guid));
-
-	stor_driver->request_ext_size =
-			sizeof(struct storvsc_request_extension);
-
-	/*
-	 * Divide the ring buffer data size (which is 1 page less
-	 * than the ring buffer size since that page is reserved for
-	 * the ring buffer indices) by the max request size (which is
-	 * vmbus_channel_packet_multipage_buffer + struct vstor_packet + u64)
-	 */
-	stor_driver->max_outstanding_req_per_channel =
-		((stor_driver->ring_buffer_size - PAGE_SIZE) /
-		  ALIGN(MAX_MULTIPAGE_BUFFER_PACKET +
-			   sizeof(struct vstor_packet) + sizeof(u64),
-			   sizeof(u64)));
-
-	DPRINT_INFO(STORVSC, "max io %u, currently %u\n",
-		    stor_driver->max_outstanding_req_per_channel,
-		    STORVSC_MAX_IO_REQUESTS);
-
-	/* Setup the dispatch table */
-	stor_driver->base.dev_add	= stor_vsc_on_device_add;
-	stor_driver->base.dev_rm	= stor_vsc_on_device_remove;
-	stor_driver->base.cleanup	= stor_vsc_on_cleanup;
-
-	stor_driver->on_io_request	= stor_vsc_on_io_request;
-
-	return 0;
-}
diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index e6462a2..5ea09da 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -38,6 +38,16 @@
 #include "storvsc_api.h"
 
 
+static const char *g_driver_name = "storvsc";
+
+/* {ba6163d9-04a1-4d29-b605-72e2ffb1dc7f} */
+static const struct hv_guid gStorVscDeviceType = {
+	.data = {
+		0xd9, 0x63, 0x61, 0xba, 0xa1, 0x04, 0x29, 0x4d,
+		0xb6, 0x05, 0x72, 0xe2, 0xff, 0xb1, 0xdc, 0x7f
+	}
+};
+
 struct host_device_context {
 	/* must be 1st field
 	 * FIXME this is a bug */
@@ -64,6 +74,59 @@ struct storvsc_cmd_request {
 };
 
 
+/*
+ * stor_vsc_initialize - Main entry point
+ */
+int stor_vsc_initialize(struct hv_driver *driver)
+{
+	struct storvsc_driver_object *stor_driver;
+
+	stor_driver = (struct storvsc_driver_object *)driver;
+
+	DPRINT_DBG(STORVSC, "sizeof(STORVSC_REQUEST)=%zd "
+		   "sizeof(struct storvsc_request_extension)=%zd "
+		   "sizeof(struct vstor_packet)=%zd, "
+		   "sizeof(struct vmscsi_request)=%zd",
+		   sizeof(struct hv_storvsc_request),
+		   sizeof(struct storvsc_request_extension),
+		   sizeof(struct vstor_packet),
+		   sizeof(struct vmscsi_request));
+
+	/* Make sure we are at least 2 pages since 1 page is used for control */
+
+	driver->name = g_driver_name;
+	memcpy(&driver->dev_type, &gStorVscDeviceType,
+	       sizeof(struct hv_guid));
+
+	stor_driver->request_ext_size =
+			sizeof(struct storvsc_request_extension);
+
+	/*
+	 * Divide the ring buffer data size (which is 1 page less
+	 * than the ring buffer size since that page is reserved for
+	 * the ring buffer indices) by the max request size (which is
+	 * vmbus_channel_packet_multipage_buffer + struct vstor_packet + u64)
+	 */
+	stor_driver->max_outstanding_req_per_channel =
+		((stor_driver->ring_buffer_size - PAGE_SIZE) /
+		  ALIGN(MAX_MULTIPAGE_BUFFER_PACKET +
+			   sizeof(struct vstor_packet) + sizeof(u64),
+			   sizeof(u64)));
+
+	DPRINT_INFO(STORVSC, "max io %u, currently %u\n",
+		    stor_driver->max_outstanding_req_per_channel,
+		    STORVSC_MAX_IO_REQUESTS);
+
+	/* Setup the dispatch table */
+	stor_driver->base.dev_add	= stor_vsc_on_device_add;
+	stor_driver->base.dev_rm	= stor_vsc_on_device_remove;
+	stor_driver->base.cleanup	= stor_vsc_on_cleanup;
+
+	stor_driver->on_io_request	= stor_vsc_on_io_request;
+
+	return 0;
+}
+
 /* Static decl */
 static int storvsc_probe(struct device *dev);
 static int storvsc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmnd);
-- 
1.7.4.1
