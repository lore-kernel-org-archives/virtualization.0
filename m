Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793069803;
	b=ATXX0Hnr1KHcGPvLtgnbei3UhSLnkI3OezMU63clGlDdWDCp90D68fxKdt0BuG+ExiSx
	 m/588WUFrLi/QlbuoEZondki73nwuS2TZdTtcoCFe+2zGNP+O/bF5/yaZRJzI9LTnA6sa
	 7mZTAux9l2ZZLfUG7Fy2xSqXpV8B7DXIny9944TPjEyjyh8QwNuL8J6OCBjJuex1XS2Qt
	 pkcht+c1oICpl4Q7/pHb6kUt8r/GZKDrIf1HOYI68pHnc8gHq4DSnT0AOquaGyVeD5JoD
	 HVK2O6M5lLJt/1pr/bAcNdl969P3sxVmPA5XW+AJ+2c9ITJLrhPA5w8OJuDAshJouYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793069803;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=GOMxiaMp4kiAv1sy1QvOMscX3P97g6hNx07NHuZ9MZc=;
	b=VQ1S/ljKtxdxQU3kFtdKN7sKLZnTQ5H90jKqr8FTSHbUahNMEgkHzUmiz9lA/E8nYG9k
	 08avxF+AbEqDw30KvUhWynW9gFyKkFVQlgubcymmA5mUXbL7MDEs57oVFDSCxlQSbwQNt
	 dCF57j6JYlKuO5X+osMdqm2dI7mtLhKMwl9K26bVNIlKs2rwzEZpHeTJtOSWKRPSZ5+fF
	 cLFXvAPH4f/Ltrwp4P9EJFXGl3xhbfQ1nIysMaHO/6rSSMMaEFfG6pPhLL+w3YBOxlaGO
	 oAZ8O2G4gOtlvwIb6eTRV55+nkmELyNzpdBQEyuIuKBlPiTYGAGL8WvolBvqX7ozlEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=s3a4w0zo;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB34606A325
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 02:56:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EB34606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kevinloughlin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=s3a4w0zo
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-5587351d419so3043216b6e.1
        for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 19:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793069801; x=1793674601; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GOMxiaMp4kiAv1sy1QvOMscX3P97g6hNx07NHuZ9MZc=;
        b=s3a4w0zoVijGGhjXEskJMhY9tzqmZcSThZ/a1MXUVv06LoLuF908Yj115raUJq6SBy
         MKszJtGpUskOthii+b4rSYzC9IKehrt4jLBYYkJ7v7s0rPy/iQUDLSTyS5we4bp6Wtws
         qcj/CNIoppW941mpsJiOK3K0wkA9AyZNYl0KUYwgTiZ31hhCu6H27sY0d1nY/YweI2od
         dEXp+5F/5GQNTpZGjFKVTL+lxZ0nPpC/oz6AC4FHWuC+nGD81fL3CfM/bTcGk33+L+aT
         EggJDw7dOaOk4GkkJFnDrEHbsH1tbHI4bUV2Eu8Ssw7VfiZg098TM9h4+pgfNjh0cc2O
         NOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793069801; x=1793674601;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GOMxiaMp4kiAv1sy1QvOMscX3P97g6hNx07NHuZ9MZc=;
        b=0Kigd0HU8APL0QFZKCsL6PkSkODsooHpAR/zxRxcuKBtQveU7iz5iU6QD9CANUIYCZ
         xw2F448Ih3z9KHSH64YaCK/rSrCw2JvFClQmb58gVzxdD05y0z5r5qCWetH/7ayQpsaf
         Lfep5xa49SpFR8Lx2o4r3TFUsisHieVMeC+qILNlnVPL8yujJNAdLfBaeRJ8xMM8E3xB
         X01BGBYe0NUqNZJ/W+bMJA5/W96TssO+d7AOl4YqUDGx32r+eHidHoU2Jh9/cj+aNd05
         As65XdCr5bp3fAZETZtw5arIHw/fB4TGdE2KgN5crTA5YWk3LVy3Gq2EKtNV3sRe1+0x
         8q9Q==
X-Gm-Message-State: AFq9FYJ/V6e3upSI5Ejp7W/GOY15+NTYGwCNfKTIQYI1M/D8HQsW1A4K
	9QID4DDJBRy0Ur+fDYCk0OpbQJE1nyThQlAHkeeDMuTaCa4jPTHMpOFLCZKDW4ly9MC4VAE3MjT
	Qv3sUlDubZRIzC+7GFSCt0ZJWJGujYQ81Kg==
