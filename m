From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 051/206] Staging: hv: Move the definition of
	storvsc_host_reset() to earlier in the file
Date: Mon,  9 May 2011 14:55:33 -0700
Message-ID: <1304978288-22999-51-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
	<1304978288-22999-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
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

The subject line says it all.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |   99 +++++++++++++++++++-------------------
 1 files changed, 50 insertions(+), 49 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 28b8569..3b2917e 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -461,6 +461,56 @@ static int storvsc_get_chs(struct scsi_device *sdev, struct block_device * bdev,
 
 	return 0;
 }
+
+static int storvsc_host_reset(struct hv_device *device)
+{
+	struct storvsc_device *stor_device;
+	struct hv_storvsc_request *request;
+	struct vstor_packet *vstor_packet;
+	int ret, t;
+
+	DPRINT_INFO(STORVSC, "resetting host adapter...");
+
+	stor_device = get_stor_device(device);
+	if (!stor_device)
+		return -1;
+
+	request = &stor_device->reset_request;
+	vstor_packet = &request->vstor_packet;
+
+	init_completion(&request->wait_event);
+
+	vstor_packet->operation = VSTOR_OPERATION_RESET_BUS;
+	vstor_packet->flags = REQUEST_COMPLETION_FLAG;
+	vstor_packet->vm_srb.path_id = stor_device->path_id;
+
+	ret = vmbus_sendpacket(device->channel, vstor_packet,
+			       sizeof(struct vstor_packet),
+			       (unsigned long)&stor_device->reset_request,
+			       VM_PKT_DATA_INBAND,
+			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
+	if (ret != 0)
+		goto cleanup;
+
+	t = wait_for_completion_timeout(&request->wait_event, HZ);
+	if (t == 0) {
+		ret = -ETIMEDOUT;
+		goto cleanup;
+	}
+
+	DPRINT_INFO(STORVSC, "host adapter reset completed");
+
+	/*
+	 * At this point, all outstanding requests in the adapter
+	 * should have been flushed out and return to us
+	 */
+
+cleanup:
+	put_stor_device(device);
+	return ret;
+}
+
+
 /* Static decl */
 static int storvsc_probe(struct hv_device *dev);
 static int storvsc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmnd);
@@ -535,55 +585,6 @@ static int storvsc_drv_init(void)
 	return ret;
 }
 
-
-static int storvsc_host_reset(struct hv_device *device)
-{
-	struct storvsc_device *stor_device;
-	struct hv_storvsc_request *request;
-	struct vstor_packet *vstor_packet;
-	int ret, t;
-
-	DPRINT_INFO(STORVSC, "resetting host adapter...");
-
-	stor_device = get_stor_device(device);
-	if (!stor_device)
-		return -1;
-
-	request = &stor_device->reset_request;
-	vstor_packet = &request->vstor_packet;
-
-	init_completion(&request->wait_event);
-
-	vstor_packet->operation = VSTOR_OPERATION_RESET_BUS;
-	vstor_packet->flags = REQUEST_COMPLETION_FLAG;
-	vstor_packet->vm_srb.path_id = stor_device->path_id;
-
-	ret = vmbus_sendpacket(device->channel, vstor_packet,
-			       sizeof(struct vstor_packet),
-			       (unsigned long)&stor_device->reset_request,
-			       VM_PKT_DATA_INBAND,
-			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
-	if (ret != 0)
-		goto cleanup;
-
-	t = wait_for_completion_timeout(&request->wait_event, HZ);
-	if (t == 0) {
-		ret = -ETIMEDOUT;
-		goto cleanup;
-	}
-
-	DPRINT_INFO(STORVSC, "host adapter reset completed");
-
-	/*
-	 * At this point, all outstanding requests in the adapter
-	 * should have been flushed out and return to us
-	 */
-
-cleanup:
-	put_stor_device(device);
-	return ret;
-}
-
 static int storvsc_drv_exit_cb(struct device *dev, void *data)
 {
 	struct device **curr = (struct device **)data;
-- 
1.7.4.1
