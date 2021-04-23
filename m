Return-Path: <SRS0=bReq=JU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB55C43460
	for <virtualization@archiver.kernel.org>; Fri, 23 Apr 2021 08:10:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 668BE61350
	for <virtualization@archiver.kernel.org>; Fri, 23 Apr 2021 08:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 668BE61350
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2506D405FD;
	Fri, 23 Apr 2021 08:10:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FDUnWQAWSrpO; Fri, 23 Apr 2021 08:10:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id C5CC2400C9;
	Fri, 23 Apr 2021 08:10:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B2C2C000F;
	Fri, 23 Apr 2021 08:10:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46B00C000F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 08:10:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 36A2B60DD4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 08:10:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iM1kw9_uhITZ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 08:10:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7B44C60DD6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 08:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619165438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=11TQ6i9OVoMbPFRqUnwUHbTRfc/PohdFDbCQomllfUE=;
 b=RjRPfXdEkEwzymEBYVzXrmJ6en3Twbg4PUbUSs1S5d/yxe811Zj82Jq3cXkXnU0ZH79ufx
 19OgsVERHMqB2N/eSQVIhg3f6Jgj4U3JLJ2gfRG5qqcc/bYNPIpkuadv9ElLpSLB3YhoPF
 V7ekLeTnhLAQZEfCyAHa6Cu2nrs+/5g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-qosNDfDJOgKmxNmXVdyOeg-1; Fri, 23 Apr 2021 04:10:36 -0400
X-MC-Unique: qosNDfDJOgKmxNmXVdyOeg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4006C87A826;
 Fri, 23 Apr 2021 08:10:35 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-225.pek2.redhat.com
 [10.72.13.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 722025C5E0;
 Fri, 23 Apr 2021 08:10:31 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [RFC PATCH V2 3/7] virtio-ring: factor out desc_extra allocation
Date: Fri, 23 Apr 2021 16:09:38 +0800
Message-Id: <20210423080942.2997-4-jasowang@redhat.com>
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

A helper is introduced for the logic of allocating the descriptor
extra data. This will be reused by split virtqueue.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index c25ea5776687..0cdd965dba58 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1550,6 +1550,25 @@ static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
 	return NULL;
 }
 
+static struct vring_desc_extra *vring_alloc_desc_extra(struct vring_virtqueue *vq,
+						       unsigned int num)
+{
+	struct vring_desc_extra *desc_extra;
+	unsigned int i;
+
+	desc_extra = kmalloc_array(num, sizeof(struct vring_desc_extra),
+				   GFP_KERNEL);
+	if (!desc_extra)
+		return NULL;
+
+	memset(desc_extra, 0, num * sizeof(struct vring_desc_extra));
+
+	for (i = 0; i < num - 1; i++)
+		desc_extra[i].next = i + 1;
+
+	return desc_extra;
+}
+
 static struct virtqueue *vring_create_virtqueue_packed(
 	unsigned int index,
 	unsigned int num,
@@ -1567,7 +1586,6 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	struct vring_packed_desc_event *driver, *device;
 	dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma_addr;
 	size_t ring_size_in_bytes, event_size_in_bytes;
-	unsigned int i;
 
 	ring_size_in_bytes = num * sizeof(struct vring_packed_desc);
 
@@ -1650,18 +1668,10 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	/* Put everything in free lists. */
 	vq->free_head = 0;
 
-	vq->packed.desc_extra = kmalloc_array(num,
-			sizeof(struct vring_desc_extra),
-			GFP_KERNEL);
+	vq->packed.desc_extra = vring_alloc_desc_extra(vq, num);
 	if (!vq->packed.desc_extra)
 		goto err_desc_extra;
 
-	memset(vq->packed.desc_extra, 0,
-		num * sizeof(struct vring_desc_extra));
-
-	for (i = 0; i < num - 1; i++)
-		vq->packed.desc_extra[i].next = i + 1;
-
 	/* No callback?  Tell other side not to bother us. */
 	if (!callback) {
 		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
