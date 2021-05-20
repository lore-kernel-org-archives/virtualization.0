Return-Path: <SRS0=jrxE=KP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D0EC433ED
	for <virtualization@archiver.kernel.org>; Thu, 20 May 2021 14:13:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3131611AE
	for <virtualization@archiver.kernel.org>; Thu, 20 May 2021 14:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3131611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B9C883DFF;
	Thu, 20 May 2021 14:13:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uk_PCh7pTKDJ; Thu, 20 May 2021 14:13:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 311DC83D81;
	Thu, 20 May 2021 14:13:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FE37C000E;
	Thu, 20 May 2021 14:13:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27F23C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 14:13:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A4F540218
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 14:13:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z7QPESMT0Knz
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 14:13:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 62612400CC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 May 2021 14:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621520013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EQLmeFAYlSq9MUn0ggB4grwFyWkzklNm3btxmw1JEAk=;
 b=aYewR6HJe8vzqcwNxcxLIaC1CXppMWd+wz6ErOs4uDpvv3hMvhayT2YR0w4DJwuNZ3k/YG
 ay2foquf2tHgc0zeUYpS+rtAx37CjYQim0UORQrYiuhfobygxoG3ZDD1z9h5Qc2Yad21Zl
 Zi1rXSWXnyNSm6u1Il3inn++HBG7tsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-LqypewjZMVWBZWKdzJlFSw-1; Thu, 20 May 2021 10:13:31 -0400
X-MC-Unique: LqypewjZMVWBZWKdzJlFSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4A646872FFE;
 Thu, 20 May 2021 14:13:30 +0000 (UTC)
Received: from localhost (ovpn-115-223.ams2.redhat.com [10.36.115.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71E7719718;
 Thu, 20 May 2021 14:13:19 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 1/3] virtio: add virtioqueue_more_used()
Date: Thu, 20 May 2021 15:13:03 +0100
Message-Id: <20210520141305.355961-2-stefanha@redhat.com>
In-Reply-To: <20210520141305.355961-1-stefanha@redhat.com>
References: <20210520141305.355961-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

Add an API to check whether there are pending used buffers. There is
already a similar API called virtqueue_poll() but it only works together
with virtqueue_enable_cb_prepare(). The patches that follow add blk-mq
->poll() support to virtio_blk and they need to check for used buffers
without re-enabling virtqueue callbacks, so introduce an API for it.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/linux/virtio.h       |  2 ++
 drivers/virtio/virtio_ring.c | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index b1894e0323fa..c6ad0f25f412 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -63,6 +63,8 @@ bool virtqueue_kick_prepare(struct virtqueue *vq);
 
 bool virtqueue_notify(struct virtqueue *vq);
 
+bool virtqueue_more_used(const struct virtqueue *vq);
+
 void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len);
 
 void *virtqueue_get_buf_ctx(struct virtqueue *vq, unsigned int *len,
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 71e16b53e9c1..7c3da75da462 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2032,6 +2032,23 @@ static inline bool more_used(const struct vring_virtqueue *vq)
 	return vq->packed_ring ? more_used_packed(vq) : more_used_split(vq);
 }
 
+/**
+ * virtqueue_more_used - check if there are used buffers pending
+ * @_vq: the struct virtqueue we're talking about.
+ *
+ * Returns true if there are used buffers, false otherwise. May be called at
+ * the same time as other virtqueue operations, but actually calling
+ * virtqueue_get_buf() requires serialization so be mindful of the race between
+ * calling virtqueue_more_used() and virtqueue_get_buf().
+ */
+bool virtqueue_more_used(const struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	return more_used(vq);
+}
+EXPORT_SYMBOL_GPL(virtqueue_more_used);
+
 irqreturn_t vring_interrupt(int irq, void *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
