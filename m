Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5A3361DAB
	for <virtualization@lists.linux.dev>; Sun,  9 Aug 2026 18:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786299701; cv=none; b=U3Bz5Oeuxv3bU0NpRFpsKssgB+0XbJPlgISjHajm0NxYLhKHSYcEhtgT3YQ7cw2u1v5pIG3fCwh5siWIo70UiLirp3oGm5jMV6VrSNGog3AVUqd1Zs+uJk6PmR6lJc+0gqYzJJMMIrKFT9sG0gppGmRcfMVCwSR4nUR3VyCijOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786299701; c=relaxed/simple;
	bh=DRAZsgOl1qqzf65YiDOTALAb6txnLdZU6YpHhbUgAyo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qmaoS6+dHaQ6DAjWq0c1pUTT4otdEOTht14SegpWpywqd7UbOQU1/4uwRH/pKrtXHWXx8vFH78qtirEMN/QwIcijr8OFMtltWlvN/NJD31XkfLO9EiLDMYefVtRm9kC0jAf4DZpQq4VkFOB/6p56a2yBE6ucHtEEK8tzhWFxX5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=eue8AQ6i; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="eue8AQ6i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1786299700; x=1817835700;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vzL6Syiexp2mLHc2NqdKms5lj+Y2ja6OvvHtC7EZF74=;
  b=eue8AQ6iXm1jCi8/hIqrxaK+K5ImnAM1C6YYKIVfiZHzJJe1jpyU/1sv
   y/lwQA+OLw51fZKfnsZ0anhXiBk83IWQ/QYq+TVouP5+YJyyMFz76SEYA
   Wbk1Ur/EY88Pddcml5+JPgA2EjKW7zGxanhs3taMeXVAzo/bTHWCtaBO7
   BWF8QySLJf1hAaSCayB7b9Fd2SyB0tFvNRl0fzGJYic7o7cKWjgxk1HNx
   P48zAW9du04PbKZcVs9I/IOD3TD4Y/NoNKRA+igytTTQ5nBFF40at1nLD
   yNq22B/Fr7hzm1xg4v76gY+JA/OTxM0cT+M8N6xJk6UrwD10e4F++zCoI
   A==;
X-CSE-ConnectionGUID: nja4c6HQQfC1CmUCia0OCQ==
X-CSE-MsgGUID: IXJovujMQG6d9o7eBMnL+A==
X-IronPort-AV: E=Sophos;i="6.25,214,1779148800"; 
   d="scan'208";a="25521012"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 18:21:39 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:26930]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.171:2525] with esmtp (Farcaster)
 id f61689f6-416b-4ee2-ace5-56cf2a8bcbb8; Sun, 9 Aug 2026 18:21:39 +0000 (UTC)
X-Farcaster-Flow-ID: f61689f6-416b-4ee2-ace5-56cf2a8bcbb8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 9 Aug 2026 18:21:39 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Sun, 9 Aug 2026 18:21:37 +0000
From: Alexander Graf <graf@amazon.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, Halil Pasic <pasic@linux.ibm.com>,
	<virtualization@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>, Stefan Hajnoczi
	<stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH 10/12] virtio_ring: report a bounded pool's exhaustion as -ENOSPC
Date: Sun, 9 Aug 2026 18:20:08 +0000
Message-ID: <20260809182010.32931-11-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260809182010.32931-1-graf@amazon.com>
References: <20260809182010.32931-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA002.ant.amazon.com (10.13.139.17) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

A failed mapping reaches the caller as -ENOMEM from
virtqueue_add_split() and as -EIO from the two packed paths. -EIO is a
fatal I/O error that virtblk_fail_to_queue() has no case for, so a
packed-ring bounce that cannot be satisfied fails the I/O to the
filesystem, where the same failure on a split ring is only
back-pressure. -ENOMEM is little better: a map implementation's pool
belongs to one device and only that device's completions free it, so a
caller we tell -ENOMEM retries against a pool nothing else refills.

Report -ENOSPC from vring_map_errno() when the failure came from a map
implementation and num_free is not vring_num(), so the completion the
caller waits for provably exists. include/linux/blk_types.h states that
precondition for the BLK_STS_DEV_RESOURCE virtio_blk maps -ENOSPC to,
and reporting it with nothing outstanding would put nd_virtio into a
non-killable wait_event() that only a host completion wakes.
virtio_map_ops.mapping_error() is handed no virtqueue, so a map
implementation cannot draw the distinction for us.

