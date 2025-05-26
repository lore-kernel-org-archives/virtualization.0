Received: from xvfrnhpk.outbound-mail.sendgrid.net (xvfrnhpk.outbound-mail.sendgrid.net [168.245.32.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F66E8F5E
	for <virtualization@lists.linux.dev>; Mon, 26 May 2025 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.245.32.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748270436; cv=none; b=rGZg7/6N4KHXI9vv1W1A4AxbXdUM4mz8CEiT6IMZeT3dEE9/5Sss0AVq5tqm/ziu5wX11e0bkERbPHjcDe1xyZ4TOdXDrCSphKBpUMie3mDFgavkEXg6+3qJK40vtCOEORh36rgxeiaoJuvajZ0C0z0+kRtPe+6gv4iK1zywwKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748270436; c=relaxed/simple;
	bh=d1PQxs10lfmqJnGYJS95aWDX8GIwfpFbiVXasZo1Mdo=;
	h=From:Subject:Date:Message-Id:MIME-Version:To:Cc:Content-Type; b=GDEv5+NAZEuTha6Rpg/ChM8c7ZP20gSPeXnk+FE0bneCMb1w1UtX4kAUdQm//w7ChWa6qwptfQ8FpVlyCLvHG0yA7X8jYyZuXRPMD8BAOsDkvrFviFg64txjU5kKxS9GIvUPKBJ3fVR8AVyqkBPxr2dl78VfyZOblbc92eTuWT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=pass smtp.mailfrom=sendgridstats.nvidia.com; dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b=SdX+A1Sg; arc=none smtp.client-ip=168.245.32.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sendgridstats.nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SdX+A1Sg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com;
	h=from:subject:mime-version:to:cc:content-transfer-encoding:
	content-type:cc:content-type:from:subject:to;
	s=s1; bh=r8qrSsIQoSyWBb80Ej3JuxeIF4SIQooUkXB7mTluPk8=;
	b=SdX+A1Sg67Qn3VtAmP2urBG5VDKs6ugDShlhqXPgQme7IHmRu2Eob0VBcwqh9LjKtb9d
	4OOcDcdUyqE04r50RltexOP6fqy7snUOrXPYVeCCR5d4NgffzCmV8oVtYMCyKYu5+4KLiV
	UthIdcyHvW1DtsP+x1TGNOH2jhQ0xeX09X99UUiQH/Wl1er6auHiBYv74CEWZCOU7XcKCV
	HJr3fqzqXTAJyKyfjIQ6Hd/vm48oh8WF9dH9O7emxOMf9QEcOcibPr0lnKHQ19kzdCOMah
	iRCnT+BsrDc4HHmY8lNC+FX/a4/SVGYVeYbOZ9KtpG0OTPe0iSZ/1iwJ54yoCB4A==
Received: by recvd-7dbb94f885-lz6hq with SMTP id recvd-7dbb94f885-lz6hq-1-68347D60-38
	2025-05-26 14:40:32.854673969 +0000 UTC m=+4052039.235472752
Received: from mtl123.mtl.labs.mlnx (unknown)
	by geopod-ismtpd-8 (SG)
	with ESMTP
	id X1cc6yNcRW2lorK4LsFVBg
	Mon, 26 May 2025 14:40:32.663 +0000 (UTC)
Received: from gen-l-vrt-306.mtl.labs.mlnx (gen-l-vrt-306.mtl.labs.mlnx [10.237.7.80])
	by mtl123.mtl.labs.mlnx (8.14.4/8.14.4) with ESMTP id 54QEeWCH032459;
	Mon, 26 May 2025 17:40:32 +0300
Received: from gen-l-vrt-306.mtl.labs.mlnx (localhost [127.0.0.1])
	by gen-l-vrt-306.mtl.labs.mlnx (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 54QEeV0n124581;
	Mon, 26 May 2025 17:40:31 +0300
Received: (from root@localhost)
	by gen-l-vrt-306.mtl.labs.mlnx (8.15.2/8.15.2/Submit) id 54QEe8FE124580;
	Mon, 26 May 2025 17:40:08 +0300
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v2] virtio_blk: Fix disk deletion hang on device surprise
 removal
Date: Mon, 26 May 2025 14:40:33 +0000 (UTC)
Message-Id: <20250526144007.124570-1-parav@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?u001=2EGKIzaBmeMpQo8dENF3BKzHhooF+oMOnrwKqptdheemMEs2maYobIgHNSi?=
 =?us-ascii?Q?3HpuxQn0J1ksZ0bJ2Es9Y+grYdP1USALh4RuT0z?=
 =?us-ascii?Q?wYzioSPvv9w6YjhFerFgDDd1sSm+rehxtoA=2F2pf?=
 =?us-ascii?Q?jq2NPF=2F+AHAFoh1ejB44e+cOTdkiftfUUpJ4cyB?=
 =?us-ascii?Q?2RaP+WhxYs30iNIIOghGn+nmIyB9ho7EusoeKld?=
 =?us-ascii?Q?jaWddl+pZ+JuR0lYr6kiLXzLsxmJIpACkyCX3XO?= =?us-ascii?Q?LZNs?=
To: mst@redhat.com, stefanha@redhat.com, axboe@kernel.dk,
	virtualization@lists.linux.dev, linux-block@vger.kernel.org
Cc: stable@vger.kernel.org, lirongqing@baidu.com, kch@nvidia.com,
	xuanzhuo@linux.alibaba.com, pbonzini@redhat.com, jasowang@redhat.com,
	Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>
X-Entity-ID: u001.9Nu+sJkq3f0LJ/tZbyfOWA==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii

When the PCI device is surprise-removed, requests may not complete on
the device as the VQ is marked as broken. As a result, disk deletion
hangs.

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
 drivers/block/virtio_blk.c | 83 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 7cffea01d868..12f31e6c00cb 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1554,6 +1554,87 @@ static int virtblk_probe(struct virtio_device *vdev)
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
+	/* Start freezing the queue, so that new requests keeps waiting at the
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
@@ -1561,6 +1642,8 @@ static void virtblk_remove(struct virtio_device *vdev)
 	/* Make sure no work handler is accessing the device. */
 	flush_work(&vblk->config_work);
 
+	virtblk_broken_device_cleanup(vblk);
+
 	del_gendisk(vblk->disk);
 	blk_mq_free_tag_set(&vblk->tag_set);
 
-- 
2.34.1

