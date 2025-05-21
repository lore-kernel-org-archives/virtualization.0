Received: from xvfrnhpk.outbound-mail.sendgrid.net (xvfrnhpk.outbound-mail.sendgrid.net [168.245.32.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1C1230269
	for <virtualization@lists.linux.dev>; Wed, 21 May 2025 06:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.245.32.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747809464; cv=none; b=sTpuXwsFHc3Bt2atON8KhD30yzK0N/kuIWKc7rEXpMIfj01Wbll1+WCXngwqHBcVOkR0zK1emZYa5ZDPruj+csNBmvIuG1Na5njnE9JRqKt0jEt1LElJh5tXHY1cn1J7HBh/BvKCh/50gyTn9lA+WP+8rVGCbqWRWvFn8dQWTOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747809464; c=relaxed/simple;
	bh=UO9vsoK70Big7/KvMfY5WCDXE04LNglNvuTtAK1DSOM=;
	h=From:Subject:Date:Message-Id:MIME-Version:To:Cc:Content-Type; b=fI7UepJPydlaDlJFw5PKNpUyAwj2nF6IrkCfRJVR8AjlpVfcAzLkWfIyoLFQu0ceXQNWKyoaIeUWFcVJQeiUeLaTh0DWVlaiYKZ38BIR2Kgero2Ib2a1SyYveXb0MdpGwmIXchmIY/qgSPQkmWX9IErWiZ8XpbvEGn2k/RkpiBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=pass smtp.mailfrom=sendgridstats.nvidia.com; dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b=t8Qko6wD; arc=none smtp.client-ip=168.245.32.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sendgridstats.nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="t8Qko6wD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com;
	h=from:subject:mime-version:to:cc:content-transfer-encoding:
	content-type:cc:content-type:from:subject:to;
	s=s1; bh=NyrBcHEkbWOVETWAAvvJyp3NO785xGw9PjLScVVqAO0=;
	b=t8Qko6wDvzmq3ozTc0ar+MffwYg8mG1Bkw/lXqfcRfxZJnPZepc6Cm53I/EwlGfas/2U
	8yViSfTYZs4rHLAdf3j54TZ745hHhBjQMitrP9MvdhH6enn8pAgkk27DTQxw1UMDKGENaG
	CIEKyGe+O/b+tmD7BNoBct/aoimSFPgcMFcyfjI13SFeJvSCD3dqqPnHn8FcyhTYNKsTlt
	JOXwuC5NrA/ds8F79DQ2RfWXYI/Ga+ohQqLXbT1K6eQPw6W/8PRMlqRfqeHhSS4mC5Phgo
	vVbR23topvhEFiYJIPQW2npYkJ4RFiZQCw0iBqx5CT/KvYp9sw1tanOqhBoMYHfg==
Received: by recvd-5448569fb4-xld5r with SMTP id recvd-5448569fb4-xld5r-1-682D74B5-6
	2025-05-21 06:37:41.153917535 +0000 UTC m=+3659372.687142474
Received: from mtl123.mtl.labs.mlnx (unknown)
	by geopod-ismtpd-3 (SG)
	with ESMTP
	id nnpml6V7RhCaE_lTnVA57A
	Wed, 21 May 2025 06:37:40.921 +0000 (UTC)
Received: from gen-l-vrt-306.mtl.labs.mlnx (gen-l-vrt-306.mtl.labs.mlnx [10.237.7.80])
	by mtl123.mtl.labs.mlnx (8.14.4/8.14.4) with ESMTP id 54L6bedY011940;
	Wed, 21 May 2025 09:37:40 +0300
Received: from gen-l-vrt-306.mtl.labs.mlnx (localhost [127.0.0.1])
	by gen-l-vrt-306.mtl.labs.mlnx (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 54L6SBF81361785;
	Wed, 21 May 2025 09:28:11 +0300
Received: (from root@localhost)
	by gen-l-vrt-306.mtl.labs.mlnx (8.15.2/8.15.2/Submit) id 54L6RmcE1361784;
	Wed, 21 May 2025 09:27:48 +0300
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v1] virtio_blk: Fix disk deletion hang on device surprise
 removal
Date: Wed, 21 May 2025 06:37:41 +0000 (UTC)
Message-Id: <20250521062744.1361774-1-parav@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?u001=2EGKIzaBmeMpQo8dENF3BKzHhooF+oMOnrwKqptdheemMEs2maYobIgHNSi?=
 =?us-ascii?Q?3HpuxQn0J1ksZ0bJ2Es9Y+grYdP1clVLhx=2Ft6Qz?=
 =?us-ascii?Q?r76iOrDcmrnjW+4eXv08Ara0j+lPdBCrOleYQSw?=
 =?us-ascii?Q?7oaFrh22tJn16EHCCE9UewjeCaSv19=2Fhe2j+CPU?=
 =?us-ascii?Q?CzZ7zoCOTdJJlEw2LH7YvVbVfXC9fdTK0E0YPHi?=
 =?us-ascii?Q?8jHAt9hRxrhPgLWpCHhG1nFFpbiQk1mfXYxVF1c?= =?us-ascii?Q?GFAe?=
To: mst@redhat.com, stefanha@redhat.com, axboe@kernel.dk,
	virtualization@lists.linux.dev, linux-block@vger.kernel.or
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
Reported-by: lirongqing@baidu.com
Closes: https://lore.kernel.org/virtualization/c45dd68698cd47238c55fb73ca9b4741@baidu.com/
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v0->v1:
- Fixed comments from Stefan to rename a cleanup function
- Improved logic for handling any outstanding requests
  in bio layer
- improved cancel callback to sync with ongoing done()

---
 drivers/block/virtio_blk.c | 95 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 7cffea01d868..5212afdbd3c7 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -435,6 +435,13 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	blk_status_t status;
 	int err;
 
+	/* Immediately fail all incoming requests if the vq is broken.
+	 * Once the queue is unquiesced, upper block layer flushes any pending
+	 * queued requests; fail them right away.
+	 */
+	if (unlikely(virtqueue_is_broken(vblk->vqs[qid].vq)))
+		return BLK_STS_IOERR;
+
 	status = virtblk_prep_rq(hctx, vblk, req, vbr);
 	if (unlikely(status))
 		return status;
@@ -508,6 +515,11 @@ static void virtio_queue_rqs(struct rq_list *rqlist)
 	while ((req = rq_list_pop(rqlist))) {
 		struct virtio_blk_vq *this_vq = get_virtio_blk_vq(req->mq_hctx);
 
+		if (unlikely(virtqueue_is_broken(this_vq->vq))) {
+			rq_list_add_tail(&requeue_list, req);
+			continue;
+		}
+
 		if (vq && vq != this_vq)
 			virtblk_add_req_batch(vq, &submit_list);
 		vq = this_vq;
@@ -1554,6 +1566,87 @@ static int virtblk_probe(struct virtio_device *vdev)
 	return err;
 }
 
+static bool virtblk_request_cancel(struct request *rq, void *data)
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
+static void virtblk_broken_device_cleanup(struct virtio_blk *vblk)
+{
+	struct request_queue *q = vblk->disk->queue;
+
+	if (!virtqueue_is_broken(vblk->vqs[0].vq))
+		return;
+
+	/* Start freezing the queue, so that new requests keeps waitng at the
+	 * door of bio_queue_enter(). We cannot fully freeze the queue because
+	 * freezed queue is an empty queue and there are pending requests, so
+	 * only start freezing it.
+	 */
+	blk_freeze_queue_start(q);
+
+	/* When quiescing completes, all ongoing dispatches have completed
+	 * and no new dispatch will happen towards the driver.
+	 * This ensures that later when cancel is attempted, then are not
+	 * getting processed by the queue_rq() or queue_rqs() handlers.
+	 */
+	blk_mq_quiesce_queue(q);
+
+	/*
+	 * Synchronize with any ongoing VQ callbacks, effectively quiescing
+	 * the device and preventing it from completing further requests
+	 * to the block layer. Any outstanding, incomplete requests will be
+	 * completed by virtblk_request_cancel().
+	 */
+	virtio_synchronize_cbs(vblk->vdev);
+
+	/* At this point, no new requests can enter the queue_rq() and
+	 * completion routine will not complete any new requests either for the
+	 * broken vq. Hence, it is safe to cancel all requests which are
+	 * started.
+	 */
+	blk_mq_tagset_busy_iter(&vblk->tag_set, virtblk_request_cancel, vblk);
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
+	/* Mark the disk dead so that once queue unfreeze, the requests
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
@@ -1561,6 +1654,8 @@ static void virtblk_remove(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vblk->config_work);
 
+	virtblk_broken_device_cleanup(vblk);
+
 	del_gendisk(vblk->disk);
 	blk_mq_free_tag_set(&vblk->tag_set);
 
-- 
2.34.1

