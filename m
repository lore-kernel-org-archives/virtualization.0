Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84AD3C7EE2E
	for <virtualization@archiver.kernel.org>; Fri,  9 Jun 2023 07:27:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F28B142446;
	Fri,  9 Jun 2023 07:27:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F28B142446
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U2z4NExu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J966ouJgB_y7; Fri,  9 Jun 2023 07:27:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BDEBC42439;
	Fri,  9 Jun 2023 07:27:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BDEBC42439
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 950F6C0037;
	Fri,  9 Jun 2023 07:27:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAF30C0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 07:27:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7705A40AB0
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 07:27:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7705A40AB0
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=U2z4NExu
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HCtFIT00kXhy
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 07:27:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D002D40189
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D002D40189
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 07:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686295652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=k8uL9RB2TZeMZAUxmhUna0m1Gfo0R9DVnwUW3ywqZ+c=;
 b=U2z4NExughLjD9cNlVAtDc5bq8IaA9fkdPfnIXYDUFK9tiwIApHOzw1nUGq5Pnw0GN7pYK
 1K8IUP0gxqpdBfa/hk9nVJo7tcc3xrFSEc69j170gkRe+2wO6rmYE0IkrxkokHq/Zt/BYh
 iKTHDxbuGSZo44NZTzoSPnn3Mjt0UNg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-zT2PEZP5MxuckhR9s0hrQA-1; Fri, 09 Jun 2023 03:27:31 -0400
X-MC-Unique: zT2PEZP5MxuckhR9s0hrQA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f7eb414fcbso6696765e9.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 09 Jun 2023 00:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686295648; x=1688887648;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k8uL9RB2TZeMZAUxmhUna0m1Gfo0R9DVnwUW3ywqZ+c=;
 b=Y9YL0Pk6XhrgHLywnTmCllfeGjOp9dLY5B+eaSJzXYJwVdA+LjVOW0CcovZLQGnGqO
 cOgKeQ6gNmAvfPNq6JhN+LgTrI9uv3mj64FSjSONMQUsnKV9vVTZzCLb+3rqxE4GWdAl
 hIuv14DuhMglScWT/SHKmCYCr9pBuw/1x60d2b9QsC03bVFuvQZirJxNCzyFPWl1kLSY
 IoljcM3DHO6T1ItMhHD7KfqDPE5iHGiJqyjq7fr0lZVPgj4u3dbalSavDShpVWBLZ7eH
 Dpun6puNyWoeLYXcef9WL8mknIox6RyAcRYOMM8e9q6qLvkiwiuHkvT2YUSYlWFKyYwK
 pmXg==
X-Gm-Message-State: AC+VfDzlDeCC2QNbhGz6BgHWNcROkcWuDlxfxxwfz5R3JVS/CNRaoxzX
 UnYKMwxw+ROCeUpQpqEVrrolG32dESmzAd+KUTz2htxFc+NroZ9t88vqyFhY5Q1T3Xg9AvNSTHJ
 zdvRYRAiXxn6VABS0RkR0zMxXqEYANWE6FDpa78h9FA==
X-Received: by 2002:a1c:4b09:0:b0:3f7:f2a1:482f with SMTP id
 y9-20020a1c4b09000000b003f7f2a1482fmr230018wma.11.1686295648235; 
 Fri, 09 Jun 2023 00:27:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4QrxmXCtI9za5XfR+IvU75+9yMq+VNOhenv+q0gG491TweVM4s+/FuocFYUmW+BenHFGmOXg==
X-Received: by 2002:a1c:4b09:0:b0:3f7:f2a1:482f with SMTP id
 y9-20020a1c4b09000000b003f7f2a1482fmr230008wma.11.1686295647923; 
 Fri, 09 Jun 2023 00:27:27 -0700 (PDT)
Received: from redhat.com ([2.55.4.169]) by smtp.gmail.com with ESMTPSA id
 x17-20020a1c7c11000000b003f809461162sm103677wmc.16.2023.06.09.00.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jun 2023 00:27:27 -0700 (PDT)
Date: Fri, 9 Jun 2023 03:27:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2] Revert "virtio-blk: support completion batching for the
 IRQ path"
Message-ID: <336455b4f630f329380a8f53ee8cad3868764d5c.1686295549.git.mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 kernel test robot <lkp@intel.com>, "Roberts,
 Martin" <martin.roberts@intel.com>, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Suwan Kim <suwan.kim027@gmail.com>
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

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306090826.C1fZmdMe-lkp@intel.com/
Cc: Suwan Kim <suwan.kim027@gmail.com>
Reported-by: "Roberts, Martin" <martin.roberts@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Since v1:
	fix build error

Still completely untested as I'm traveling.
Martin, Suwan, could you please test and report?
Suwan if you have a better revert in mind pls post and
I will be happy to drop this.

Thanks!


 drivers/block/virtio_blk.c | 82 +++++++++++++++++---------------------
 1 file changed, 37 insertions(+), 45 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 2b918e28acaa..b47358da92a2 100644
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
+		    !blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr),
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
