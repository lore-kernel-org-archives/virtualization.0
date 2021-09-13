Return-Path: <SRS0=Do4E=OD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A0BC433F5
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 05:55:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5067860E76
	for <virtualization@archiver.kernel.org>; Mon, 13 Sep 2021 05:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5067860E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A68B81773;
	Mon, 13 Sep 2021 05:55:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 60jcK5FpkMl3; Mon, 13 Sep 2021 05:55:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9F92F80F1B;
	Mon, 13 Sep 2021 05:55:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68ADEC000F;
	Mon, 13 Sep 2021 05:55:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD985C000D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 05:55:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ACB9E60849
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 05:55:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QbU8rjEHTr-Q
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 05:55:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F10E7600C6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Sep 2021 05:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631512521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=59mlc5MAZl17Bwg0fnZF6E06RySu8Fbe/iP8dyny6Ao=;
 b=gqfGxGRXWnu7gpXgj/89W0/4BloCQvOh4StusNfWjHGsi/N1FWPt517wEudV7KeJeKTsg+
 cDub8Y5ies7KTJFBeLaUOy9VsWvHn9mgWZ9TmoNQDWQXHwMbT+44wUtm1588CKvUnq8O2H
 PkCIJ405uzxPccB8iQ/vyDcwwzoUG64=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-JyQ73bKlN4WvJZxjyD7e5Q-1; Mon, 13 Sep 2021 01:55:17 -0400
X-MC-Unique: JyQ73bKlN4WvJZxjyD7e5Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 251B88145E7;
 Mon, 13 Sep 2021 05:55:16 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-146.pek2.redhat.com
 [10.72.13.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 759F85C23A;
 Mon, 13 Sep 2021 05:55:02 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 9/9] virtio_ring: validate used buffer length
Date: Mon, 13 Sep 2021 13:53:53 +0800
Message-Id: <20210913055353.35219-10-jasowang@redhat.com>
In-Reply-To: <20210913055353.35219-1-jasowang@redhat.com>
References: <20210913055353.35219-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: konrad.wilk@oracle.com, f.hetzelt@tu-berlin.de,
 linux-kernel@vger.kernel.org, david.kaplan@amd.com,
 virtualization@lists.linux-foundation.org
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

This patch validate the used buffer length provided by the device
before trying to use it. This is done by record the in buffer length
in a new field in desc_state structure during virtqueue_add(), then we
can fail the virtqueue_get_buf() when we find the device is trying to
give us a used buffer length which is greater than the in buffer
length.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index d2ca0a7365f8..b8374a6144f3 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -69,6 +69,7 @@
 struct vring_desc_state_split {
 	void *data;			/* Data for callback. */
 	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
+	u64 buflen;			/* In buffer length */
 };
 
 struct vring_desc_state_packed {
@@ -76,6 +77,7 @@ struct vring_desc_state_packed {
 	struct vring_packed_desc *indir_desc; /* Indirect descriptor, if any. */
 	u16 num;			/* Descriptor list length. */
 	u16 last;			/* The last desc state in a list. */
+	u64 buflen;			/* In buffer length */
 };
 
 struct vring_desc_extra {
@@ -490,6 +492,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	unsigned int i, n, avail, descs_used, prev, err_idx;
 	int head;
 	bool indirect;
+	u64 buflen = 0;
 
 	START_USE(vq);
 
@@ -571,6 +574,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 						     VRING_DESC_F_NEXT |
 						     VRING_DESC_F_WRITE,
 						     indirect);
+			buflen += sg->length;
 		}
 	}
 	/* Last one doesn't continue. */
@@ -605,6 +609,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 
 	/* Store token and indirect buffer state. */
 	vq->split.desc_state[head].data = data;
+	vq->split.desc_state[head].buflen = buflen;
 	if (indirect)
 		vq->split.desc_state[head].indir_desc = desc;
 	else
@@ -784,6 +789,11 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 		BAD_RING(vq, "id %u is not a head!\n", i);
 		return NULL;
 	}
+	if (unlikely(*len > vq->split.desc_state[i].buflen)) {
+		BAD_RING(vq, "used len %d is larger than in buflen %lld\n",
+			*len, vq->split.desc_state[i].buflen);
+		return NULL;
+	}
 
 	/* detach_buf_split clears data, so grab it now. */
 	ret = vq->split.desc_state[i].data;
@@ -1062,6 +1072,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	unsigned int i, n, err_idx;
 	u16 head, id;
 	dma_addr_t addr;
+	u64 buflen = 0;
 
 	head = vq->packed.next_avail_idx;
 	desc = alloc_indirect_packed(total_sg, gfp);
@@ -1089,6 +1100,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 			desc[i].addr = cpu_to_le64(addr);
 			desc[i].len = cpu_to_le32(sg->length);
 			i++;
+			if (n >= out_sgs)
+				buflen += sg->length;
 		}
 	}
 
@@ -1141,6 +1154,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	vq->packed.desc_state[id].data = data;
 	vq->packed.desc_state[id].indir_desc = desc;
 	vq->packed.desc_state[id].last = id;
+	vq->packed.desc_state[id].buflen = buflen;
 
 	vq->num_added += 1;
 
@@ -1176,6 +1190,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	unsigned int i, n, c, descs_used, err_idx;
 	__le16 head_flags, flags;
 	u16 head, id, prev, curr, avail_used_flags;
+	u64 buflen = 0;
 
 	START_USE(vq);
 
@@ -1250,6 +1265,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 					1 << VRING_PACKED_DESC_F_AVAIL |
 					1 << VRING_PACKED_DESC_F_USED;
 			}
+			if (n >= out_sgs)
+				buflen += sg->length;
 		}
 	}
 
@@ -1268,6 +1285,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	vq->packed.desc_state[id].data = data;
 	vq->packed.desc_state[id].indir_desc = ctx;
 	vq->packed.desc_state[id].last = prev;
+	vq->packed.desc_state[id].buflen = buflen;
 
 	/*
 	 * A driver MUST NOT make the first descriptor in the list
@@ -1455,6 +1473,11 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 		BAD_RING(vq, "id %u is not a head!\n", id);
 		return NULL;
 	}
+	if (unlikely(*len > vq->packed.desc_state[id].buflen)) {
+		BAD_RING(vq, "used len %d is larger than in buflen %lld\n",
+			*len, vq->packed.desc_state[id].buflen);
+		return NULL;
+	}
 
 	/* detach_buf_packed clears data, so grab it now. */
 	ret = vq->packed.desc_state[id].data;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
