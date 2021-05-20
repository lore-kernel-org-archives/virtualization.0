Return-Path: <SRS0=jrxE=KP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4AEC433B4
	for <virtualization@archiver.kernel.org>; Thu, 20 May 2021 14:13:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35C3F608FE
	for <virtualization@archiver.kernel.org>; Thu, 20 May 2021 14:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C3F608FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 03360404AF;
	Thu, 20 May 2021 14:13:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gsd7DCgGGrH0; Thu, 20 May 2021 14:13:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6873A400CC;
	Thu, 20 May 2021 14:13:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 440E9C000E;
	Thu, 20 May 2021 14:13:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C45E0C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 14:13:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A571C400CC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 14:13:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X02vAPuxxF48
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 14:13:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C366D404AF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 14:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621520026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4aBvqPz1XdTYzGjtiidMRJ9JyKKUPGFlSqJpEy6NtC0=;
 b=fFQf0niK3R1cY6V6/adPWkYz9b7cPRPSR29tvhggplMK6954objnYYttX9s7HE7joonByI
 TRdsxhrgvNiV0s82U1ZTA+LagBKGZgMZl00LkeCXSpD6FxnIc7dIkbaFqfJQ1OT8qiLgpe
 afpkhlwdgmtgSWsDGsNjSEJiQJJppqQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-bnN5ytCLMaSf6Ku-fnacKg-1; Thu, 20 May 2021 10:13:45 -0400
X-MC-Unique: bnN5ytCLMaSf6Ku-fnacKg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E432D107ACE3;
 Thu, 20 May 2021 14:13:43 +0000 (UTC)
Received: from localhost (ovpn-115-223.ams2.redhat.com [10.36.115.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 770231037F22;
 Thu, 20 May 2021 14:13:43 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 3/3] virtio_blk: implement blk_mq_ops->poll()
Date: Thu, 20 May 2021 15:13:05 +0100
Message-Id: <20210520141305.355961-4-stefanha@redhat.com>
In-Reply-To: <20210520141305.355961-1-stefanha@redhat.com>
References: <20210520141305.355961-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Christoph Hellwig <hch@lst.de>
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

Request completion latency can be reduced by using polling instead of
irqs. Even Posted Interrupts or similar hardware support doesn't beat
polling. The reason is that disabling virtqueue notifications saves
critical-path CPU cycles on the host by skipping irq injection and in
the guest by skipping the irq handler. So let's add blk_mq_ops->poll()
support to virtio_blk.

The approach taken by this patch differs from the NVMe driver's
approach. NVMe dedicates hardware queues to polling and submits
REQ_HIPRI requests only on those queues. This patch does not require
exclusive polling queues for virtio_blk. Instead, it switches between
irqs and polling when one or more REQ_HIPRI requests are in flight on a
virtqueue.

This is possible because toggling virtqueue notifications is cheap even
while the virtqueue is running. NVMe cqs can't do this because irqs are
only enabled/disabled at queue creation time.

This toggling approach requires no configuration. There is no need to
dedicate queues ahead of time or to teach users and orchestration tools
how to set up polling queues.

Possible drawbacks of this approach:

- Hardware virtio_blk implementations may find virtqueue_disable_cb()
  expensive since it requires DMA. If such devices become popular then
  the virtio_blk driver could use a similar approach to NVMe when
  VIRTIO_F_ACCESS_PLATFORM is detected in the future.

- If a blk_poll() thread is descheduled it not only hurts polling
  performance but also delays completion of non-REQ_HIPRI requests on
  that virtqueue since vq notifications are disabled.

Performance:

- Benchmark: fio ioengine=pvsync2 numjobs=4 direct=1
- Guest: 4 vCPUs with one virtio-blk device (4 virtqueues)
- Disk: Intel Corporation NVMe Datacenter SSD [Optane] [8086:2701]
- CPU: Intel(R) Xeon(R) Silver 4214 CPU @ 2.20GHz

rw          bs hipri=0 hipri=1
------------------------------
randread    4k 149,426 170,763 +14%
randread   16k 118,939 134,269 +12%
randread   64k  34,886  34,906   0%
randread  128k  17,655  17,667   0%
randwrite   4k 138,578 163,600 +18%
randwrite  16k 102,089 120,950 +18%
randwrite  64k  32,364  32,561   0%
randwrite 128k  16,154  16,237   0%
read        4k 146,032 170,620 +16%
read       16k 117,097 130,437 +11%
read       64k  34,834  35,037   0%
read      128k  17,680  17,658   0%
write       4k 134,562 151,422 +12%
write      16k 101,796 107,606  +5%
write      64k  32,364  32,594   0%
write     128k  16,259  16,265   0%

Larger block sizes do not benefit from polling as much but the
improvement is worthwhile for smaller block sizes.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 drivers/block/virtio_blk.c | 92 +++++++++++++++++++++++++++++++++++---
 1 file changed, 87 insertions(+), 5 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index fc0fb1dcd399..f0243dcd745a 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -29,6 +29,16 @@ static struct workqueue_struct *virtblk_wq;
 struct virtio_blk_vq {
 	struct virtqueue *vq;
 	spinlock_t lock;
+
+	/* Number of non-REQ_HIPRI requests in flight. Protected by lock. */
+	unsigned int num_lopri;
+
+	/* Number of REQ_HIPRI requests in flight. Protected by lock. */
+	unsigned int num_hipri;
+
+	/* Are vq notifications enabled? Protected by lock. */
+	bool cb_enabled;
+
 	char name[VQ_NAME_LEN];
 } ____cacheline_aligned_in_smp;
 
@@ -171,33 +181,67 @@ static inline void virtblk_request_done(struct request *req)
 	blk_mq_end_request(req, virtblk_result(vbr));
 }
 
