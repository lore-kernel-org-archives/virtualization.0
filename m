Return-Path: <SRS0=bReq=JU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8739C433ED
	for <virtualization@archiver.kernel.org>; Fri, 23 Apr 2021 08:10:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 254A76128A
	for <virtualization@archiver.kernel.org>; Fri, 23 Apr 2021 08:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254A76128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD0CC84396;
	Fri, 23 Apr 2021 08:10:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bfHy-m0aCKjy; Fri, 23 Apr 2021 08:10:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C63983065;
	Fri, 23 Apr 2021 08:10:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59193C000F;
	Fri, 23 Apr 2021 08:10:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDC76C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 08:10:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ACC6A40FB1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 08:10:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U3cbEtXXZxgB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 08:10:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D201E41460
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 08:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619165435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Iy/gnaCvLxp4h+bVzLUI8j+eO2vvAPrkrWPiAFq8VY=;
 b=M/xjs7lmgFlulio5E5YGXih58vGfJP3L3Fw4a+TqhN2wn5cBQ8hKummyW7/W9asSWPPQAH
 xfZfhJKe16efDQfQR76GyUwQ3YoHKp0drHwrR50IxTi2slRCUsMGzoadrRN8CDnktyMldM
 VhBvzzmbWrK6FnuR4KGb7SsaQu3pUHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-kC-6-mg5MY6T21YRHKeAlA-1; Fri, 23 Apr 2021 04:10:32 -0400
X-MC-Unique: kC-6-mg5MY6T21YRHKeAlA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E10B918397A8;
 Fri, 23 Apr 2021 08:10:30 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-225.pek2.redhat.com
 [10.72.13.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A1455C5E0;
 Fri, 23 Apr 2021 08:10:26 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [RFC PATCH V2 2/7] virtio_ring: rename vring_desc_extra_packed
Date: Fri, 23 Apr 2021 16:09:37 +0800
Message-Id: <20210423080942.2997-3-jasowang@redhat.com>
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

Rename vring_desc_extra_packed to vring_desc_extra since the structure
are pretty generic which could be reused by split virtqueue as well.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index e1e9ed42e637..c25ea5776687 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -77,7 +77,7 @@ struct vring_desc_state_packed {
 	u16 last;			/* The last desc state in a list. */
 };
 
-struct vring_desc_extra_packed {
+struct vring_desc_extra {
 	dma_addr_t addr;		/* Buffer DMA addr. */
 	u32 len;			/* Buffer length. */
 	u16 flags;			/* Descriptor flags. */
@@ -166,7 +166,7 @@ struct vring_virtqueue {
 
 			/* Per-descriptor state. */
 			struct vring_desc_state_packed *desc_state;
-			struct vring_desc_extra_packed *desc_extra;
+			struct vring_desc_extra *desc_extra;
 
 			/* DMA address and size information */
 			dma_addr_t ring_dma_addr;
@@ -912,7 +912,7 @@ static struct virtqueue *vring_create_virtqueue_split(
  */
 
 static void vring_unmap_state_packed(const struct vring_virtqueue *vq,
-				     struct vring_desc_extra_packed *state)
+				     struct vring_desc_extra *state)
 {
 	u16 flags;
 
@@ -1651,13 +1651,13 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->free_head = 0;
 
 	vq->packed.desc_extra = kmalloc_array(num,
-			sizeof(struct vring_desc_extra_packed),
+			sizeof(struct vring_desc_extra),
 			GFP_KERNEL);
 	if (!vq->packed.desc_extra)
 		goto err_desc_extra;
 
 	memset(vq->packed.desc_extra, 0,
-		num * sizeof(struct vring_desc_extra_packed));
+		num * sizeof(struct vring_desc_extra));
 
 	for (i = 0; i < num - 1; i++)
 		vq->packed.desc_extra[i].next = i + 1;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