X-Received: from jabhk1.prod.google.com ([2002:a05:6638:8081:b0:61a:c6d0:40f4])
 (user=kevinloughlin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:148c:b0:4f6:2ccb:c2a with SMTP id 5614622812f47-55c0039eb90mr5670563b6e.68.1793069800756;
 Mon, 26 Oct 2026 19:56:40 -0700 (PDT)
Date: Tue, 27 Oct 2026 02:56:04 +0000
In-Reply-To: <20261027025616.1632690-1-kevinloughlin@google.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261027025616.1632690-1-kevinloughlin@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027025616.1632690-2-kevinloughlin@google.com>
Subject: [PATCH 01/13] virtio_ring: support per-virtqueue DMA mapping ops
From: Kevin Loughlin <kevinloughlin@google.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@kernel.org>, Jason Wang <jasowangio@gmail.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Alexander Duyck <alexanderduyck@fb.com>
Cc: virtualization@lists.linux.dev, linux-coco@lists.linux.dev, 
	linux-efi@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Sidharth Telang <sidtelang@google.com>, Punit Salian <psalian@google.com>, 
	Peter Gonda <pgonda@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Jacky Li <jackyli@google.com>, Steve Rutherford <srutherford@google.com>, 
	David Skidmore <davidskidmore@google.com>, Kevin Loughlin <kevinloughlin@google.com>
Content-Type: text/plain; charset="UTF-8"

Allow individual virtqueues to override the device-wide DMA mapping
operations via virtqueue_set_map_ops(). When custom per-virtqueue
mapping operations are configured, vring_map_one_sg(), vring_unmap_one(),
vring_mapping_error(), and the DMA sync helpers dispatch through
vq->map_ops instead of the parent virtio_device DMA API path.

Replace vring_map_single() with vring_map_indirect() and
vring_unmap_indirect() using the device-level mapping path (vdev->map
or dma_map_page_attrs()) so that indirect descriptor tables continue to
be DMA-mapped for host VMM access even when a virtqueue overrides buffer
mapping via vq->map_ops.

Signed-off-by: Kevin Loughlin <kevinloughlin@google.com>
---
 drivers/virtio/virtio_ring.c | 136 ++++++++++++++++++++++++-----------
 include/linux/virtio.h       |   4 ++
 2 files changed, 98 insertions(+), 42 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index db678f5a80e0..9c6a1e9f0a0b 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -261,6 +261,7 @@ struct vring_virtqueue {
 	bool we_own_ring;
 
 	union virtio_map map;
+	const struct virtio_map_ops *map_ops;
 
 #ifdef DEBUG
 	/* They're supposed to lock for us. */
@@ -477,16 +478,32 @@ static struct device *vring_dma_dev(const struct vring_virtqueue *vq)
 	return vq->map.dma_dev;
 }
 
+static inline const struct virtio_map_ops *vring_get_map_ops(const struct vring_virtqueue *vq)
+{
+	if (vq->map_ops)
+		return vq->map_ops;
+	return vq->vq.vdev->map;
+}
+
+void virtqueue_set_map_ops(struct virtqueue *_vq,
+			   const struct virtio_map_ops *map_ops)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	vq->map_ops = map_ops;
+}
+EXPORT_SYMBOL_GPL(virtqueue_set_map_ops);
+
 static int vring_mapping_error(const struct vring_virtqueue *vq,
 			       dma_addr_t addr)
 {
-	struct virtio_device *vdev = vq->vq.vdev;
+	const struct virtio_map_ops *map_ops = vring_get_map_ops(vq);
 
 	if (!vq->use_map_api)
 		return 0;
 
-	if (vdev->map)
-		return vdev->map->mapping_error(vq->map, addr);
+	if (map_ops)
+		return map_ops->mapping_error(vq->map, addr);
 	else
 		return dma_mapping_error(vring_dma_dev(vq), addr);
 }
@@ -530,15 +547,45 @@ static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist
 	return 0;
 }
 
