Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793626666;
	b=zu8HcD9P2gjqC7Xz8DxqI9ybzsstaIV3d80OyuG2jdq129iYtaihYsayqMM7w9xA8wLn
	 DW8/Zy+F9fJwSWuA9FA1t+O6PuXS0GVbwPDwbhUHjQOIzeIYb2ZzOcPIH5hMeXbio8+vm
	 fIVDK3WVpwOIfw15KsrcYHkyJmtbheN7xsaMVXrkFvST8rkb61k3AFmXh6GnjfaAjedJV
	 5cRnzqeqbyGBCRdPdr31pfgixHhLLLzJnzde451ijGISmhHdyoGHNza35DFjOE5quJFRV
	 38iLC0Y0YZcEL2SORyA4uHaxL58kB2qA6Z2vSZ5jIJtKNN9UF+F3rU39x93DgRoF/aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626666;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=H9bvKZVBxfOysBsVNqIEXqXBCIU+hhH5jtMfTN1q6Ek=;
	b=FqxeQRloeoFmiXms8OzX4jr4NKgWuHIRe5UE3WTZYpio7CN4rN91NbXKEahERqZnbOLe
	 pAy6R21fiYPSbHV5hLjsOSQfeBjnY3jiEml8ulrjlDsWz02xjxMAlj4IbVwxx+G7cqOYC
	 kGegIk6OfA7+Zgz+sk5VTlRIM5iqH2GmMiFUxsq9UUsNexngY4P4ycRurIoyGWNZsxbP1
	 6Mm7KVLTXe2GO3FxXEvM2vPHROHerbeb1zhMNbQx8hdVvdUeUcX6wP+GT2cqdmkFRUNBm
	 vje/C668ZjaooKCV2e3pjqlKQQLYzaEJ45qLVHm8uZf0nzH4T8NwxRAoLwUY8mbG6lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Ff3wfV0H;
	arc=none smtp.remote-ip=115.124.30.111
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE10606A324
	for <virtualization@lists.linux.dev>; Mon,  2 Nov 2026 13:37:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AE10606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Ff3wfV0H
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793626661; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=H9bvKZVBxfOysBsVNqIEXqXBCIU+hhH5jtMfTN1q6Ek=;
	b=Ff3wfV0HO+wh1xmK7CMrbWSqMifHozw7mlsh05OFelb2nYa1YmZHIs3UL621JSLDs6UpldRWsb+BNxEBHjAuO4w7DR6gD84kqGKE1zmF/+dfbAMS1CrFGspH1/gB+hZRRhDbiVWO0/GYML5fd3WtPf/SJR5Ky+mzEALvqgEjfg0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=yunye.zhao@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0XE-5Cf7_1793626660;
Received: from j66c13357.sqa.eu95.tbsite.net(mailfrom:yunye.zhao@linux.alibaba.com fp:SMTPD_---0XE-5Cf7_1793626660 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 02 Nov 2026 21:37:41 +0800
From: Yunye Zhao <yunye.zhao@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	virtualization@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Ferry Meng <mengferry@linux.alibaba.com>
Subject: [PATCH] virtio_blk: freeze the virtqueue layout at probe time
Date: Mon,  2 Nov 2026 21:37:40 +0800
Message-Id: <20261102133740.88919-1-yunye.zhao@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

init_vq() reads the writable num_request_queues and poll_queues module
parameters both at probe and when recreating virtqueues after suspend
or reset. However, virtio-blk does not update the blk-mq hardware queue
count or queue maps on restore.

Increasing poll_queues can therefore remove the completion callback
from a virtqueue still used for interrupt-driven I/O, leaving requests
uncompleted. Reducing the effective request queue count through
num_request_queues can instead leave existing hardware contexts
indexing beyond the reallocated vblk->vqs array.

Determine the virtqueue count and the split between interrupt-driven
and polling queues once at probe, and reuse this layout when
recreating the virtqueues. Changes to these module parameters then
affect only subsequently probed devices.

Fixes: 0989c41bed96 ("virtio-blk: add num_request_queues module parameter")
Signed-off-by: Yunye Zhao <yunye.zhao@linux.alibaba.com>
---
The functional fix was previously tested with QEMU 8.2.2 on
7be4bc52fd9e (v7.3-2415), covering:

- PCI FLR after changing poll_queues from 0 to 1 or num_request_queues
  from 0 to 1 on a device with four request queues.
- Normal and polled I/O across FLR with poll_queues=1 at probe,
  including a subsequent change of poll_queues to 0.
- Device suspend/resume with pm_test=devices and state=freeze (not a
  full s2idle cycle), plus full S3 and S4 suspend/resume cycles.

 drivers/block/virtio_blk.c | 71 +++++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 28 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index c8bfbf8435ac..0df89f381047 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -958,42 +958,54 @@ static void virtblk_config_changed(struct virtio_device *vdev)
 	queue_work(virtblk_wq, &vblk->config_work);
 }
 
