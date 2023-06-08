Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D131C7EE29
	for <virtualization@archiver.kernel.org>; Thu,  8 Jun 2023 21:47:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57E5142444;
	Thu,  8 Jun 2023 21:47:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 57E5142444
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HJoM2K2B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V0F1B6jOV-AX; Thu,  8 Jun 2023 21:47:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 359F542439;
	Thu,  8 Jun 2023 21:47:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 359F542439
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D335C007A;
	Thu,  8 Jun 2023 21:47:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B881C0029
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 21:47:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F27C42444
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 21:47:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4F27C42444
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DRf-bwkIn-1v
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 21:47:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B57F842439
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B57F842439
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Jun 2023 21:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686260841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=3M2thlA3iIdihiFPMBCL4mQEMmIBWZIL+21nRfiIlP4=;
 b=HJoM2K2BqNekmF7xb1a/51MOMY9NI1OzWFpdzEfQBKABIkxpV3RvcVJjhChrYFm86pFprt
 Qzg89xoRyBcOR1/wQkLC+ojTYadr6ocfjSXVXRpy6MyYkSQtauXCm2vD2cxSLCPSUgQvea
 Xe9jGWPrSeOEG3W0ihcbiAwGFw8Mhy8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-c260wfhTNdmGYgZ_teCF7A-1; Thu, 08 Jun 2023 17:47:20 -0400
X-MC-Unique: c260wfhTNdmGYgZ_teCF7A-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30e6153f0eeso528770f8f.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 08 Jun 2023 14:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686260838; x=1688852838;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3M2thlA3iIdihiFPMBCL4mQEMmIBWZIL+21nRfiIlP4=;
 b=aU+a8FRS7ryrduzd2Gn59JPxJM4f16jgFZBTTnzUF0HtAc9XyiyOTzGiqQYtw6ejoq
 JzChWuRgiMCet92jPFDIdj6xNxs+CSDDExjIJnMJPaHOYXD73ZdP9vF+qpQaW6H8xBPH
 LN9sXT96CxcW/wglsQoKZs0vfEEs4AR96fXQ5FWWzNPE/VgMKrPj2LDaYi/mE77olAfO
 UoyXHUxFMhsd0E0WtfxehTlqcj+gTLAd3R6OW6PApedEAypQFf9TJ/tn2A4GHGfOkoc3
 h/iGH0HtuBdJ/TbvUF5g9D553/mDFFVBz96AzA4ZxD5Fc1+cy3R4QlnBOi5GrPVMKkHR
 /mPA==
X-Gm-Message-State: AC+VfDw0hNjOuT4JhYkMAkIa2DgDwTqZQB383axIMtuPmiq4PXwcVyeZ
 9N7JmA93il8+7CZ1kE974tmIooJuIr9VsrVJXWxpgCtsiqcnQgasJXAZbI8Kjd8KQMjJOz7ok/v
 CaVAW1xb4Brgwbl8gwEAWlKItpaSa8Qw1S54o9cY1AA==
X-Received: by 2002:adf:fac2:0:b0:30a:e097:7b5a with SMTP id
 a2-20020adffac2000000b0030ae0977b5amr6721262wrs.36.1686260838513; 
 Thu, 08 Jun 2023 14:47:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5eFOE0kLRozXykE8KF61JY4eAUIrE8J14zHBrjaDn2pvUk/XZ8caYZQve+exKvQQDYsmmXmA==
X-Received: by 2002:adf:fac2:0:b0:30a:e097:7b5a with SMTP id
 a2-20020adffac2000000b0030ae0977b5amr6721251wrs.36.1686260838141; 
 Thu, 08 Jun 2023 14:47:18 -0700 (PDT)
Received: from redhat.com ([2.55.41.2]) by smtp.gmail.com with ESMTPSA id
 s1-20020a5d4ec1000000b002c70ce264bfsm2615372wrv.76.2023.06.08.14.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 14:47:17 -0700 (PDT)
Date: Thu, 8 Jun 2023 17:47:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "virtio-blk: support completion batching for the IRQ
 path"
