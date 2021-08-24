Return-Path: <SRS0=e+fm=NP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A812C4338F
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 11:00:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B4DD6135F
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 11:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4B4DD6135F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DAC080E14;
	Tue, 24 Aug 2021 11:00:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c2cC6D4JAnOC; Tue, 24 Aug 2021 11:00:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0BC0D80D88;
	Tue, 24 Aug 2021 11:00:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E4C55C001A;
	Tue, 24 Aug 2021 11:00:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51DA5C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 11:00:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 31248400AE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 11:00:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LT8STXCUA37P
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 11:00:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 675C0400A8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 11:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629802826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AITPksYvMoEXxNB1LWW4gg0jWVIK1CjIJ+gc/HJY6ys=;
 b=gDgOrjh90oTxVzrhfGvHeSZ5X39QvGIhLoZEvZwAPwqBVCHyOdiqyPzxRZYHvCsGBpTD50
 L/cHmOp7T5vZHvnq0TbWjtlrIysf7NiI2kkDIPQh/5nhS2a4VbHx5hmaG5r+1llWlVmQoC
 zjbdcX3FGtvYADVfkMIskOyAo+o97WY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-eBmXFg38NdiFhZ25EZQvqQ-1; Tue, 24 Aug 2021 07:00:25 -0400
X-MC-Unique: eBmXFg38NdiFhZ25EZQvqQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AFE58799ED;
 Tue, 24 Aug 2021 11:00:24 +0000 (UTC)
Received: from localhost (unknown [10.39.195.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3FA8C1346F;
 Tue, 24 Aug 2021 11:00:11 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 1/1] fuse: disable local irqs when processing vq
 completions
Date: Tue, 24 Aug 2021 11:59:44 +0100
Message-Id: <20210824105944.172659-2-stefanha@redhat.com>
In-Reply-To: <20210824105944.172659-1-stefanha@redhat.com>
References: <20210824105944.172659-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>,
 linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 vgoyal@redhat.com, Xiaoling Gao <xiagao@redhat.com>
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

The virtqueue completion handler function runs on a work queue and local
irqs are still enabled. There is a race where the completion handler
function grabs the next completed request just before vring_interrupt()
runs. vring_interrupt() sees an empty virtqueue and returns IRQ_NONE,
falsely declaring this interrupt unhandled.

The unhandled irq causes the kernel to disable the irq:

  irq 77: nobody cared (try booting with the "irqpoll" option)
  ...
  handlers:
  [<00000000d33eeed7>] vring_interrupt
  Disabling IRQ #77

The driver hangs afterwards since virtqueue irqs are now ignored.

Disable local irqs before calling virtqueue_get_buf() and re-enable them
afterwards so that vring_interrupt() doesn't run during the race window.

Reported-by: Xiaoling Gao <xiagao@redhat.com>
Cc: Michael Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
I'm not 100% convinced this fixes everything because vring_interrupt()
can still run after our critical section and find the virtqueue empty.
virtqueue_disable_cb() should minimize that but it's only a hint and
there is a small window when the race condition can happen before it's
called.
---
 fs/fuse/virtio_fs.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 8f52cdaa8445..57e1f264b0a8 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -319,9 +319,10 @@ static void virtio_fs_hiprio_done_work(struct work_struct *work)
 	struct virtio_fs_vq *fsvq = container_of(work, struct virtio_fs_vq,
 						 done_work);
 	struct virtqueue *vq = fsvq->vq;
+	unsigned long flags;
 
 	/* Free completed FUSE_FORGET requests */
-	spin_lock(&fsvq->lock);
+	spin_lock_irqsave(&fsvq->lock, flags);
 	do {
 		unsigned int len;
 		void *req;
@@ -333,7 +334,7 @@ static void virtio_fs_hiprio_done_work(struct work_struct *work)
 			dec_in_flight_req(fsvq);
 		}
 	} while (!virtqueue_enable_cb(vq) && likely(!virtqueue_is_broken(vq)));
-	spin_unlock(&fsvq->lock);
+	spin_unlock_irqrestore(&fsvq->lock, flags);
 }
 
 static void virtio_fs_request_dispatch_work(struct work_struct *work)
@@ -601,11 +602,15 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 	struct virtqueue *vq = fsvq->vq;
 	struct fuse_req *req;
 	struct fuse_req *next;
+	unsigned long flags;
 	unsigned int len;
 	LIST_HEAD(reqs);
 
-	/* Collect completed requests off the virtqueue */
-	spin_lock(&fsvq->lock);
+	/*
+	 * Collect completed requests off the virtqueue with irqs disabled to
+	 * prevent races with vring_interrupt().
+	 */
+	spin_lock_irqsave(&fsvq->lock, flags);
 	do {
 		virtqueue_disable_cb(vq);
 
@@ -615,7 +620,7 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 			spin_unlock(&fpq->lock);
 		}
 	} while (!virtqueue_enable_cb(vq) && likely(!virtqueue_is_broken(vq)));
-	spin_unlock(&fsvq->lock);
+	spin_unlock_irqrestore(&fsvq->lock, flags);
 
 	/* End requests */
 	list_for_each_entry_safe(req, next, &reqs, list) {
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