+/* Keep the queue layout unchanged for the lifetime of the tag set. */
+static int virtblk_init_queue_layout(struct virtio_blk *vblk)
+{
+	struct virtio_device *vdev = vblk->vdev;
+	unsigned short num_vqs;
+	unsigned short num_poll_vqs;
+	int err;
+
+	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
+				   struct virtio_blk_config, num_queues,
+				   &num_vqs);
+	if (err)
+		num_vqs = 1;
+
+	if (!err && !num_vqs) {
+		dev_err(&vdev->dev, "MQ advertised but zero queues reported\n");
+		return -EINVAL;
+	}
+
+	num_vqs = blk_mq_num_possible_queues(
+			min_not_zero(num_request_queues, num_vqs));
+
+	num_poll_vqs = min_t(unsigned int, poll_queues, num_vqs - 1);
+
+	vblk->num_vqs = num_vqs;
+	vblk->io_queues[HCTX_TYPE_DEFAULT] = num_vqs - num_poll_vqs;
+	vblk->io_queues[HCTX_TYPE_READ] = 0;
+	vblk->io_queues[HCTX_TYPE_POLL] = num_poll_vqs;
+
+	dev_info(&vdev->dev, "%d/%d/%d default/read/poll queues\n",
+				vblk->io_queues[HCTX_TYPE_DEFAULT],
+				vblk->io_queues[HCTX_TYPE_READ],
+				vblk->io_queues[HCTX_TYPE_POLL]);
+
+	return 0;
+}
+
 static int init_vq(struct virtio_blk *vblk)
 {
 	int err;
 	unsigned short i;
 	struct virtqueue_info *vqs_info;
 	struct virtqueue **vqs;
-	unsigned short num_vqs;
-	unsigned short num_poll_vqs;
+	unsigned short num_vqs = vblk->num_vqs;
+	unsigned short num_poll_vqs = vblk->io_queues[HCTX_TYPE_POLL];
 	struct virtio_device *vdev = vblk->vdev;
 	struct irq_affinity desc = { 0, };
 
-	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
-				   struct virtio_blk_config, num_queues,
-				   &num_vqs);
-	if (err)
-		num_vqs = 1;
-
-	if (!err && !num_vqs) {
-		dev_err(&vdev->dev, "MQ advertised but zero queues reported\n");
-		return -EINVAL;
-	}
-
-	num_vqs = blk_mq_num_possible_queues(
-			min_not_zero(num_request_queues, num_vqs));
-
-	num_poll_vqs = min_t(unsigned int, poll_queues, num_vqs - 1);
-
-	vblk->io_queues[HCTX_TYPE_DEFAULT] = num_vqs - num_poll_vqs;
-	vblk->io_queues[HCTX_TYPE_READ] = 0;
-	vblk->io_queues[HCTX_TYPE_POLL] = num_poll_vqs;
-
-	dev_info(&vdev->dev, "%d/%d/%d default/read/poll queues\n",
-				vblk->io_queues[HCTX_TYPE_DEFAULT],
-				vblk->io_queues[HCTX_TYPE_READ],
-				vblk->io_queues[HCTX_TYPE_POLL]);
-
 	vblk->vqs = kmalloc_objs(*vblk->vqs, num_vqs);
 	if (!vblk->vqs)
 		return -ENOMEM;
@@ -1025,7 +1037,6 @@ static int init_vq(struct virtio_blk *vblk)
 		spin_lock_init(&vblk->vqs[i].lock);
 		vblk->vqs[i].vq = vqs[i];
 	}
-	vblk->num_vqs = num_vqs;
 
 out:
 	kfree(vqs);
@@ -1470,6 +1481,10 @@ static int virtblk_probe(struct virtio_device *vdev)
 
 	INIT_WORK(&vblk->config_work, virtblk_config_changed_work);
 
+	err = virtblk_init_queue_layout(vblk);
+	if (err)
+		goto out_free_vblk;
+
 	err = init_vq(vblk);
 	if (err)
 		goto out_free_vblk;

base-commit: 7be4bc52fd9e0e55dc9a2e0232b89427d2c4b614
-- 
2.19.1.6.gb485710b