-static void virtblk_done(struct virtqueue *vq)
+/* Returns true if one or more requests completed */
+static bool virtblk_complete_requests(struct virtqueue *vq)
 {
 	struct virtio_blk *vblk = vq->vdev->priv;
 	struct virtio_blk_vq *vbq = &vblk->vqs[vq->index];
 	bool req_done = false;
+	bool last_hipri_done = false;
 	struct virtblk_req *vbr;
 	unsigned long flags;
 	unsigned int len;
 
 	spin_lock_irqsave(&vbq->lock, flags);
+
 	do {
-		virtqueue_disable_cb(vq);
+		if (vbq->cb_enabled)
+			virtqueue_disable_cb(vq);
 		while ((vbr = virtqueue_get_buf(vq, &len)) != NULL) {
 			struct request *req = blk_mq_rq_from_pdu(vbr);
 
+			if (req->cmd_flags & REQ_HIPRI) {
+				if (--vbq->num_hipri == 0)
+					last_hipri_done = true;
+			} else
+				vbq->num_lopri--;
+
 			if (likely(!blk_should_fake_timeout(req->q)))
 				blk_mq_complete_request(req);
 			req_done = true;
 		}
 		if (unlikely(virtqueue_is_broken(vq)))
 			break;
-	} while (!virtqueue_enable_cb(vq));
+
+		/* Enable vq notifications if non-polled requests remain */
+		if (last_hipri_done && vbq->num_lopri > 0) {
+			last_hipri_done = false;
+			vbq->cb_enabled = true;
+		}
+	} while (vbq->cb_enabled && !virtqueue_enable_cb(vq));
 
 	/* In case queue is stopped waiting for more buffers. */
 	if (req_done)
 		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
 	spin_unlock_irqrestore(&vbq->lock, flags);
+
+	return req_done;
+}
+
+static int virtblk_poll(struct blk_mq_hw_ctx *hctx)
+{
+	struct virtio_blk *vblk = hctx->queue->queuedata;
+	struct virtqueue *vq = vblk->vqs[hctx->queue_num].vq;
+
+	if (!virtqueue_more_used(vq))
+		return 0;
+
+	return virtblk_complete_requests(vq);
+}
+
+static void virtblk_done(struct virtqueue *vq)
+{
+	virtblk_complete_requests(vq);
 }
 
 static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
