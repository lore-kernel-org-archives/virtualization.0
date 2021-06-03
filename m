Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BF2C47093
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 00:41:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BD8C61369
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 00:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD8C61369
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94D684053E;
	Thu,  3 Jun 2021 00:41:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DyWIpjki8ixM; Thu,  3 Jun 2021 00:41:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id D33AD40534;
	Thu,  3 Jun 2021 00:41:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E85CEC002A;
	Thu,  3 Jun 2021 00:41:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7BE1C0001;
 Thu,  3 Jun 2021 00:41:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E07CA60908;
 Thu,  3 Jun 2021 00:41:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hjdO4wVF6z56; Thu,  3 Jun 2021 00:41:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EB4F660692;
 Thu,  3 Jun 2021 00:41:46 +0000 (UTC)
IronPort-SDR: +UaBi2DOntGJ7ujVVaBeKQ9iI5/HqoEM6awzMfQady6+GxelfK/GELZryIvVL25w9MId3Jxxhg
 Va14MHETdPjw==
X-IronPort-AV: E=McAfee;i="6200,9189,10003"; a="191281567"
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="191281567"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2021 17:41:44 -0700
IronPort-SDR: K3BTi3HzghCvT8rf2so/+o1DTXjTr/YZ8EifpkHLF7rTqjM21bTBu7PubLY7Qg1oYQ1TyA0fx7
 +zxFPR2YbE2g==
X-IronPort-AV: E=Sophos;i="5.83,244,1616482800"; d="scan'208";a="549686676"
Received: from tassilo.jf.intel.com ([10.54.74.11])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2021 17:41:44 -0700
From: Andi Kleen <ak@linux.intel.com>
To: mst@redhat.com
Subject: [PATCH v1 2/8] virtio: Add boundary checks to virtio ring
Date: Wed,  2 Jun 2021 17:41:27 -0700
Message-Id: <20210603004133.4079390-3-ak@linux.intel.com>
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

In protected guest mode we don't trust the host.

This means we need to make sure the host cannot subvert us through
virtio communication. In general it can corrupt our virtio data
and cause a DOS, but it should not be able to access any data
that is not explicitely under IO.

Also boundary checking so that the free list (which is accessible
to the host) cannot point outside the virtio ring. Note it could
still contain loops or similar, but these should only cause an DOS,
not a memory corruption or leak.

When we detect any out of bounds descriptor trigger an IO error.
We also use a WARN() (in case it was a software bug instead of
an attack). This implies that a malicious host can flood
the guest kernel log, but that's only a DOS and acceptable
in the threat model.

This patch only hardens the initial consumption of the free list,
the freeing comes later.

Any of these errors can cause DMA memory leaks, but there is nothing
we can do about that and that would be just a DOS.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 drivers/virtio/virtio_ring.c | 46 ++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index f35629fa47b1..d37ff5a0ff58 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -413,6 +413,15 @@ static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
 	return desc;
 }
 
+/* assumes no indirect mode */
+static inline bool inside_split_ring(struct vring_virtqueue *vq,
+				     unsigned index)
+{
+	return !WARN(index >= vq->split.vring.num,
+		    "desc index %u out of bounds (%u)\n",
+		    index, vq->split.vring.num);
+}
+
 static inline int virtqueue_add_split(struct virtqueue *_vq,
 				      struct scatterlist *sgs[],
 				      unsigned int total_sg,
@@ -428,6 +437,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	unsigned int i, n, avail, descs_used, prev, err_idx;
 	int head;
 	bool indirect;
+	int io_err;
 
 	START_USE(vq);
 
@@ -481,7 +491,13 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 
 	for (n = 0; n < out_sgs; n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
-			dma_addr_t addr = vring_map_one_sg(vq, sg, DMA_TO_DEVICE);
+			dma_addr_t addr;
+
+			io_err = -EIO;
+			if (!inside_split_ring(vq, i))
+				goto unmap_release;
+			io_err = -ENOMEM;
+			addr = vring_map_one_sg(vq, sg, DMA_TO_DEVICE);
 			if (vring_mapping_error(vq, addr))
 				goto unmap_release;
 
@@ -494,7 +510,13 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	}
 	for (; n < (out_sgs + in_sgs); n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
-			dma_addr_t addr = vring_map_one_sg(vq, sg, DMA_FROM_DEVICE);
+			dma_addr_t addr;
+
+			io_err = -EIO;
+			if (!inside_split_ring(vq, i))
+				goto unmap_release;
+			io_err = -ENOMEM;
+			addr = vring_map_one_sg(vq, sg, DMA_FROM_DEVICE);
 			if (vring_mapping_error(vq, addr))
 				goto unmap_release;
 
@@ -513,6 +535,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		dma_addr_t addr = vring_map_single(
 			vq, desc, total_sg * sizeof(struct vring_desc),
 			DMA_TO_DEVICE);
+		io_err = -ENOMEM;
 		if (vring_mapping_error(vq, addr))
 			goto unmap_release;
 
@@ -528,6 +551,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	/* We're using some buffers from the free list. */
 	vq->vq.num_free -= descs_used;
 
+	io_err = -EIO;
+	if (!inside_split_ring(vq, head))
+		goto unmap_release;
+
 	/* Update free pointer */
 	if (indirect)
 		vq->free_head = virtio16_to_cpu(_vq->vdev,
@@ -545,6 +572,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	/* Put entry in available array (but don't update avail->idx until they
 	 * do sync). */
 	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
+
+	if (avail >= vq->split.vring.num)
+		goto unmap_release;
+
 	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
 
 	/* Descriptors and available array need to be set before we expose the
@@ -576,6 +607,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	for (n = 0; n < total_sg; n++) {
 		if (i == err_idx)
 			break;
+		if (!inside_split_ring(vq, i))
+			break;
 		vring_unmap_one_split(vq, &desc[i]);
 		i = virtio16_to_cpu(_vq->vdev, desc[i].next);
 	}
@@ -584,7 +617,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		kfree(desc);
 
 	END_USE(vq);
-	return -ENOMEM;
+	return io_err;
 }
 
 static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
@@ -1146,7 +1179,12 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	c = 0;
 	for (n = 0; n < out_sgs + in_sgs; n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
-			dma_addr_t addr = vring_map_one_sg(vq, sg, n < out_sgs ?
+			dma_addr_t addr;
+
+			if (curr >= vq->packed.vring.num)
+				goto unmap_release;
+
+			addr = vring_map_one_sg(vq, sg, n < out_sgs ?
 					DMA_TO_DEVICE : DMA_FROM_DEVICE);
 			if (vring_mapping_error(vq, addr))
 				goto unmap_release;
-- 
2.25.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
