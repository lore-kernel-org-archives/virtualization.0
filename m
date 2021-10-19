Return-Path: <SRS0=CXPs=PH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C039C433F5
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 07:47:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E800B61027
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 07:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E800B61027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1FB28308B;
	Tue, 19 Oct 2021 07:47:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1wkrlXvgfHLG; Tue, 19 Oct 2021 07:47:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4007581D47;
	Tue, 19 Oct 2021 07:47:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D05AC000F;
	Tue, 19 Oct 2021 07:47:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FC17C0026
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 07:47:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DAFAA60AFA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 07:47:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=axis.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fD1Q20PQtdqA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 07:47:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D542760B16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 07:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; q=dns/txt; s=axis-central1; t=1634629645;
 x=1666165645; h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ojV3071KZMIn0lt4+At3XuTc62g2zZKG5RW/jTDctIQ=;
 b=a4nQPczr2qpXFJZvRNxRrYPTuaN/xy5njlYAFwmWz5FENgxtYzhaNEGW
 V1PwfsYl6Uifb7+WXM4m/PHhrMjgiTKeLWOf/hw6gf7jPMn/FlQEtRtKX
 Z0jQPkoLcrYWL2VUr4r/Q+wYfeLswq0JDbPBA06NKjDIvBUKfMCzRmkun
 awec29MOesf/PbzhGmPsvVIqCIn3fmu8AKqGQySCdLbMFIhvfNUgGt17U
 GbVcOu/Eabuzq3baqSXiK8dNAGfCuTwaoehmMMS7kbKkR2LN6aJNlNmoX
 I+Iu5+jMmNSKF/M/TuUszrC3N4/I9ZiqYOhqNV2HKsWx9v3fZcRD2hNqS A==;
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
To: <wsa@kernel.org>, <jie.deng@intel.com>, <viresh.kumar@linaro.org>
Subject: [PATCH 1/2] i2c: virtio: disable timeout handling
Date: Tue, 19 Oct 2021 09:46:46 +0200
Message-ID: <20211019074647.19061-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20211019074647.19061-1-vincent.whitchurch@axis.com>
References: <20211019074647.19061-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org,
 Vincent Whitchurch <vincent.whitchurch@axis.com>, kernel@axis.com,
 linux-i2c@vger.kernel.org, virtualization@lists.linux-foundation.org
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

If a timeout is hit, it can result is incorrect data on the I2C bus
and/or memory corruptions in the guest since the device can still be
operating on the buffers it was given while the guest has freed them.

Here is, for example, the start of a slub_debug splat which was
triggered on the next transfer after one transfer was forced to timeout
by setting a breakpoint in the backend (rust-vmm/vhost-device):

 BUG kmalloc-1k (Not tainted): Poison overwritten
 First byte 0x1 instead of 0x6b
 Allocated in virtio_i2c_xfer+0x65/0x35c age=350 cpu=0 pid=29
 	__kmalloc+0xc2/0x1c9
 	virtio_i2c_xfer+0x65/0x35c
 	__i2c_transfer+0x429/0x57d
 	i2c_transfer+0x115/0x134
 	i2cdev_ioctl_rdwr+0x16a/0x1de
 	i2cdev_ioctl+0x247/0x2ed
 	vfs_ioctl+0x21/0x30
 	sys_ioctl+0xb18/0xb41
 Freed in virtio_i2c_xfer+0x32e/0x35c age=244 cpu=0 pid=29
 	kfree+0x1bd/0x1cc
 	virtio_i2c_xfer+0x32e/0x35c
 	__i2c_transfer+0x429/0x57d
 	i2c_transfer+0x115/0x134
 	i2cdev_ioctl_rdwr+0x16a/0x1de
 	i2cdev_ioctl+0x247/0x2ed
 	vfs_ioctl+0x21/0x30
 	sys_ioctl+0xb18/0xb41

There is no simple fix for this (the driver would have to always create
bounce buffers and hold on to them until the device eventually returns
the buffers), so just disable the timeout support for now.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/i2c/busses/i2c-virtio.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
index f10a603b13fb..7b2474e6876f 100644
--- a/drivers/i2c/busses/i2c-virtio.c
+++ b/drivers/i2c/busses/i2c-virtio.c
@@ -106,11 +106,10 @@ static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
 
 static int virtio_i2c_complete_reqs(struct virtqueue *vq,
 				    struct virtio_i2c_req *reqs,
-				    struct i2c_msg *msgs, int num,
-				    bool timedout)
+				    struct i2c_msg *msgs, int num)
 {
 	struct virtio_i2c_req *req;
-	bool failed = timedout;
+	bool failed = false;
 	unsigned int len;
 	int i, j = 0;
 
@@ -132,7 +131,7 @@ static int virtio_i2c_complete_reqs(struct virtqueue *vq,
 			j++;
 	}
 
-	return timedout ? -ETIMEDOUT : j;
+	return j;
 }
 
 static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
@@ -141,7 +140,6 @@ static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	struct virtio_i2c *vi = i2c_get_adapdata(adap);
 	struct virtqueue *vq = vi->vq;
 	struct virtio_i2c_req *reqs;
-	unsigned long time_left;
 	int count;
 
 	reqs = kcalloc(num, sizeof(*reqs), GFP_KERNEL);
@@ -164,11 +162,9 @@ static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	reinit_completion(&vi->completion);
 	virtqueue_kick(vq);
 
-	time_left = wait_for_completion_timeout(&vi->completion, adap->timeout);
-	if (!time_left)
-		dev_err(&adap->dev, "virtio i2c backend timeout.\n");
+	wait_for_completion(&vi->completion);
 
-	count = virtio_i2c_complete_reqs(vq, reqs, msgs, count, !time_left);
+	count = virtio_i2c_complete_reqs(vq, reqs, msgs, count);
 
 err_free:
 	kfree(reqs);
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
