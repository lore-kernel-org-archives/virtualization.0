Received: from xvfrnhpk.outbound-mail.sendgrid.net (xvfrnhpk.outbound-mail.sendgrid.net [168.245.32.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0502E2907
	for <virtualization@lists.linux.dev>; Sat, 31 May 2025 05:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.245.32.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748669634; cv=none; b=b/DBqB5gTN57lHCgFz0mdNqeNWnArKl6I1oDDFd9PbHYlEptKiK4/LFzY9XBAGEXZ0VD4HV/mK+O0PTwaRCzjRlbcml0WP+0Nk/rcJEKJVrYU3fMDpJmhzdKQqc17U75EzYOMwVENfmKo0yWf/F9rscEDG4+IOrDMsLVfvjX4qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748669634; c=relaxed/simple;
	bh=zNIti7lQFIfJxreJ5C2STZvRXmP50OubWVgKmOlPglE=;
	h=From:Subject:Date:Message-Id:MIME-Version:To:Cc:Content-Type; b=gc6RTJzT6UdyrikWwq/XMYPvQg6VqFV5o+peB9Sx4HbeEmoZG8Nve67JbuFunGkESctjTWyvISXPIEcgTBu9s7iecNfveaVUzo/yp9RJZrTCYPJFaTNYbZQPkk5+cmia3muNoGWWjwQejMwBsNSC/mTP5PSLmRTf05vfjC0B9sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=pass smtp.mailfrom=sendgridstats.nvidia.com; dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b=fUIAfUJw; arc=none smtp.client-ip=168.245.32.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sendgridstats.nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fUIAfUJw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com;
	h=from:subject:mime-version:to:cc:content-transfer-encoding:
	content-type:cc:content-type:from:subject:to;
	s=s1; bh=vHxTLQaShFKwHNY3p3tOym3ppNGDbxyo095EuUyt7HQ=;
	b=fUIAfUJw+3xopoOBzckhh325qB4hJuqCDy23jjSVeYHcn6vXXKtVErm90Lv7nuVEIkhd
	P85KYnmTZ85JxxdNkXXe7smLJKb0xah0R1D0ganJhoxTHrMHq0N6qnTFu9h4u/YzD9d8Wk
	Qd6zRwCcVbzYSjDfinETwgBZyrihRK+xVcvYQJ1vtxF+efNVohsWbda+5JjTz+g2sJ5LA/
	kom6qUOMUVsDZpS1UXVMF681txbqv0NlN1jXuo28zvgRp0z2DnvWvwloTWohNZ0k7OW7Np
	tL2KyAqIEg41DKIMKdN7mA2ZqgIM+Hmlf1qarwR/9D3ewLRNQavjwFHUf6LMBzFQ==
Received: by recvd-7d864bbfdf-tqzqf with SMTP id recvd-7d864bbfdf-tqzqf-1-683A94BF-16
	2025-05-31 05:33:51.544610581 +0000 UTC m=+124029.905130274
Received: from mtl123.mtl.labs.mlnx (unknown)
	by geopod-ismtpd-13 (SG)
	with ESMTP
	id 8ZFmJ1jnRmuCSM8WiADyGg
	Sat, 31 May 2025 05:33:51.370 +0000 (UTC)
Received: from gen-l-vrt-306.mtl.labs.mlnx (gen-l-vrt-306.mtl.labs.mlnx [10.237.7.80])
	by mtl123.mtl.labs.mlnx (8.14.4/8.14.4) with ESMTP id 54V5XoKh001658;
	Sat, 31 May 2025 08:33:50 +0300
Received: from gen-l-vrt-306.mtl.labs.mlnx (localhost [127.0.0.1])
	by gen-l-vrt-306.mtl.labs.mlnx (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 54V5XoAr039524;
	Sat, 31 May 2025 08:33:50 +0300
Received: (from root@localhost)
	by gen-l-vrt-306.mtl.labs.mlnx (8.15.2/8.15.2/Submit) id 54V5XPhM039523;
	Sat, 31 May 2025 08:33:25 +0300
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v4] virtio_blk: Fix disk deletion hang on device surprise
 removal
Date: Sat, 31 May 2025 05:33:51 +0000 (UTC)
Message-Id: <20250531053324.39513-1-parav@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?u001=2EGKIzaBmeMpQo8dENF3BKzHhooF+oMOnrwKqptdheemMEs2maYobIgHNSi?=
 =?us-ascii?Q?3HpuxQn0J1ksZ0bJ2Es9Y+grYdP1exb9+tPPZrz?=
 =?us-ascii?Q?9B7eiE5hg7dMQGlHV3B2DEV8Xvs59teK+3CTg5C?=
 =?us-ascii?Q?mzs0u9UDrGuE3FUM4UHiLFz+8gXc8ABJ0EvcSnO?=
 =?us-ascii?Q?C=2FU6QxflUtrIbK4Su=2FpYju+uCE3IS8Z0Is6do42?=
 =?us-ascii?Q?vqa2=2Fx8KYg2DTU+ehy+Ru5KpA2ydlHeZQr+Lrhx?= =?us-ascii?Q?Jn9e?=
To: mst@redhat.com, stefanha@redhat.com, axboe@kernel.dk,
	virtualization@lists.linux.dev, linux-block@vger.kernel.org
Cc: stable@vger.kernel.org, lirongqing@baidu.com, kch@nvidia.com,
	xuanzhuo@linux.alibaba.com, pbonzini@redhat.com, jasowang@redhat.com,
	Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>
X-Entity-ID: u001.9Nu+sJkq3f0LJ/tZbyfOWA==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii

When the PCI device is surprise removed, requests may not complete
the device as the VQ is marked as broken. Due to this, the disk
deletion hangs.

Fix it by aborting the requests when the VQ is broken.

With this fix now fio completes swiftly.
An alternative of IO timeout has been considered, however
when the driver knows about unresponsive block device, swiftly clearing
them enables users and upper layers to react quickly.

Verified with multiple device unplug iterations with pending requests in
virtio used ring and some pending with the device.

Fixes: 43bb40c5b926 ("virtio_pci: Support surprise removal of virtio pci device")
Cc: stable@vger.kernel.org
Reported-by: Li RongQing <lirongqing@baidu.com>
Closes: https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b4741@baidu.com/
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
v3->v4:
- Addressed comments from Michael
- renamed virtblk_request_cancel() to
  virtblk_complete_request_with_ioerr()
- Added comments for virtblk_complete_request_with_ioerr()
- Renamed virtblk_broken_device_cleanup() to
  virtblk_cleanup_broken_device()
- Added comments for virtblk_cleanup_broken_device()
- Moved the broken vq check in virtblk_remove()
- Fixed comment style to have first empty line
- replaced freezed to frozen
- Fixed comments rephrased

v2->v3:
- Addressed comments from Michael
- updated comment for synchronizing with callbacks

v1->v2:
- Addressed comments from Stephan
- fixed spelling to 'waiting'
- Addressed comments from Michael
- Dropped checking broken vq from queue_rq() and queue_rqs()
  because it is checked in lower layer routines in virtio core

v0->v1:
- Fixed comments from Stefan to rename a cleanup function
- Improved logic for handling any outstanding requests
  in bio layer
- improved cancel callback to sync with ongoing done()
---
 drivers/block/virtio_blk.c | 90 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 7cffea01d868..5383d0a3ebbd 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1554,6 +1554,93 @@ static int virtblk_probe(struct virtio_device *vdev)
 	return err;
 }
 
+/*
+ * If the vq is broken, device will not complete requests.
+ * So we do it for the device.
+ */
+static bool virtblk_complete_request_with_ioerr(struct request *rq, void *data)
+{
+	struct virtblk_req *vbr = blk_mq_rq_to_pdu(rq);
+	struct virtio_blk *vblk = data;
+	struct virtio_blk_vq *vq;
+	unsigned long flags;
+
+	vq = &vblk->vqs[rq->mq_hctx->queue_num];
+
+	spin_lock_irqsave(&vq->lock, flags);
+
+	vbr->in_hdr.status = VIRTIO_BLK_S_IOERR;
+	if (blk_mq_request_started(rq) && !blk_mq_request_completed(rq))
+		blk_mq_complete_request(rq);
+
+	spin_unlock_irqrestore(&vq->lock, flags);
+	return true;
+}
+
+/*
+ * If the device is broken, it will not use any buffers and waiting
+ * for that to happen is pointless. We'll do the cleanup in the driver,
+ * completing all requests for the device.
+ */
+static void virtblk_cleanup_broken_device(struct virtio_blk *vblk)
+{
+	struct request_queue *q = vblk->disk->queue;
+
+	/*
+	 * Start freezing the queue, so that new requests keeps waiting at the
+	 * door of bio_queue_enter(). We cannot fully freeze the queue because
+	 * frozen queue is an empty queue and there are pending requests, so
+	 * only start freezing it.
+	 */
+	blk_freeze_queue_start(q);
+
+	/*
+	 * When quiescing completes, all ongoing dispatches have completed
+	 * and no new dispatch will happen towards the driver.
+	 */
+	blk_mq_quiesce_queue(q);
+
+	/*
+	 * Synchronize with any ongoing VQ callbacks that may have started
+	 * before the VQs were marked as broken. Any outstanding requests
+	 * will be completed by virtblk_complete_request_with_ioerr().
+	 */
+	virtio_synchronize_cbs(vblk->vdev);
+
+	/* At this point, no new requests can enter the queue_rq() and
+	 * completion routine will not complete any new requests either for the
+	 * broken vq. Hence, it is safe to cancel all requests which are
+	 * started.
+	 */
+	blk_mq_tagset_busy_iter(&vblk->tag_set,
+				virtblk_complete_request_with_ioerr, vblk);
+	blk_mq_tagset_wait_completed_request(&vblk->tag_set);
+
+	/* All pending requests are cleaned up. Time to resume so that disk
+	 * deletion can be smooth. Start the HW queues so that when queue is
+	 * unquiesced requests can again enter the driver.
+	 */
+	blk_mq_start_stopped_hw_queues(q, true);
+
+	/* Unquiescing will trigger dispatching any pending requests to the
+	 * driver which has crossed bio_queue_enter() to the driver.
+	 */
+	blk_mq_unquiesce_queue(q);
+
+	/* Wait for all pending dispatches to terminate which may have been
+	 * initiated after unquiescing.
+	 */
+	blk_mq_freeze_queue_wait(q);
+
+	/* Mark the disk dead so that once we unfreeze the queue, requests
+	 * waiting at the door of bio_queue_enter() can be aborted right away.
+	 */
+	blk_mark_disk_dead(vblk->disk);
+
+	/* Unfreeze the queue so that any waiting requests will be aborted. */
+	blk_mq_unfreeze_queue_nomemrestore(q);
+}
+
 static void virtblk_remove(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk = vdev->priv;
@@ -1561,6 +1648,9 @@ static void virtblk_remove(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vblk->config_work);
 
+	if (!virtqueue_is_broken(vblk->vqs[0].vq))
+		virtblk_cleanup_broken_device(vblk);
+
 	del_gendisk(vblk->disk);
 	blk_mq_free_tag_set(&vblk->tag_set);
 
-- 
2.34.1