VDUSE reports -ENOSPC for its own mapping failures as a result, and
drm/virtio's cursor queue, which waits for num_free to rise, retries in
a tight loop because a failed mapping does not move it. The kerneldoc of
virtqueue_add_sgs() said only a full queue reports -ENOSPC, so correct
that as well.

That way a bounce that could not be satisfied arrives at a block driver
as back-pressure it can retry on either ring layout.

Fixes: f7728002c1c7 ("virtio_ring: fix return code on DMA mapping fails")
Assisted-by: Kiro:claude-opus-5 checkpatch sparse
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 .../driver-api/virtio/virtio-dmb.rst          |  49 +++++++--
 drivers/virtio/virtio_ring.c                  | 100 ++++++++++++++----
 2 files changed, 118 insertions(+), 31 deletions(-)

diff --git a/Documentation/driver-api/virtio/virtio-dmb.rst b/Documentation/driver-api/virtio/virtio-dmb.rst
index 5975948165c9..4cd23e25901f 100644
--- a/Documentation/driver-api/virtio/virtio-dmb.rst
+++ b/Documentation/driver-api/virtio/virtio-dmb.rst
@@ -444,14 +444,19 @@ queue with ``tx_fifo_errors``, ``tx_dropped`` and a rate-limited
 ``virtnet_open()`` every fill runs on whichever CPU brought the link up, so
 they all share one home area.  Areas give preference, never reservation.
 
-Second, a receive queue that cannot refill spends softirq time without
-making progress.  ``try_fill_recv()`` reports failure, ``virtnet_receive()``
-returns the full budget to force a repoll, and ``virtnet_poll()`` therefore
-never completes NAPI.  There is no delayed worker behind that: commit
+Second, a receive queue that holds no buffers and cannot refill spends
+softirq time without making progress.  ``try_fill_recv()`` reports failure
+for the ``-ENOMEM`` such a queue gets, ``virtnet_receive()`` returns the
+full budget to force a repoll, and ``virtnet_poll()`` therefore never
+completes NAPI.  There is no delayed worker behind that: commit
 1e7b90aa7988 ("virtio-net: remove unused delayed refill worker") removed it
 deliberately, "since we switched to retry refilling receive buffer in NAPI
 poll instead of delayed worker".  The repoll always recovers once capacity
-is released, and it burns a CPU until then.
+is released, and it burns a CPU until then.  That is the only recovery a
+queue with nothing posted can have, because the device cannot signal a used
+buffer on it.  A queue that does hold buffers gets ``-ENOSPC`` instead,
+completes NAPI, and is woken by its own completions, so it stops cleanly;
+the errno section below has the whole rule.
 
 What the driver does
 ====================
@@ -530,12 +535,34 @@ suspend for the whole system.
 The region's length bounds how much virtqueue data can be in flight at
 once.  Running out of room is therefore an ordinary condition and not an
 error: a mapping fails and the driver applies the back-pressure it
-already has for a full queue.  The errno is whichever the ring already
-reports for a failed mapping, which is ``-ENOMEM`` from a split ring and
-from a packed indirect table, and ``-EIO`` from a packed ring using
-direct descriptors.  A driver must therefore treat any error from
-``virtqueue_add_*()`` as back-pressure, and must not treat a particular
-errno as the only indication of exhaustion.
+already has for a full queue.  Which errno the ring reports for it
+depends on whether the failing virtqueue has a chain outstanding:
+
+* ``-ENOSPC`` when it has.  This is the value a full ring already
+  reports, and it means what it means there: capacity that a completion
+  on this virtqueue will return.  A caller may stop the queue and wait,
+  because the completion it waits for provably exists.
+
+* ``-ENOMEM`` when it has not.  Nothing is outstanding to free capacity,
+  so there is no completion to wait for, and the caller must retry rather
+  than stop.  A shortage the caller cannot wait out is reported the same
+  way whatever its origin, which is also what a failed
+  ``dma_map_page()`` on an ordinary device reports.
+
+The distinction matters because the two demand opposite responses, and a
+caller that stops on the second never restarts.  ``virtio_blk`` already
+keys on exactly this: ``-ENOSPC`` stops the hardware queue, which
+``virtblk_done()`` restarts on any completion, while ``-ENOMEM`` leaves it
+running for the block layer to re-run after a delay.  For a virtio_net
+receive fill the split is the same one: a queue holding buffers stops
+cleanly and its own completions wake it, and a queue holding none keeps
+the NAPI repoll described above, which costs softirq time but recovers
+without needing an interrupt the device cannot send.
+
+A driver must still treat any error from ``virtqueue_add_*()`` as
+back-pressure and must not treat a particular errno as the only
+indication of exhaustion.  A mapping failure no longer produces
+``-EIO``, on any ring layout.
 
 Under this feature the virtqueue data path calls no DMA mapping function
 at all, so no bus address is ever passed to the device and the
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 9caa4f96204f..641ab07be931 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -337,6 +337,13 @@ static inline bool virtqueue_is_packed(const struct vring_virtqueue *vq)
 	       vq->layout == VQ_LAYOUT_PACKED_IN_ORDER;
 }
 
