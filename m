Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F1D2D0614
	for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 21:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787087782; cv=none; b=SnyKhXrP2NwbtcczvFyPKxzi7668PhEl8T4t6uxO4YgxEPBXHf7Z9HTStbOivIYkau7b01PiadZBDDb3og/qLo78yd3IBHg21FE6hhHP8B4KONgDjTtkVczpdu9sn8KJLusQTKzMTg/cIBtKh30N5KK7nDecmVk99as4MSvMmuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787087782; c=relaxed/simple;
	bh=nXI1DQL0t1w9YKdxgR6/d+RYY5f27m/xujtlpz//zfg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cINkbdwYXn6yijW7UsFn0bZcSpyZx/1dM6VGxLsUqhxMLk+Zxylrs44WxCA3gtr0I5QTNOlYb0+qaskpx1jJuxbC3u4smYE5xJXhTgvrUaDM/qix3tvr31mZWOM4j7jVPdJ/RVGNIgrLWHVlIBp3GTWj8/jysytIisWOa7U89f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=BLHSQnuU; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="BLHSQnuU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1787087781; x=1818623781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ebLbt5/OpExcZ7S+wQ0+nkuyvvpj4myuZLqCB5rvLOU=;
  b=BLHSQnuURZJJex8JJG5PRQ4GvtYPRN7EBv4nvw4PRGuxb+8EnnbUGu2z
   TXoY48QiN1+SxXxC+q/V/nxb3puJ2UAgBYnWeqhcBWt+o5Q0az9OrsJ7t
   XTq52J9TENdEdg1mSopozE+HCajMr69eIdMjp2RxtNYcXaz4ykpZ9b2Z8
   AgFKm3p6nXFdDN+amfY6zaK9DVaDlGlzRsIJ5hAlcKpTlm+dcsKEUgvyA
   xws6sAQEoApWRwwwJrxg1VQuxC7+sl27XJgMQX+YEqr25se0U4E7TUtBR
   v/GPUGDo1uuK3vkWvNW4wvZuq4+CFvKsRkhsLimNXbAw8VSdg3bKWZ7Ha
   g==;
X-CSE-ConnectionGUID: yRDfFTiSTOmT35VqDJ8awA==
X-CSE-MsgGUID: M+x0bnysRkeN1VLIrnFpog==
X-IronPort-AV: E=Sophos;i="6.25,230,1779148800"; 
   d="scan'208";a="25815725"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 21:16:20 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:3886]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.125:2525] with esmtp (Farcaster)
 id b4e2ee42-581e-4b60-94f9-ce2c1d43a10c; Tue, 18 Aug 2026 21:16:20 +0000 (UTC)
X-Farcaster-Flow-ID: b4e2ee42-581e-4b60-94f9-ce2c1d43a10c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 18 Aug 2026 21:16:20 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Tue, 18 Aug 2026 21:16:18 +0000
From: Alexander Graf <graf@amazon.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>
CC: <nh-open-source@amazon.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	<virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Stefan
 Hajnoczi" <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 12/12] virtio: expose device memory buffer occupancy over debugfs
Date: Tue, 18 Aug 2026 21:14:25 +0000
Message-ID: <20260818211425.91009-13-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260818211425.91009-1-graf@amazon.com>
References: <20260818211425.91009-1-graf@amazon.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB004.ant.amazon.com (10.13.138.91) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

A driver allocates from a pool bounded by the region a Device Memory
Buffer device reports, so running out of room in it is routine:
vring_map_errno() reports the shortage as the -ENOSPC a full queue
reports, and the driver retries and carries on. The allocator must not
log that at any level a working device prints, or an undersized region
turns into a log flood. That leaves an operator nothing but unexplained
throughput loss to go on.

swiotlb can afford dev_warn_ratelimited() because exhaustion there is a
misconfiguration, and it exports io_tlb_used and io_tlb_used_hiwater
through debugfs, which a log line cannot do for a sampled quantity.
Follow it, plus one file swiotlb has no need for:

  dmb/pages              pages the allocator can hand out
  dmb/used_pages         pages allocated now
  dmb/used_pages_hiwater the largest used_pages has been
  dmb/alloc_failed       buffer mappings the pool had no room for

used_pages comes from the allocator's own free count, so no counter is
maintained alongside it and no read can report a torn total. Writing 0 to
used_pages_hiwater restarts the measurement from the occupancy now, so a
peak never reads below the used_pages read alongside it.

used_pages_hiwater is the number to size a region against, because a
burst that fills the pool between two samples of used_pages leaves no
other trace.

