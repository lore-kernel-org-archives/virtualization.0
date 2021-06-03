Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E246BC47097
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 00:41:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97687613EE
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 00:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97687613EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 73E7883D39;
	Thu,  3 Jun 2021 00:41:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4KMAtuuuEh7x; Thu,  3 Jun 2021 00:41:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19B3283D3E;
	Thu,  3 Jun 2021 00:41:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D955C0024;
	Thu,  3 Jun 2021 00:41:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2CC1BC0001;
 Thu,  3 Jun 2021 00:41:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0C3AC60692;
 Thu,  3 Jun 2021 00:41:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ko0ktDvZfz3N; Thu,  3 Jun 2021 00:41:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 420F560869;
 Thu,  3 Jun 2021 00:41:47 +0000 (UTC)
IronPort-SDR: yrG6blln6NFAzBhnr95gVNXa8OgVbBpXjOpuS9dbF5fX94lqjwEZyKkj3FCKxN3XYntIn+3vjf
 U7utElkoWXDg==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="191281574"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="191281574"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2021 17:41:44 -0700
IronPort-SDR: VL+aXnuQatkvpNkp3FGdeTErR4yDwQpYb+ewFaiTnnSMh3nd3KYOvi3JsGBefEMdCmu0HYu8xI
 bn1hvlf9segA==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="549686682"
Received: from tassilo.jf.intel.com ([10.54.74.11])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2021 17:41:44 -0700
From: Andi Kleen <ak@linux.intel.com>
To: mst@redhat.com
Subject: [PATCH v1 7/8] virtio: Abort IO when descriptor points outside forced
 swiotlb
Date: Wed,  2 Jun 2021 17:41:32 -0700
Message-Id: <20210603004133.4079390-8-ak@linux.intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210603004133.4079390-1-ak@linux.intel.com>
References: <20210603004133.4079390-1-ak@linux.intel.com>
MIME-Version: 1.0
Cc: sathyanarayanan.kuppuswamy@linux.intel.com, Andi Kleen <ak@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 jpoimboe@redhat.com, robin.murphy@arm.com, hch@lst.de,
 m.szyprowski@samsung.com
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

Now that we have a return value for unmapping DMA mappings that
are outside the forced swiotlb, use that to abort the IO operation.

This prevents the host from subverting a read to access some
data in the guest address space, which it might then get access somehow in
another IO operation. It can subvert reads to point to other
reads or other writes, but since it controls IO it can do
that anyways.

This is only done for the split code path, which is the only
one supported with confidential guests.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 drivers/virtio/virtio_ring.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 1e9aa1e95e1b..244a5b62d85c 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -365,29 +365,31 @@ static int vring_mapping_error(const struct vring_virtqueue *vq,
  * Split ring specific functions - *_split().
  */
 
-static void vring_unmap_one_split(const struct vring_virtqueue *vq,
+static int vring_unmap_one_split(const struct vring_virtqueue *vq,
 				  struct vring_desc *desc)
 {
 	u16 flags;
+	int ret;
 
 	if (!vq->use_dma_api)
-		return;
+		return 0;
 
 	flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
 
 	if (flags & VRING_DESC_F_INDIRECT) {
-		dma_unmap_single(vring_dma_dev(vq),
+		ret = dma_unmap_single(vring_dma_dev(vq),
 				 virtio64_to_cpu(vq->vq.vdev, desc->addr),
 				 virtio32_to_cpu(vq->vq.vdev, desc->len),
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	} else {
-		dma_unmap_page(vring_dma_dev(vq),
+		ret = dma_unmap_page(vring_dma_dev(vq),
 			       virtio64_to_cpu(vq->vq.vdev, desc->addr),
 			       virtio32_to_cpu(vq->vq.vdev, desc->len),
 			       (flags & VRING_DESC_F_WRITE) ?
 			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	}
+	return ret;
 }
 
 static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
@@ -609,6 +611,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			break;
 		if (!inside_split_ring(vq, i))
 			break;
+		/*
+		 * Ignore unmapping errors since
+		 * we're aborting anyways.
+		 */
 		vring_unmap_one_split(vq, &desc[i]);
 		i = virtio16_to_cpu(_vq->vdev, desc[i].next);
 	}
@@ -671,7 +677,10 @@ static int detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 	i = head;
 
 	while (vq->split.vring.desc[i].flags & nextflag) {
-		vring_unmap_one_split(vq, &vq->split.vring.desc[i]);
+		int ret;
+		ret = vring_unmap_one_split(vq, &vq->split.vring.desc[i]);
+		if (ret)
+			return ret;
 		i = virtio16_to_cpu(vq->vq.vdev, vq->split.vring.desc[i].next);
 		if (!inside_split_ring(vq, i))
 			return -EIO;
@@ -878,6 +887,7 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
 			continue;
 		/* detach_buf_split clears data, so grab it now. */
 		buf = vq->split.desc_state[i].data;
+		/* Ignore unmap errors because there is nothing to abort */
 		detach_buf_split(vq, i, NULL);
 		/* Don't need to check for error because nothing is returned */
 		vq->split.avail_idx_shadow--;
-- 
2.25.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
