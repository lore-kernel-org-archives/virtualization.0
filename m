Return-Path: <SRS0=fJjx=P6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0008C433FE
	for <virtualization@archiver.kernel.org>; Thu, 11 Nov 2021 16:04:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD32160EE4
	for <virtualization@archiver.kernel.org>; Thu, 11 Nov 2021 16:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AD32160EE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7195C4018E;
	Thu, 11 Nov 2021 16:04:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IWf4a82uhQPH; Thu, 11 Nov 2021 16:04:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BA30C403E7;
	Thu, 11 Nov 2021 16:04:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E767C0020;
	Thu, 11 Nov 2021 16:04:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2252AC001E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 16:04:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 11841404DA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 16:04:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=axis.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zCf8qA7nejTf
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 16:04:21 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4873040507
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 16:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; q=dns/txt; s=axis-central1; t=1636646662;
 x=1668182662; h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0i1LfHXs6uH2x7I8DD0PdVPydkm4E1YEPDn4tVDfrSs=;
 b=k6DhS5KJn2PGIT2U1t9C3W2MJXFN7bndycpRIA6eaJEUrQaH5b9x9xyH
 lwQiD76SGuBrojgbJMFlWtGRhCiBzEo+drACUwDrkqtk7dh+gD0eQqaTh
 UW5cl7SeBovtVeN+WXuZwk61ZfciND8PcYSgRAsJXpleCaNme9UhLQeUZ
 bptIq2Y41Rz+b7XytjYfRlktFNMgwlaOZe7MwoKYrhk+z/S/OUBU1bPW+
 gk6G58M+zuu1P5ysmb3TdpcuP3HDOPXI90/i7J0ArH8hC9zJEryoPq+MR
 GL787NmJ0JruBwPakaY1WW8I8GjthE7k8u8Kx4qyvaV9e6z7k/G9+OBxc g==;
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
To: <wsa@kernel.org>, <jie.deng@intel.com>, <viresh.kumar@linaro.org>
Subject: [PATCH v2 1/2] i2c: virtio: disable timeout handling
Date: Thu, 11 Nov 2021 17:04:11 +0100
Message-ID: <20211111160412.11980-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20211111160412.11980-1-vincent.whitchurch@axis.com>
References: <20211111160412.11980-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Cc: mst@redhat.com, Vincent Whitchurch <vincent.whitchurch@axis.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 kernel@axis.com, linux-i2c@vger.kernel.org, conghui.chen@intel.com
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

Fixes: 3cfc88380413d20f ("i2c: virtio: add a virtio i2c frontend driver")
Acked-by: Jie Deng <jie.deng@intel.com>
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