Assisted-by: Kiro:claude-opus-5 checkpatch sparse
Signed-off-by: Alexander Graf <graf@amazon.com>
---

  - Rework description

---
 drivers/virtio/virtio_dmb.c | 163 +++++++++++++++++++++++++++++++++++-
 1 file changed, 162 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_dmb.c b/drivers/virtio/virtio_dmb.c
index 884f4017780f..01b7a3542828 100644
--- a/drivers/virtio/virtio_dmb.c
+++ b/drivers/virtio/virtio_dmb.c
@@ -20,6 +20,8 @@
  */
 
 #include <linux/align.h>
+#include <linux/atomic.h>
+#include <linux/debugfs.h>
 #include <linux/dma-mapping.h>
 #include <linux/export.h>
 #include <linux/genalloc.h>
@@ -83,6 +85,10 @@ struct virtio_dmb_alloc {
  * @base_va: kernel address the pool starts at, inside the mapping
  * @base_off: region address the pool starts at
  * @nslots: pool size in PAGE_SIZE pages
+ * @used_hiwater: the largest occupancy has been since the last reset through
+ *	debugfs, or since init, in pages; CONFIG_VIRTIO_DEBUG
+ * @alloc_failed: buffer mappings the pool had no room for; CONFIG_VIRTIO_DEBUG
+ * @debugfs_dir: directory holding this region's debugfs files
  * @shm_id: shared memory id the device reported for the region
  */
 struct virtio_dmb {
@@ -98,6 +104,11 @@ struct virtio_dmb {
 	void			*base_va;
 	u64			 base_off;
 	unsigned int		 nslots;
+#ifdef CONFIG_VIRTIO_DEBUG
+	atomic_long_t		 used_hiwater;
+	atomic_long_t		 alloc_failed;
+#endif
+	struct dentry		*debugfs_dir;
 	u16			 shm_id;
 };
 
@@ -111,6 +122,52 @@ static size_t virtio_dmb_pool_size(const struct virtio_dmb *dmb)
 	return (size_t)dmb->nslots << PAGE_SHIFT;
 }
 
+#ifdef CONFIG_VIRTIO_DEBUG
+
+/*
+ * Pages allocated now.  gen_pool_avail() sums its chunks' free counts under
+ * RCU, so this needs no counter of its own and no lock, and it is exact
+ * between two claims rather than approximate.
+ */
+static unsigned long virtio_dmb_used(struct virtio_dmb *dmb)
+{
+	return (gen_pool_size(dmb->pool) - gen_pool_avail(dmb->pool))
+		>> PAGE_SHIFT;
+}
+
+/*
+ * Raise the high-water mark to the occupancy a claim has just established.
+ * Two racing claims each observe a real total and the larger wins, so the
+ * figure is a occupancy the pool genuinely held rather than a sum of readings
+ * taken at different moments.
+ */
+static void virtio_dmb_note_used(struct virtio_dmb *dmb)
+{
+	long old = atomic_long_read(&dmb->used_hiwater);
+	long now = virtio_dmb_used(dmb);
+
+	while (now > old &&
+	       !atomic_long_try_cmpxchg(&dmb->used_hiwater, &old, now))
+		;
+}
+
+static void virtio_dmb_inc_alloc_failed(struct virtio_dmb *dmb)
+{
+	atomic_long_inc(&dmb->alloc_failed);
+}
+
+#else /* !CONFIG_VIRTIO_DEBUG */
+
+static void virtio_dmb_note_used(struct virtio_dmb *dmb)
+{
+}
+
+static void virtio_dmb_inc_alloc_failed(struct virtio_dmb *dmb)
+{
+}
+
+#endif /* CONFIG_VIRTIO_DEBUG */
+
 /* Handle the driver publishes for the allocation starting at pool page @slot. */
 static dma_addr_t virtio_dmb_handle(const struct virtio_dmb *dmb,
 				    unsigned int slot)
@@ -178,6 +235,8 @@ static void *virtio_dmb_claim(struct virtio_dmb *dmb, size_t len,
 	rec->len = len;
 	rec->src = src;
 
+	virtio_dmb_note_used(dmb);
+
 	*out = rec;
 	return (void *)va;
 }
@@ -371,8 +430,22 @@ static dma_addr_t virtio_dmb_op_map_page(union virtio_map map,
 		return DMA_MAPPING_ERROR;
 
 	va = virtio_dmb_claim(dmb, size, src, &slot, &rec);
-	if (!va)
+	if (!va) {
+		/*
+		 * Counted here and not in virtio_dmb_claim(), which alloc()
+		 * reaches as well.  A virtqueue area that does not fit is a
+		 * step of vring_alloc_queue_split()'s search for a size that
+		 * does, so counting it would have a correctly sized region boot
+		 * with a failure for every attempt but the last, in the one
+		 * file whose purpose is to answer whether the region is too
+		 * small for the traffic.  A request over the per-mapping cap is
+		 * not counted either: the cap is what max_mapping_size()
+		 * advertises, so exceeding it is a caller bug rather than a
+		 * property of the region.
+		 */
+		virtio_dmb_inc_alloc_failed(dmb);
 		return DMA_MAPPING_ERROR;
+	}
 
 	/*
 	 * Copy in whatever the direction is, and without honouring
@@ -448,6 +521,91 @@ static const struct virtio_map_ops virtio_dmb_map_ops = {
 	.max_mapping_size	= virtio_dmb_op_max_mapping_size,
 };
 
+#ifdef CONFIG_VIRTIO_DEBUG
+
+static int virtio_dmb_used_get(void *data, u64 *val)
+{
+	struct virtio_dmb *dmb = data;
+
+	*val = virtio_dmb_used(dmb);
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(virtio_dmb_used_fops, virtio_dmb_used_get, NULL,
+			 "%llu\n");
+
+static int virtio_dmb_hiwater_get(void *data, u64 *val)
+{
+	struct virtio_dmb *dmb = data;
+
+	*val = atomic_long_read(&dmb->used_hiwater);
+
+	return 0;
+}
+
+/*
+ * Restart the measurement from the occupancy now, so that a peak never reads
+ * below the used_pages read alongside it.
+ */
+static int virtio_dmb_hiwater_set(void *data, u64 val)
+{
+	struct virtio_dmb *dmb = data;
+
+	if (val)
+		return -EINVAL;
+
+	atomic_long_set(&dmb->used_hiwater, virtio_dmb_used(dmb));
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(virtio_dmb_hiwater_fops, virtio_dmb_hiwater_get,
+			 virtio_dmb_hiwater_set, "%llu\n");
+
+static int virtio_dmb_alloc_failed_get(void *data, u64 *val)
+{
+	struct virtio_dmb *dmb = data;
+
+	*val = atomic_long_read(&dmb->alloc_failed);
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(virtio_dmb_alloc_failed_fops,
+			 virtio_dmb_alloc_failed_get, NULL, "%llu\n");
+
+static void virtio_dmb_debugfs_init(struct virtio_dmb *dmb)
+{
+	struct dentry *dir;
+
+	dir = debugfs_create_dir("dmb", dmb->vdev->debugfs_dir);
+	dmb->debugfs_dir = dir;
+
+	debugfs_create_u32("pages", 0400, dir, &dmb->nslots);
+	debugfs_create_file("used_pages", 0400, dir, dmb,
+			    &virtio_dmb_used_fops);
+	debugfs_create_file("used_pages_hiwater", 0600, dir, dmb,
+			    &virtio_dmb_hiwater_fops);
+	debugfs_create_file("alloc_failed", 0400, dir, dmb,
+			    &virtio_dmb_alloc_failed_fops);
+}
+
+static void virtio_dmb_debugfs_exit(struct virtio_dmb *dmb)
+{
+	debugfs_remove_recursive(dmb->debugfs_dir);
+	dmb->debugfs_dir = NULL;
+}
+
+#else /* !CONFIG_VIRTIO_DEBUG */
+
+static void virtio_dmb_debugfs_init(struct virtio_dmb *dmb)
+{
+}
+
+static void virtio_dmb_debugfs_exit(struct virtio_dmb *dmb)
+{
+}
+
+#endif /* CONFIG_VIRTIO_DEBUG */
+
 /*
  * Whether the device still has virtqueues.  No caller here can race an adder,
  * because every path that reaches this runs under the device lock, but the
@@ -515,6 +673,7 @@ void virtio_dmb_destroy(struct virtio_device *vdev)
 	 * virtqueue, and the refusal above establishes that none is left, which
 	 * is also why the records are empty by now.
 	 */
+	virtio_dmb_debugfs_exit(dmb);
 	gen_pool_destroy(dmb->pool);
 	kvfree(dmb->allocs);
 	memunmap(dmb->map_va);
@@ -773,6 +932,8 @@ int virtio_dmb_init(struct virtio_device *vdev)
 	vdev->vmap.dmb = dmb;
 	vdev->map = &virtio_dmb_map_ops;
 
+	virtio_dmb_debugfs_init(dmb);
+
 	dev_info(&vdev->dev,
 		 "device memory buffer %u at 0x%016llx, %u usable pages\n",
 		 shm_id, region.addr, nslots);