-static dma_addr_t vring_map_single(const struct vring_virtqueue *vq,
-				   void *cpu_addr, size_t size,
-				   enum dma_data_direction direction)
+static int vring_map_indirect(const struct vring_virtqueue *vq, void *cpu_addr,
+			      size_t size, dma_addr_t *addr)
 {
-	if (!vq->use_map_api)
-		return (dma_addr_t)virt_to_phys(cpu_addr);
+	struct virtio_device *vdev = vq->vq.vdev;
+
+	if (!vq->use_map_api) {
+		kmsan_handle_dma(virt_to_phys(cpu_addr), size, DMA_TO_DEVICE);
+		*addr = (dma_addr_t)virt_to_phys(cpu_addr);
+		return 0;
+	}
+
+	if (vdev->map) {
+		*addr = vdev->map->map_page(vq->map, virt_to_page(cpu_addr),
+					    offset_in_page(cpu_addr), size,
+					    DMA_TO_DEVICE, 0);
+		if (vdev->map->mapping_error(vq->map, *addr))
+			return -ENOMEM;
+		return 0;
+	}
+
+	*addr = dma_map_page_attrs(vring_dma_dev(vq), virt_to_page(cpu_addr),
+				   offset_in_page(cpu_addr), size,
+				   DMA_TO_DEVICE, 0);
+	if (dma_mapping_error(vring_dma_dev(vq), *addr))
+		return -ENOMEM;
 
-	return virtqueue_map_single_attrs(&vq->vq, cpu_addr,
-					  size, direction, 0);
+	return 0;
+}
+
+static void vring_unmap_indirect(const struct vring_virtqueue *vq,
+				 dma_addr_t addr, size_t size)
+{
+	struct virtio_device *vdev = vq->vq.vdev;
+
+	if (vdev->map)
+		vdev->map->unmap_page(vq->map, addr, size, DMA_TO_DEVICE, 0);
+	else
+		dma_unmap_page_attrs(vring_dma_dev(vq), addr, size,
+				     DMA_TO_DEVICE, 0);
 }
 
 static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
@@ -576,6 +623,8 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 	if (flags & VRING_DESC_F_INDIRECT) {
 		if (!vq->use_map_api)
 			goto out;
+		vring_unmap_indirect(vq, extra->addr, extra->len);
+		goto out;
 	} else if (!vring_need_unmap_buffer(vq, extra))
 		goto out;
 