+/* Descriptors this virtqueue's ring holds, whatever its layout. */
+static inline u32 vring_num(const struct vring_virtqueue *vq)
+{
+	return virtqueue_is_packed(vq) ? vq->packed.vring.num :
+					 vq->split.vring.num;
+}
+
 static inline bool virtqueue_is_in_order(const struct vring_virtqueue *vq)
 {
 	return vq->layout == VQ_LAYOUT_SPLIT_IN_ORDER ||
@@ -491,6 +498,35 @@ static int vring_mapping_error(const struct vring_virtqueue *vq,
 		return dma_mapping_error(vring_dma_dev(vq), addr);
 }
 
+/*
+ * The errno a failed mapping reports to the caller.
+ *
+ * A map implementation owns a bounded pool that belongs to this device, so a
+ * failure to map into it while this virtqueue has a descriptor chain
+ * outstanding means capacity that this virtqueue's own completions will
+ * return: -ENOSPC, the value a full ring reports, which a caller that waits
+ * for a completion already answers correctly.  With nothing outstanding there is no
+ * such guarantee -- the pool may be held entirely by other virtqueues, or by
+ * structural allocations no completion frees -- and a shortage the caller
+ * cannot wait out is -ENOMEM whatever its origin.  That is the precondition
+ * include/linux/blk_types.h states for BLK_STS_DEV_RESOURCE, which
+ * virtio_blk maps -ENOSPC to.
+ *
+ * num_free != vring_num() is this tree's own definition of a non-empty ring;
+ * both teardown paths assert the equality as the definition of an empty one.
+ * All four virtqueue_add_*() paths decrement num_free after their mapping
+ * loop, below the last goto to their unmap_release label, so the value read
+ * here counts chains already published and not the one being built.  A
+ * refactor that moved either would break this silently.
+ */
+static int vring_map_errno(const struct vring_virtqueue *vq)
+{
+	if (vq->vq.vdev->map && vq->vq.num_free != vring_num(vq))
+		return -ENOSPC;
+
+	return -ENOMEM;
+}
+
 /* Map one sg entry. */
 static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist *sg,
 			    enum dma_data_direction direction, dma_addr_t *addr,
@@ -510,6 +546,12 @@ static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist
 		if (dev_WARN_ONCE(&vq->vq.vdev->dev,
 				  vring_mapping_error(vq, *addr),
 				  "premapped buffer holds no valid mapping\n"))
+			/*
+			 * Deliberately not vring_map_errno(): no capacity is
+			 * involved, the caller published an invalid address,
+			 * and reporting that as back-pressure would have the
+			 * caller wait for a completion that will not fix it.
+			 */
 			return -ENOMEM;
 
 		return 0;
@@ -538,7 +580,7 @@ static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist
 					 direction, attr);
 
 	if (vring_mapping_error(vq, *addr))
-		return -ENOMEM;
+		return vring_map_errno(vq);
 
 	return 0;
 }
@@ -677,6 +719,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 	unsigned int total_in_len = 0;
 	int head;
 	bool indirect;
+	int err;
 
 	START_USE(vq);
 
@@ -739,8 +782,9 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 			if (++sg_count != total_sg)
 				flags |= VRING_DESC_F_NEXT;
 