@@ -275,6 +319,16 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 	spin_lock_irqsave(&vbq->lock, flags);
+
+	/* Re-enable vq notifications if first req is non-polling */
+	if (!(req->cmd_flags & REQ_HIPRI) &&
+	    vbq->num_lopri == 0 && vbq->num_hipri == 0 &&
+	    !vbq->cb_enabled) {
+		/* Can't return false since there are no in-flight reqs */
+		virtqueue_enable_cb(vbq->vq);
+		vbq->cb_enabled = true;
+	}
+
 	err = virtblk_add_req(vbq->vq, vbr, vbr->sg, num);
 	if (err) {
 		virtqueue_kick(vbq->vq);
@@ -294,6 +348,21 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 		}
 	}
 
+	/*
+	 * Disable vq notifications when polled reqs are submitted.
+	 *
+	 * The virtqueue lock is held so req is still valid here even if the
+	 * device polls the virtqueue and completes the request before we call
+	 * virtqueue_notify().
+	 */
+	if (req->cmd_flags & REQ_HIPRI) {
+		if (vbq->num_hipri++ == 0 && vbq->cb_enabled) {
+			virtqueue_disable_cb(vbq->vq);
+			vbq->cb_enabled = false;
+		}
+	} else
+		vbq->num_lopri++;
+
 	if (bd->last && virtqueue_kick_prepare(vbq->vq))
 		notify = true;
 	spin_unlock_irqrestore(&vbq->lock, flags);
@@ -533,6 +602,9 @@ static int init_vq(struct virtio_blk *vblk)
 	for (i = 0; i < num_vqs; i++) {
 		spin_lock_init(&vblk->vqs[i].lock);
 		vblk->vqs[i].vq = vqs[i];
+		vblk->vqs[i].num_lopri = 0;
+		vblk->vqs[i].num_hipri = 0;
+		vblk->vqs[i].cb_enabled = true;
 	}
 	vblk->num_vqs = num_vqs;
 
@@ -681,8 +753,16 @@ static int virtblk_map_queues(struct blk_mq_tag_set *set)
 {
 	struct virtio_blk *vblk = set->driver_data;
 
-	return blk_mq_virtio_map_queues(&set->map[HCTX_TYPE_DEFAULT],
-					vblk->vdev, 0);
+	set->map[HCTX_TYPE_DEFAULT].nr_queues = vblk->num_vqs;
+	blk_mq_virtio_map_queues(&set->map[HCTX_TYPE_DEFAULT], vblk->vdev, 0);
+
+	set->map[HCTX_TYPE_READ].nr_queues = 0;
+
+	/* HCTX_TYPE_DEFAULT queues are shared with HCTX_TYPE_POLL */
+	set->map[HCTX_TYPE_POLL].nr_queues = vblk->num_vqs;
+	blk_mq_virtio_map_queues(&set->map[HCTX_TYPE_POLL], vblk->vdev, 0);
+
+	return 0;
 }
 
 static const struct blk_mq_ops virtio_mq_ops = {
@@ -691,6 +771,7 @@ static const struct blk_mq_ops virtio_mq_ops = {
 	.complete	= virtblk_request_done,
 	.init_request	= virtblk_init_request,
 	.map_queues	= virtblk_map_queues,
+	.poll		= virtblk_poll,
 };
 
 static unsigned int virtblk_queue_depth;
@@ -768,6 +849,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 
 	memset(&vblk->tag_set, 0, sizeof(vblk->tag_set));
 	vblk->tag_set.ops = &virtio_mq_ops;
+	vblk->tag_set.nr_maps = 3; /* default, read, and poll */
 	vblk->tag_set.queue_depth = queue_depth;
 	vblk->tag_set.numa_node = NUMA_NO_NODE;
 	vblk->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