@@ -761,10 +810,11 @@ static inline int virtqueue_add_split(struct vring_virtqueue *vq,
 
 	if (indirect) {
 		/* Now that the indirect table is filled in, map it. */
-		dma_addr_t addr = vring_map_single(
-			vq, desc, total_sg * sizeof(struct vring_desc),
-			DMA_TO_DEVICE);
-		if (vring_mapping_error(vq, addr))
+		dma_addr_t addr;
+
+		if (vring_map_indirect(vq, desc,
+				       total_sg * sizeof(struct vring_desc),
+				       &addr))
 			goto unmap_release;
 
 		virtqueue_add_desc_split(vq, vq->split.vring.desc,
@@ -1370,6 +1420,7 @@ static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
 #endif
 	vq->map = map;
 	vq->use_map_api = vring_use_map_api(vdev);
+	vq->map_ops = NULL;
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!context;
@@ -1488,6 +1539,8 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 	if (flags & VRING_DESC_F_INDIRECT) {
 		if (!vq->use_map_api)
 			return;
+		vring_unmap_indirect(vq, extra->addr, extra->len);
+		return;
 	} else if (!vring_need_unmap_buffer(vq, extra))
 		return;
 
@@ -1585,10 +1638,9 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	}
 
 	/* Now that the indirect table is filled in, map it. */
-	addr = vring_map_single(vq, desc,
-			total_sg * sizeof(struct vring_packed_desc),
-			DMA_TO_DEVICE);
-	if (vring_mapping_error(vq, addr))
+	if (vring_map_indirect(vq, desc,
+			       total_sg * sizeof(struct vring_packed_desc),
+			       &addr))
 		goto unmap_release;
 
 	vq->packed.vring.desc[head].addr = cpu_to_le64(addr);
@@ -2620,6 +2672,7 @@ static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
 #endif
 	vq->map = map;
 	vq->use_map_api = vring_use_map_api(vdev);
+	vq->map_ops = NULL;
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!context;
@@ -3064,7 +3117,7 @@ struct device *virtqueue_dma_dev(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	if (vq->use_map_api && !_vq->vdev->map)
+	if (vq->use_map_api && !vring_get_map_ops(vq))
 		return vq->map.dma_dev;
 	else
 		return NULL;
@@ -3809,18 +3862,17 @@ EXPORT_SYMBOL_GPL(virtqueue_map_free_coherent);
  */
 dma_addr_t virtqueue_map_page_attrs(const struct virtqueue *_vq,
 				    struct page *page,
-				    unsigned long offset,
-				    size_t size,
+				    unsigned long offset, size_t size,
 				    enum dma_data_direction dir,
 				    unsigned long attrs)
 {
 	const struct vring_virtqueue *vq = to_vvq(_vq);
-	struct virtio_device *vdev = _vq->vdev;
+	const struct virtio_map_ops *map_ops = vring_get_map_ops(vq);
 
-	if (vdev->map)
-		return vdev->map->map_page(vq->map,
-					   page, offset, size,
-					   dir, attrs);
+	if (map_ops)
+		return map_ops->map_page(vq->map,
+					 page, offset, size,
+					 dir, attrs);
 
 	return dma_map_page_attrs(vring_dma_dev(vq),
 				  page, offset, size,
@@ -3842,11 +3894,11 @@ void virtqueue_unmap_page_attrs(const struct virtqueue *_vq,
 				unsigned long attrs)
 {
 	const struct vring_virtqueue *vq = to_vvq(_vq);
-	struct virtio_device *vdev = _vq->vdev;
+	const struct virtio_map_ops *map_ops = vring_get_map_ops(vq);
 
-	if (vdev->map)
-		vdev->map->unmap_page(vq->map,
-				      map_handle, size, dir, attrs);
+	if (map_ops)
+		map_ops->unmap_page(vq->map,
+				    map_handle, size, dir, attrs);
 	else
 		dma_unmap_page_attrs(vring_dma_dev(vq), map_handle,
 				     size, dir, attrs);
@@ -3941,13 +3993,13 @@ EXPORT_SYMBOL_GPL(virtqueue_map_mapping_error);
 bool virtqueue_map_need_sync(const struct virtqueue *_vq, dma_addr_t addr)
 {
 	const struct vring_virtqueue *vq = to_vvq(_vq);
-	struct virtio_device *vdev = _vq->vdev;
+	const struct virtio_map_ops *map_ops = vring_get_map_ops(vq);
 
 	if (!vq->use_map_api)
 		return false;
 
-	if (vdev->map)
-		return vdev->map->need_sync(vq->map, addr);
+	if (map_ops)
+		return map_ops->need_sync(vq->map, addr);
 	else
 		return dma_need_sync(vring_dma_dev(vq), addr);
 }
@@ -3971,14 +4023,14 @@ void virtqueue_map_sync_single_range_for_cpu(const struct virtqueue *_vq,
 					     enum dma_data_direction dir)
 {
 	const struct vring_virtqueue *vq = to_vvq(_vq);
-	struct virtio_device *vdev = _vq->vdev;
+	const struct virtio_map_ops *map_ops = vring_get_map_ops(vq);
 
 	if (!vq->use_map_api)
 		return;
 
-	if (vdev->map)
-		vdev->map->sync_single_for_cpu(vq->map,
-					       addr + offset, size, dir);
+	if (map_ops)
+		map_ops->sync_single_for_cpu(vq->map,
+					     addr + offset, size, dir);
 	else
 		dma_sync_single_range_for_cpu(vring_dma_dev(vq),
 					      addr, offset, size, dir);
@@ -4002,15 +4054,15 @@ void virtqueue_map_sync_single_range_for_device(const struct virtqueue *_vq,
 						enum dma_data_direction dir)
 {
 	const struct vring_virtqueue *vq = to_vvq(_vq);
-	struct virtio_device *vdev = _vq->vdev;
+	const struct virtio_map_ops *map_ops = vring_get_map_ops(vq);
 
 	if (!vq->use_map_api)
 		return;
 
-	if (vdev->map)
-		vdev->map->sync_single_for_device(vq->map,
-						  addr + offset,
-						  size, dir);
+	if (map_ops)
+		map_ops->sync_single_for_device(vq->map,
+						addr + offset,
+						size, dir);
 	else
 		dma_sync_single_range_for_device(vring_dma_dev(vq), addr,
 						 offset, size, dir);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index f923e42cfd01..20fe333d6778 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -44,6 +44,7 @@ struct virtqueue {
 };
 
 struct vduse_vq_group;
+struct virtio_map_ops;
 
 union virtio_map {
 	/* Device that performs DMA */
@@ -294,6 +295,9 @@ void virtqueue_map_free_coherent(struct virtio_device *vdev,
 				 size_t size, void *vaddr,
 				 dma_addr_t dma_handle);
 
+void virtqueue_set_map_ops(struct virtqueue *_vq,
+			   const struct virtio_map_ops *map_ops);
+
 dma_addr_t virtqueue_map_page_attrs(const struct virtqueue *_vq,
 				    struct page *page,
 				    unsigned long offset,
-- 
2.56.0.307.g5fe7bd680c-goog

