Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3289DC433EF
	for <virtualization@archiver.kernel.org>; Thu,  2 Dec 2021 15:32:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1BA741DBE;
	Thu,  2 Dec 2021 15:32:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tAlu_V8wQEee; Thu,  2 Dec 2021 15:32:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2A42941DBD;
	Thu,  2 Dec 2021 15:32:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06F7CC001C;
	Thu,  2 Dec 2021 15:32:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7191EC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 15:32:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5998C6F48D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 15:32:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=axis.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z8NccRjHBg4F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 15:32:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DA865606CF
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Dec 2021 15:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; q=dns/txt; s=axis-central1; t=1638459150;
 x=1669995150;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=QW6971HeXyxZD+Obc/BuWEJRNHl9yOf9lvXC3G7vFAg=;
 b=n/Zr8wga9EYAmtyCV7roU+38Wdzj1tSwHP0CMEPWrank/6uUvclbIx3n
 UStsedP/BxF87OL1eYnfECKfhRZdzAIEJeGxSp8uR8SLadq+YCMhDBsum
 Y4fcFTuZ2uHVC+7Ewm5kPL6lGKJ7S/h41hqOqmK10OB03bBpInY8kE2+3
 TJIW+SFrrfUgtd6BQenwdec4Z1LumFJ2DqQYm73YuIzf4NznQxU0m0bla
 VPijdxRVEJNL0O5/8u5p/ZdpR0++Oyi3yNy2RpttgihitlH7yY5aKz8Qy
 S5oLgBQUsHHiMU7yEbgKCV/sdJVIMtpUeUrH13xgFfEo2lpohrDl1u7/G w==;
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
To: <wsa@kernel.org>, Conghui Chen <conghui.chen@intel.com>, Viresh Kumar
 <viresh.kumar@linaro.org>
Subject: [PATCH v3] i2c: virtio: fix completion handling
Date: Thu, 2 Dec 2021 16:32:14 +0100
Message-ID: <20211202153215.31796-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kernel@axis.com,
 linux-i2c@vger.kernel.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

The driver currently assumes that the notify callback is only received
when the device is done with all the queued buffers.

However, this is not true, since the notify callback could be called
without any of the queued buffers being completed (for example, with
virtio-pci and shared interrupts) or with only some of the buffers being
completed (since the driver makes them available to the device in
multiple separate virtqueue_add_sgs() calls).

This can lead to incorrect data on the I2C bus or memory corruption in
the guest if the device operates on buffers which are have been freed by
the driver.  (The WARN_ON in the driver is also triggered.)

 BUG kmalloc-128 (Tainted: G        W        ): Poison overwritten
 First byte 0x0 instead of 0x6b
 Allocated in i2cdev_ioctl_rdwr+0x9d/0x1de age=243 cpu=0 pid=28
 	memdup_user+0x2e/0xbd
 	i2cdev_ioctl_rdwr+0x9d/0x1de
 	i2cdev_ioctl+0x247/0x2ed
 	vfs_ioctl+0x21/0x30
 	sys_ioctl+0xb18/0xb41
 Freed in i2cdev_ioctl_rdwr+0x1bb/0x1de age=68 cpu=0 pid=28
 	kfree+0x1bd/0x1cc
 	i2cdev_ioctl_rdwr+0x1bb/0x1de
 	i2cdev_ioctl+0x247/0x2ed
 	vfs_ioctl+0x21/0x30
 	sys_ioctl+0xb18/0xb41

Fix this by calling virtio_get_buf() from the notify handler like other
virtio drivers and by actually waiting for all the buffers to be
completed.

Fixes: 3cfc88380413d20f ("i2c: virtio: add a virtio i2c frontend driver")
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---

Notes:
    v3: Wait for all completions instead of only the last one.
    v2: Add Acked-by and Fixes tags.

 drivers/i2c/busses/i2c-virtio.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
index 95378780da6d..41eb0dcc3204 100644
--- a/drivers/i2c/busses/i2c-virtio.c
+++ b/drivers/i2c/busses/i2c-virtio.c
@@ -22,24 +22,24 @@
 /**
  * struct virtio_i2c - virtio I2C data
  * @vdev: virtio device for this controller
- * @completion: completion of virtio I2C message
  * @adap: I2C adapter for this controller
  * @vq: the virtio virtqueue for communication
  */
 struct virtio_i2c {
 	struct virtio_device *vdev;
-	struct completion completion;
 	struct i2c_adapter adap;
 	struct virtqueue *vq;
 };
 
 /**
  * struct virtio_i2c_req - the virtio I2C request structure
+ * @completion: completion of virtio I2C message
  * @out_hdr: the OUT header of the virtio I2C message
  * @buf: the buffer into which data is read, or from which it's written
  * @in_hdr: the IN header of the virtio I2C message
  */
 struct virtio_i2c_req {
+	struct completion completion;
 	struct virtio_i2c_out_hdr out_hdr	____cacheline_aligned;
 	uint8_t *buf				____cacheline_aligned;
 	struct virtio_i2c_in_hdr in_hdr		____cacheline_aligned;
@@ -47,9 +47,11 @@ struct virtio_i2c_req {
 
 static void virtio_i2c_msg_done(struct virtqueue *vq)
 {
-	struct virtio_i2c *vi = vq->vdev->priv;
+	struct virtio_i2c_req *req;
+	unsigned int len;
 
-	complete(&vi->completion);
+	while ((req = virtqueue_get_buf(vq, &len)))
+		complete(&req->completion);
 }
 
 static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
@@ -62,6 +64,8 @@ static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
 	for (i = 0; i < num; i++) {
 		int outcnt = 0, incnt = 0;
 
+		init_completion(&reqs[i].completion);
+
 		/*
 		 * Only 7-bit mode supported for this moment. For the address
 		 * format, Please check the Virtio I2C Specification.
@@ -106,21 +110,15 @@ static int virtio_i2c_complete_reqs(struct virtqueue *vq,
 				    struct virtio_i2c_req *reqs,
 				    struct i2c_msg *msgs, int num)
 {
-	struct virtio_i2c_req *req;
 	bool failed = false;
-	unsigned int len;
 	int i, j = 0;
 
 	for (i = 0; i < num; i++) {
-		/* Detach the ith request from the vq */
-		req = virtqueue_get_buf(vq, &len);
+		struct virtio_i2c_req *req = &reqs[i];
 
-		/*
-		 * Condition req == &reqs[i] should always meet since we have
-		 * total num requests in the vq. reqs[i] can never be NULL here.
-		 */
-		if (!failed && (WARN_ON(req != &reqs[i]) ||
-				req->in_hdr.status != VIRTIO_I2C_MSG_OK))
+		wait_for_completion(&req->completion);
+
+		if (!failed && req->in_hdr.status != VIRTIO_I2C_MSG_OK)
 			failed = true;
 
 		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
@@ -156,12 +154,8 @@ static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	 * remote here to clear the virtqueue, so we can try another set of
 	 * messages later on.
 	 */
-
-	reinit_completion(&vi->completion);
 	virtqueue_kick(vq);
 
-	wait_for_completion(&vi->completion);
-
 	count = virtio_i2c_complete_reqs(vq, reqs, msgs, count);
 
 err_free:
@@ -210,8 +204,6 @@ static int virtio_i2c_probe(struct virtio_device *vdev)
 	vdev->priv = vi;
 	vi->vdev = vdev;
 
-	init_completion(&vi->completion);
-
 	ret = virtio_i2c_setup_vqs(vi);
 	if (ret)
 		return ret;
-- 
2.33.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