Message-ID: <9443f7273fbba6e62f89e54cbb2a70d2c93ed8e9.1686260774.git.mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Roberts, Martin" <martin.roberts@intel.com>,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Suwan Kim <suwan.kim027@gmail.com>
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

This reverts commit 07b679f70d73483930e8d3c293942416d9cd5c13.

This change appears to have broken things...
We now see applications hanging during disk accesses.
e.g.
multi-port virtio-blk device running in h/w (FPGA)
Host running a simple 'fio' test.
[global]
thread=1
direct=1
ioengine=libaio
norandommap=1
group_reporting=1
bs=4K
rw=read
iodepth=128
runtime=1
numjobs=4
time_based
[job0]
filename=/dev/vda
[job1]
filename=/dev/vdb
[job2]
filename=/dev/vdc
...
[job15]
filename=/dev/vdp

i.e. 16 disks; 4 queues per disk; simple burst of 4KB reads
This is repeatedly run in a loop.

After a few, normally <10 seconds, fio hangs.
With 64 queues (16 disks), failure occurs within a few seconds; with 8 queues (2 disks) it may take ~hour before hanging.
Last message:
fio-3.19
Starting 8 threads
Jobs: 1 (f=1): [_(7),R(1)][68.3%][eta 03h:11m:06s]
I think this means at the end of the run 1 queue was left incomplete.

'diskstats' (run while fio is hung) shows no outstanding transactions.
e.g.
$ cat /proc/diskstats
...
252       0 vda 1843140071 0 14745120568 712568645 0 0 0 0 0 3117947 712568645 0 0 0 0 0 0
252      16 vdb 1816291511 0 14530332088 704905623 0 0 0 0 0 3117711 704905623 0 0 0 0 0 0
...

Other stats (in the h/w, and added to the virtio-blk driver ([a]virtio_queue_rq(), [b]virtblk_handle_req(), [c]virtblk_request_done()) all agree, and show every request had a completion, and that virtblk_request_done() never gets called.
e.g.
PF= 0                         vq=0           1           2           3
[a]request_count     -   839416590   813148916   105586179    84988123
[b]completion1_count -   839416590   813148916   105586179    84988123
[c]completion2_count -           0           0           0           0

PF= 1                         vq=0           1           2           3
[a]request_count     -   823335887   812516140   104582672    75856549
[b]completion1_count -   823335887   812516140   104582672    75856549
[c]completion2_count -           0           0           0           0

i.e. the issue is after the virtio-blk driver.

This change was introduced in kernel 6.3.0.
I am seeing this using 6.3.3.
If I run with an earlier kernel (5.15), it does not occur.
If I make a simple patch to the 6.3.3 virtio-blk driver, to skip the blk_mq_add_to_batch()call, it does not fail.
e.g.
kernel 5.15 - this is OK
virtio_blk.c,virtblk_done() [irq handler]
                 if (likely(!blk_should_fake_timeout(req->q))) {
                          blk_mq_complete_request(req);
                 }

kernel 6.3.3 - this fails
virtio_blk.c,virtblk_handle_req() [irq handler]
                 if (likely(!blk_should_fake_timeout(req->q))) {
                          if (!blk_mq_complete_request_remote(req)) {
                                  if (!blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr), virtblk_complete_batch)) {
                                           virtblk_request_done(req);    //this never gets called... so blk_mq_add_to_batch() must always succeed
                                   }
                          }
                 }

If I do, kernel 6.3.3 - this is OK
virtio_blk.c,virtblk_handle_req() [irq handler]
                 if (likely(!blk_should_fake_timeout(req->q))) {
                          if (!blk_mq_complete_request_remote(req)) {
                                   virtblk_request_done(req); //force this here...
                                  if (!blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr), virtblk_complete_batch)) {
                                           virtblk_request_done(req);    //this never gets called... so blk_mq_add_to_batch() must always succeed
                                   }
                          }
                 }

Perhaps you might like to fix/test/revert this change...
Martin

