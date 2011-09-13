From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 12/20] Staging: hv: storvsc: Eliminate the usage of ext field
	in struct hv_device
Date: Tue, 13 Sep 2011 10:59:48 -0700
Message-ID: <1315936796-20662-12-git-send-email-kys@microsoft.com>
References: <1315936759-20623-1-git-send-email-kys@microsoft.com>
	<1315936796-20662-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1315936796-20662-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Now, eliminate the usage of ext field in struct  hv_device for storvsc driver.
We do this by registering pointer to struct storvsc_device as the driver
specific data and eliminating the current usage of driver specific data to
save and retrieve the pointer to struct Scsi_Host.
Additionally, all access to the driver specific data is through
the vmbus wrapper functions. Note that function to allocate the host
gives us a reference on the host object.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 5e306a5..807c94d 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -266,6 +266,7 @@ struct storvsc_device {
 	bool	 destroy;
 	bool	 drain_notify;
 	atomic_t num_outstanding_req;
+	struct Scsi_Host *host;
 
 	wait_queue_head_t waiting_to_drain;
 
@@ -306,7 +307,7 @@ static inline struct storvsc_device *get_out_stor_device(
 {
 	struct storvsc_device *stor_device;
 
-	stor_device = (struct storvsc_device *)device->ext;
+	stor_device = hv_get_drvdata(device);
 
 	if (stor_device && stor_device->destroy)
 		stor_device = NULL;
@@ -328,7 +329,7 @@ static inline struct storvsc_device *get_in_stor_device(
 {
 	struct storvsc_device *stor_device;
 
-	stor_device = (struct storvsc_device *)device->ext;
+	stor_device = hv_get_drvdata(device);
 
 	if (!stor_device)
 		goto get_in_err;
@@ -480,8 +481,7 @@ static void storvsc_on_io_completion(struct hv_device *device,
 	struct storvsc_device *stor_device;
 	struct vstor_packet *stor_pkt;
 
-	stor_device = (struct storvsc_device *)device->ext;
-
+	stor_device = hv_get_drvdata(device);
 	stor_pkt = &request->vstor_packet;
 
 	/*
@@ -630,7 +630,7 @@ static int storvsc_dev_remove(struct hv_device *device)
 	struct storvsc_device *stor_device;
 	unsigned long flags;
 
-	stor_device = (struct storvsc_device *)device->ext;
+	stor_device = hv_get_drvdata(device);
 
 	spin_lock_irqsave(&device->channel->inbound_lock, flags);
 	stor_device->destroy = true;
@@ -652,7 +652,7 @@ static int storvsc_dev_remove(struct hv_device *device)
 	 * allow incoming packets.
 	 */
 	spin_lock_irqsave(&device->channel->inbound_lock, flags);
-	device->ext = NULL;
+	hv_set_drvdata(device, NULL);
 	spin_unlock_irqrestore(&device->channel->inbound_lock, flags);
 
 	/* Close the channel */
@@ -962,7 +962,8 @@ static unsigned int copy_to_bounce_buffer(struct scatterlist *orig_sgl,
 
 static int storvsc_remove(struct hv_device *dev)
 {
-	struct Scsi_Host *host = dev_get_drvdata(&dev->device);
+	struct storvsc_device *stor_device = hv_get_drvdata(dev);
+	struct Scsi_Host *host = stor_device->host;
 	struct hv_host_device *host_dev =
 			(struct hv_host_device *)host->hostdata;
 
@@ -1338,8 +1339,6 @@ static int storvsc_probe(struct hv_device *device,
 	if (!host)
 		return -ENOMEM;
 
-	dev_set_drvdata(&device->device, host);
-
 	host_dev = (struct hv_host_device *)host->hostdata;
 	memset(host_dev, 0, sizeof(struct hv_host_device));
 
@@ -1366,7 +1365,8 @@ static int storvsc_probe(struct hv_device *device,
 	stor_device->destroy = false;
 	init_waitqueue_head(&stor_device->waiting_to_drain);
 	stor_device->device = device;
-	device->ext = stor_device;
+	stor_device->host = host;
+	hv_set_drvdata(device, stor_device);
 
 	stor_device->port_number = host->host_no;
 	ret = storvsc_connect_to_vsp(device, storvsc_ringbuffer_size);
-- 
1.7.4.1
