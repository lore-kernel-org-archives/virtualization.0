Return-Path: <SRS0=bReq=JU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C475C43460
	for <virtualization@archiver.kernel.org>; Fri, 23 Apr 2021 08:10:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27CB261350
	for <virtualization@archiver.kernel.org>; Fri, 23 Apr 2021 08:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CB261350
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BEBA440608;
	Fri, 23 Apr 2021 08:10:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7bvinbeVjKSB; Fri, 23 Apr 2021 08:10:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 51C7E400BD;
	Fri, 23 Apr 2021 08:10:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E8DEC000F;
	Fri, 23 Apr 2021 08:10:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64656C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 08:10:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5292F40FB5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 08:10:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TOVVHoTui1Z9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 08:10:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 53CB240FAD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 08:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619165430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OdzRn3Pr0rYI0rGRBMCl0SRE17R3Lml0KXCJ6hRRlik=;
 b=jRwwSNCYdUnVcP9wnDEVMTEcq8v/x1f3XkxF8aVsHMatXt8dAIUzOt0Xz2Q9gD/g/OtYn0
 CbrmP38z9K3nXCPwNHgKv07WtSNF+2vPUdyVuvC0g56so5WE7UEiIjyZVr+XUv50ywjOTG
 5Y182IYkWCGWvz7IUUVUM3UvD2OQGJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-LEtF0w2zOQWjQREk2-Cjcg-1; Fri, 23 Apr 2021 04:10:28 -0400
X-MC-Unique: LEtF0w2zOQWjQREk2-Cjcg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADC6F107ACC7;
 Fri, 23 Apr 2021 08:10:26 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-225.pek2.redhat.com
 [10.72.13.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B49A45C541;
 Fri, 23 Apr 2021 08:10:07 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [RFC PATCH V2 1/7] virtio-ring: maintain next in extra state for
 packed virtqueue
Date: Fri, 23 Apr 2021 16:09:36 +0800
Message-Id: <20210423080942.2997-2-jasowang@redhat.com>
In-Reply-To: <20210423080942.2997-1-jasowang@redhat.com>
References: <20210423080942.2997-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: ashish.kalra@amd.com, file@sect.tu-berlin.de, kvm@vger.kernel.org,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 xieyongji@bytedance.com, stefanha@redhat.com
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

This patch moves next from vring_desc_state_packed to
vring_desc_desc_extra_packed. This makes it simpler to let extra state
to be reused by split virtqueue.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 71e16b53e9c1..e1e9ed42e637 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -74,7 +74,6 @@ struct vring_desc_state_packed {
 	void *data;			/* Data for callback. */
 	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
 	u16 num;			/* Descriptor list length. */
-	u16 next;			/* The next desc state in a list. */
 	u16 last;			/* The last desc state in a list. */
 };
 
@@ -82,6 +81,7 @@ struct vring_desc_extra_packed {
 	dma_addr_t addr;		/* Buffer DMA addr. */
 	u32 len;			/* Buffer length. */
 	u16 flags;			/* Descriptor flags. */
+	u16 next;			/* The next desc state in a list. */
 };
 
 struct vring_virtqueue {
@@ -1061,7 +1061,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 				1 << VRING_PACKED_DESC_F_USED;
 	}
 	vq->packed.next_avail_idx = n;
-	vq->free_head = vq->packed.desc_state[id].next;
+	vq->free_head = vq->packed.desc_extra[id].next;
 
 	/* Store token and indirect buffer state. */
 	vq->packed.desc_state[id].num = 1;
@@ -1169,7 +1169,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 					le16_to_cpu(flags);
 			}
 			prev = curr;
-			curr = vq->packed.desc_state[curr].next;
+			curr = vq->packed.desc_extra[curr].next;
 
 			if ((unlikely(++i >= vq->packed.vring.num))) {
 				i = 0;
@@ -1290,7 +1290,7 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 	/* Clear data ptr. */
 	state->data = NULL;
 
-	vq->packed.desc_state[state->last].next = vq->free_head;
+	vq->packed.desc_extra[state->last].next = vq->free_head;
 	vq->free_head = id;
 	vq->vq.num_free += state->num;
 
@@ -1299,7 +1299,7 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		for (i = 0; i < state->num; i++) {
 			vring_unmap_state_packed(vq,
 				&vq->packed.desc_extra[curr]);
-			curr = vq->packed.desc_state[curr].next;
+			curr = vq->packed.desc_extra[curr].next;
 		}
 	}
 
@@ -1649,8 +1649,6 @@ static struct virtqueue *vring_create_virtqueue_packed(
 
 	/* Put everything in free lists. */
 	vq->free_head = 0;
-	for (i = 0; i < num-1; i++)
-		vq->packed.desc_state[i].next = i + 1;
 
 	vq->packed.desc_extra = kmalloc_array(num,
 			sizeof(struct vring_desc_extra_packed),
@@ -1661,6 +1659,9 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	memset(vq->packed.desc_extra, 0,
 		num * sizeof(struct vring_desc_extra_packed));
 
+	for (i = 0; i < num - 1; i++)
+		vq->packed.desc_extra[i].next = i + 1;
+
 	/* No callback?  Tell other side not to bother us. */
 	if (!callback) {
 		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