Reported-by: "Roberts, Martin" <martin.roberts@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Completely untested.
Martin can you pls test and report whether this fixes the problem?
Thanks!

 drivers/block/virtio_blk.c | 82 +++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 45 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 2b918e28acaa..c1e65b4d8071 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -348,63 +348,33 @@ static inline void virtblk_request_done(struct request *req)
 	blk_mq_end_request(req, status);
 }
 
-static void virtblk_complete_batch(struct io_comp_batch *iob)
-{
-	struct request *req;
-
-	rq_list_for_each(&iob->req_list, req) {
-		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
-		virtblk_cleanup_cmd(req);
-	}
-	blk_mq_end_request_batch(iob);
-}
-
-static int virtblk_handle_req(struct virtio_blk_vq *vq,
-			      struct io_comp_batch *iob)
-{
-	struct virtblk_req *vbr;
-	int req_done = 0;
-	unsigned int len;
-
-	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
-		struct request *req = blk_mq_rq_from_pdu(vbr);
-
-		if (likely(!blk_should_fake_timeout(req->q)) &&
-		    !blk_mq_complete_request_remote(req) &&
-		    !blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr),
-					 virtblk_complete_batch))
-			virtblk_request_done(req);
-		req_done++;
-	}
-
-	return req_done;
-}
-
 static void virtblk_done(struct virtqueue *vq)
 {
 	struct virtio_blk *vblk = vq->vdev->priv;
-	struct virtio_blk_vq *vblk_vq = &vblk->vqs[vq->index];
-	int req_done = 0;
+	bool req_done = false;
+	int qid = vq->index;
+	struct virtblk_req *vbr;
 	unsigned long flags;
-	DEFINE_IO_COMP_BATCH(iob);
+	unsigned int len;
 
-	spin_lock_irqsave(&vblk_vq->lock, flags);
+	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
 	do {
 		virtqueue_disable_cb(vq);
-		req_done += virtblk_handle_req(vblk_vq, &iob);
+		while ((vbr = virtqueue_get_buf(vblk->vqs[qid].vq, &len)) != NULL) {
+			struct request *req = blk_mq_rq_from_pdu(vbr);
 
+			if (likely(!blk_should_fake_timeout(req->q)))
+				blk_mq_complete_request(req);
+			req_done = true;
+		}
 		if (unlikely(virtqueue_is_broken(vq)))
 			break;
 	} while (!virtqueue_enable_cb(vq));
 
-	if (req_done) {
-		if (!rq_list_empty(iob.req_list))
-			iob.complete(&iob);
-
-		/* In case queue is stopped waiting for more buffers. */
+	/* In case queue is stopped waiting for more buffers. */
+	if (req_done)
 		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
-	}
-	spin_unlock_irqrestore(&vblk_vq->lock, flags);
+	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
 }
 
 static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
@@ -1283,15 +1253,37 @@ static void virtblk_map_queues(struct blk_mq_tag_set *set)
 	}
 }
 
+static void virtblk_complete_batch(struct io_comp_batch *iob)
+{
+	struct request *req;
+
+	rq_list_for_each(&iob->req_list, req) {
+		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
+		virtblk_cleanup_cmd(req);
+	}
+	blk_mq_end_request_batch(iob);
+}
+
 static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 {
 	struct virtio_blk *vblk = hctx->queue->queuedata;
 	struct virtio_blk_vq *vq = get_virtio_blk_vq(hctx);
+	struct virtblk_req *vbr;
 	unsigned long flags;
+	unsigned int len;
 	int found = 0;
 
 	spin_lock_irqsave(&vq->lock, flags);
-	found = virtblk_handle_req(vq, iob);
+
+	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
+		struct request *req = blk_mq_rq_from_pdu(vbr);
+
+		found++;
+		if (!blk_mq_complete_request_remote(req) &&
+		    !blk_mq_add_to_batch(req, iob, vbr->status,
+						virtblk_complete_batch))
+			virtblk_request_done(req);
+	}
 
 	if (found)
 		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