-			if (vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr, &len,
-					     premapped, attr))
+			err = vring_map_one_sg(vq, sg, DMA_TO_DEVICE, &addr,
+					       &len, premapped, attr);
+			if (err)
 				goto unmap_release;
 
 			/* Note that we trust indirect descriptor
@@ -759,8 +803,9 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 			if (++sg_count != total_sg)
 				flags |= VRING_DESC_F_NEXT;
 
-			if (vring_map_one_sg(vq, sg, DMA_FROM_DEVICE, &addr, &len,
-					     premapped, attr))
+			err = vring_map_one_sg(vq, sg, DMA_FROM_DEVICE, &addr,
+					       &len, premapped, attr);
+			if (err)
 				goto unmap_release;
 
 			/* Note that we trust indirect descriptor
@@ -777,8 +822,10 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 		dma_addr_t addr = vring_map_single(
 			vq, desc, total_sg * sizeof(struct vring_desc),
 			DMA_TO_DEVICE);
-		if (vring_mapping_error(vq, addr))
+		if (vring_mapping_error(vq, addr)) {
+			err = vring_map_errno(vq);
 			goto unmap_release;
+		}
 
 		virtqueue_add_desc_split(vq, vq->split.vring.desc,
 					 vq->split.desc_extra,
@@ -850,7 +897,7 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 		kfree(desc);
 
 	END_USE(vq);
-	return -ENOMEM;
+	return err;
 }
 
 static bool virtqueue_kick_prepare_split(struct vring_virtqueue *vq)
@@ -1665,6 +1712,17 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	kfree(desc);
 
 	END_USE(vq);
+
+	/*
+	 * Not vring_map_errno(), unlike the three add paths a driver can
+	 * reach.  This value never leaves virtio_ring: both callers treat
+	 * anything but -ENOMEM as final and return it, and use -ENOMEM as
+	 * the signal to retry the same chain with direct descriptors.  The
+	 * direct attempt maps the same scatterlist and reports the errno for
+	 * it, so a caller still learns that the pool is exhausted -- while a
+	 * chain that failed only because the indirect table did not fit is
+	 * still published, which is what it can be.
+	 */
 	return -ENOMEM;
 }
 
@@ -1739,9 +1797,10 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
 			dma_addr_t addr;
 
-			if (vring_map_one_sg(vq, sg, n < out_sgs ?
-					     DMA_TO_DEVICE : DMA_FROM_DEVICE,
-					     &addr, &len, premapped, attr))
+			err = vring_map_one_sg(vq, sg, n < out_sgs ?
+					       DMA_TO_DEVICE : DMA_FROM_DEVICE,
+					       &addr, &len, premapped, attr);
+			if (err)
 				goto unmap_release;
 
 			flags = cpu_to_le16(vq->packed.avail_used_flags |
@@ -1823,7 +1882,7 @@ static inline int virtqueue_add_packed(struct vring_virtqueue *vq,
 	}
 
 	END_USE(vq);
-	return -EIO;
+	return err;
 }
 
 static inline int virtqueue_add_packed_in_order(struct vring_virtqueue *vq,
@@ -1900,9 +1959,10 @@ static inline int virtqueue_add_packed_in_order(struct vring_virtqueue *vq,
 			if (n >= out_sgs)
 				flags |= cpu_to_le16(VRING_DESC_F_WRITE);
 
-			if (vring_map_one_sg(vq, sg, n < out_sgs ?
-					     DMA_TO_DEVICE : DMA_FROM_DEVICE,
-					     &addr, &len, premapped, attr))
+			err = vring_map_one_sg(vq, sg, n < out_sgs ?
+					       DMA_TO_DEVICE : DMA_FROM_DEVICE,
+					       &addr, &len, premapped, attr);
+			if (err)
 				goto unmap_release;
 
 			flags |= cpu_to_le16(vq->packed.avail_used_flags);
@@ -1979,7 +2039,7 @@ static inline int virtqueue_add_packed_in_order(struct vring_virtqueue *vq,
 	}
 
 	END_USE(vq);
-	return -EIO;
+	return err;
 }
 
 static bool virtqueue_kick_prepare_packed(struct vring_virtqueue *vq)
@@ -2868,9 +2928,10 @@ static inline int virtqueue_add(struct virtqueue *_vq,
  *
  * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
  *
- * NB: ENOSPC is a special code that is only returned on an attempt to add a
- * buffer to a full VQ. It indicates that some buffers are outstanding and that
- * the operation can be retried after some buffers have been used.
+ * NB: ENOSPC indicates that some buffers are outstanding and that the
+ * operation can be retried after some buffers have been used. A full VQ
+ * reports it, and so does a failure to map into a bounded pool a map
+ * implementation owns while this virtqueue has a chain outstanding.
  */
 int virtqueue_add_sgs(struct virtqueue *_vq,
 		      struct scatterlist *sgs[],
@@ -3623,8 +3684,7 @@ unsigned int virtqueue_get_vring_size(const struct virtqueue *_vq)
 
 	const struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return virtqueue_is_packed(vq) ? vq->packed.vring.num :
-				      vq->split.vring.num;
+	return vring_num(vq);
 }
 EXPORT_SYMBOL_GPL(virtqueue_get_vring_size);
 
