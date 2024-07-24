Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7904B1CAA1
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 08:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721811402; cv=none; b=qTqLQSW5o6vEzvitb6lkXQXeMc0Zrf7kDzY/7XJRj2m7jFPEaVYIggRqMpziuO2s+bJV2sbkkE2WLpKEvmsFytAi5ejhKkGV9Cl/if5krSBFKziroLqWWurPOxvkRFVwuN50Z0LzVmBD+zfaDElpplEUEMhUhl5H+MP9dRPbjhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721811402; c=relaxed/simple;
	bh=KbRyld5kphGdk9Kc/A3Mka37SzeNOz/OuVSJFtfQt/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s4uqt1DL0M916+owx5MDDn9vpF6bW4Omf2ALYbPH88t+PJxwAOSCDPpIG8jLKVrzgZ3YAkPbcnOtyLc4OGk3mMAXD1GjtYoarmPOEBE0I6s5A9hV7LU7dyxmZs23W+nCz2x1SpqzFrzbtkqdANFpB5Jjmd7YpQHQjkIBHF5bjCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJf+OfSK; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJf+OfSK"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6e7b121be30so1038354a12.1
        for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 01:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721811398; x=1722416198; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUrEZjb9G7+Q830xX0TPikCg4ExPCiIQgAr5dJwCAWU=;
        b=eJf+OfSK1xrXPlFQQrpZRKyoTG/MQMyRl61wQO10RrgU+dq5nsapOmCJ7LnEbBm9RI
         PWm4NOMTuAHXpXERTTkU2VmCnYmHTHVhu9LBfuJRHVR58cHruFz57VQmhrp7PPUYKMpt
         vvTzVq9Brg/J4G9iX62cN/J19Kz41rz0RcXq3LZRbU9hOfar1lbWkji1p7sk7rUWNeKQ
         KIod2u/WPEObB3ztsSbN1/zkzceyGPk5+6yYfZUfteHeG3gTtenJgPnWYty18imR+wMT
         Rrn/Kyi9S766VpvPvDLVyv1lOyuQolghwBoBSCU6FvJvgboeCqZTeFQGy+KN/mUk3y3i
         8jXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721811398; x=1722416198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUrEZjb9G7+Q830xX0TPikCg4ExPCiIQgAr5dJwCAWU=;
        b=h4Huu1iHgSX3S1F/620cpTgvFcTyhDPyZRcrG8gMjdQPFDTZbrYDg6D59DR/hlp3Vj
         ihw/UHBy4XaXHln/BiOpUig+VNFFMRWwvMOyrMVWjTvU9D4vjjC8yGn9BpMrLjHUE8x3
         z5s3xIaUWuU7F/tvpg9K+JQE62tii73WePrpmqohNpHMTgElf4dbWHPQBVXfJ2OQ6cqZ
         NrbTkOwIBrVmvg0pgSnIdNFT0rSvABV4iqgwoNDP7Fvto6vXdZX/vCDjfXP657x+Ix+8
         3msRicqTZV1zoKGLmlXb1sbl/Qf5ESK9uVewgjsRKf7ToMWaJVS2j+qcc6f42C3ZKXr6
         opqg==
X-Forwarded-Encrypted: i=1; AJvYcCVnixdZQPAwIG1XtUIOarWWn2TBy9FUYvwnVYMzKgLra59NSOMuxYnZrYK6DEKFb+8cPPDB9go3NIHVTDXu+enQ8TC0bX07hlVpZCI0RXI=
X-Gm-Message-State: AOJu0YyDlQ7gvpK+gQCXygUSlYbe11+vgpSQmOPniqGWp2FmRJ8tWKbW
	iZmtOGLZXUpPVGtEMrWRUtlv1seKvfw+6RIXScbjML5T4frgHOyP
X-Google-Smtp-Source: AGHT+IEi27u0zPJO5eKpN2zel9PeXYu2JaDrZcp2h2HWcoxQS2RqMQmr4u1moJTVCjth+Tf5EqtpoQ==
X-Received: by 2002:a05:6a21:6da9:b0:1c0:f2d9:a45a with SMTP id adf61e73a8af0-1c4618f84a4mr1880702637.1.1721811396985;
        Wed, 24 Jul 2024 01:56:36 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f31855fsm89021895ad.156.2024.07.24.01.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 01:56:36 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: 42.hyeyoo@gmail.com,
	cl@linux.com,
	hch@infradead.org,
	iamjoonsoo.kim@lge.com,
	lstoakes@gmail.com,
	mhocko@suse.com,
	penberg@kernel.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	urezki@gmail.com,
	v-songbaohua@oppo.com,
	vbabka@suse.cz,
	virtualization@lists.linux.dev,
	hailong.liu@oppo.com,
	torvalds@linux-foundation.org
Subject: [PATCH RFC 5/5] non-mm: discourage the usage of __GFP_NOFAIL and encourage GFP_NOFAIL
Date: Wed, 24 Jul 2024 20:55:44 +1200
Message-Id: <20240724085544.299090-6-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724085544.299090-1-21cnbao@gmail.com>
References: <20240724085544.299090-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

GFP_NOFAIL includes the meaning of block and direct reclamation, which
is essential for a true no-fail allocation. We are gradually starting
to enforce this block semantics to prevent the potential misuse of
__GFP_NOFAIL in atomic contexts in the future.

A typical example of incorrect usage is in VDPA, where GFP_ATOMIC
and __GFP_NOFAIL are used together.

[RFC]: This patch seems quite large; I don't mind splitting it into
multiple patches for different subsystems after patches 1 ~ 4 have
been applied.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 arch/powerpc/sysdev/xive/common.c                  |  2 +-
 drivers/gpu/drm/drm_modeset_lock.c                 |  2 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c             |  8 ++++----
 drivers/gpu/drm/virtio/virtgpu_vq.c                |  2 +-
 drivers/hv/vmbus_drv.c                             |  2 +-
 drivers/infiniband/hw/cxgb4/mem.c                  |  4 ++--
 drivers/md/dm-region-hash.c                        |  2 +-
 .../chelsio/inline_crypto/chtls/chtls_cm.c         |  6 +++---
 .../chelsio/inline_crypto/chtls/chtls_hw.c         |  2 +-
 drivers/target/iscsi/cxgbit/cxgbit_cm.c            |  2 +-
 drivers/tty/tty_ldisc.c                            |  2 +-
 drivers/vdpa/vdpa_user/iova_domain.c               |  4 ++--
 fs/bcachefs/btree_iter.c                           |  2 +-
 fs/bcachefs/fs-io-buffered.c                       |  2 +-
 fs/bcachefs/io_write.c                             |  2 +-
 fs/btrfs/extent_io.c                               |  8 ++++----
 fs/buffer.c                                        |  6 +++---
 fs/erofs/fscache.c                                 |  2 +-
 fs/erofs/zdata.c                                   | 10 +++++-----
 fs/ext4/extents.c                                  |  8 ++++----
 fs/ext4/extents_status.c                           |  4 ++--
 fs/ext4/mballoc.c                                  | 12 ++++++------
 fs/ext4/page-io.c                                  |  2 +-
 fs/f2fs/checkpoint.c                               |  2 +-
 fs/f2fs/data.c                                     |  4 ++--
 fs/f2fs/f2fs.h                                     |  2 +-
 fs/f2fs/node.c                                     |  2 +-
 fs/fuse/dev.c                                      |  2 +-
 fs/fuse/file.c                                     |  4 ++--
 fs/fuse/inode.c                                    |  4 ++--
 fs/fuse/virtio_fs.c                                |  4 ++--
 fs/gfs2/meta_io.c                                  |  2 +-
 fs/gfs2/rgrp.c                                     |  6 +++---
 fs/gfs2/trans.c                                    |  2 +-
 fs/iomap/buffered-io.c                             |  2 +-
 fs/jbd2/journal.c                                  |  4 ++--
 fs/jbd2/revoke.c                                   |  2 +-
 fs/jbd2/transaction.c                              |  6 +++---
 fs/notify/fanotify/fanotify.c                      |  2 +-
 fs/reiserfs/journal.c                              |  2 +-
 fs/udf/directory.c                                 |  2 +-
 fs/xfs/libxfs/xfs_alloc.c                          |  2 +-
 fs/xfs/libxfs/xfs_attr_leaf.c                      |  8 ++++----
 fs/xfs/libxfs/xfs_bmap.c                           |  2 +-
 fs/xfs/libxfs/xfs_btree.h                          |  2 +-
 fs/xfs/libxfs/xfs_btree_staging.c                  |  2 +-
 fs/xfs/libxfs/xfs_da_btree.c                       |  8 ++++----
 fs/xfs/libxfs/xfs_defer.c                          |  4 ++--
 fs/xfs/libxfs/xfs_dir2.c                           | 10 +++++-----
 fs/xfs/libxfs/xfs_dir2_block.c                     |  2 +-
 fs/xfs/libxfs/xfs_dir2_sf.c                        |  8 ++++----
 fs/xfs/libxfs/xfs_exchmaps.c                       |  4 ++--
 fs/xfs/libxfs/xfs_iext_tree.c                      |  4 ++--
 fs/xfs/libxfs/xfs_inode_fork.c                     | 14 +++++++-------
 fs/xfs/libxfs/xfs_refcount.c                       |  4 ++--
 fs/xfs/libxfs/xfs_rmap.c                           |  2 +-
 fs/xfs/xfs_attr_item.c                             |  8 ++++----
 fs/xfs/xfs_attr_list.c                             |  2 +-
 fs/xfs/xfs_bmap_item.c                             |  6 +++---
 fs/xfs/xfs_buf.c                                   |  8 ++++----
 fs/xfs/xfs_buf_item.c                              |  4 ++--
 fs/xfs/xfs_buf_item_recover.c                      |  2 +-
 fs/xfs/xfs_dquot.c                                 |  2 +-
 fs/xfs/xfs_exchmaps_item.c                         |  4 ++--
 fs/xfs/xfs_extent_busy.c                           |  2 +-
 fs/xfs/xfs_extfree_item.c                          | 10 +++++-----
 fs/xfs/xfs_icache.c                                |  2 +-
 fs/xfs/xfs_icreate_item.c                          |  2 +-
 fs/xfs/xfs_inode_item.c                            |  2 +-
 fs/xfs/xfs_inode_item_recover.c                    |  2 +-
 fs/xfs/xfs_iunlink_item.c                          |  2 +-
 fs/xfs/xfs_iwalk.c                                 |  2 +-
 fs/xfs/xfs_log.c                                   |  2 +-
 fs/xfs/xfs_log_cil.c                               |  2 +-
 fs/xfs/xfs_log_recover.c                           |  6 +++---
 fs/xfs/xfs_mount.c                                 |  2 +-
 fs/xfs/xfs_mru_cache.c                             |  4 ++--
 fs/xfs/xfs_qm.c                                    |  4 ++--
 fs/xfs/xfs_refcount_item.c                         |  8 ++++----
 fs/xfs/xfs_rmap_item.c                             |  8 ++++----
 fs/xfs/xfs_rtalloc.c                               |  2 +-
 fs/xfs/xfs_super.c                                 |  2 +-
 fs/xfs/xfs_trans.c                                 |  4 ++--
 fs/xfs/xfs_trans_dquot.c                           |  2 +-
 include/linux/buffer_head.h                        |  4 ++--
 kernel/resource.c                                  |  2 +-
 lib/list-test.c                                    |  8 ++++----
 lib/ref_tracker.c                                  |  2 +-
 lib/rhashtable.c                                   |  6 +++---
 lib/test_hmm.c                                     |  6 +++---
 net/ceph/osd_client.c                              |  2 +-
 net/ceph/osdmap.c                                  |  4 ++--
 net/core/sock.c                                    |  4 ++--
 net/ipv4/inet_connection_sock.c                    |  2 +-
 net/ipv4/tcp_output.c                              |  2 +-
 security/smack/smackfs.c                           |  2 +-
 96 files changed, 188 insertions(+), 188 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index fa01818c1972..29eaf8b84b52 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -1146,7 +1146,7 @@ static int __init xive_init_ipis(void)
 	if (!ipi_domain)
 		goto out_free_fwnode;
 
-	xive_ipis = kcalloc(nr_node_ids, sizeof(*xive_ipis), GFP_KERNEL | __GFP_NOFAIL);
+	xive_ipis = kcalloc(nr_node_ids, sizeof(*xive_ipis), GFP_KERNEL | GFP_NOFAIL);
 	if (!xive_ipis)
 		goto out_free_domain;
 
diff --git a/drivers/gpu/drm/drm_modeset_lock.c b/drivers/gpu/drm/drm_modeset_lock.c
index 7694b85e75e3..3564751aaff7 100644
--- a/drivers/gpu/drm/drm_modeset_lock.c
+++ b/drivers/gpu/drm/drm_modeset_lock.c
@@ -146,7 +146,7 @@ void drm_modeset_lock_all(struct drm_device *dev)
 	struct drm_modeset_acquire_ctx *ctx;
 	int ret;
 
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL | __GFP_NOFAIL);
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL | GFP_NOFAIL);
 	if (WARN_ON(!ctx))
 		return;
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 6719353e2e13..df799c190844 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -378,9 +378,9 @@ nouveau_dmem_evict_chunk(struct nouveau_dmem_chunk *chunk)
 	dma_addr_t *dma_addrs;
 	struct nouveau_fence *fence;
 
-	src_pfns = kvcalloc(npages, sizeof(*src_pfns), GFP_KERNEL | __GFP_NOFAIL);
-	dst_pfns = kvcalloc(npages, sizeof(*dst_pfns), GFP_KERNEL | __GFP_NOFAIL);
-	dma_addrs = kvcalloc(npages, sizeof(*dma_addrs), GFP_KERNEL | __GFP_NOFAIL);
+	src_pfns = kvcalloc(npages, sizeof(*src_pfns), GFP_KERNEL | GFP_NOFAIL);
+	dst_pfns = kvcalloc(npages, sizeof(*dst_pfns), GFP_KERNEL | GFP_NOFAIL);
+	dma_addrs = kvcalloc(npages, sizeof(*dma_addrs), GFP_KERNEL | GFP_NOFAIL);
 
 	migrate_device_range(src_pfns, chunk->pagemap.range.start >> PAGE_SHIFT,
 			npages);
@@ -394,7 +394,7 @@ nouveau_dmem_evict_chunk(struct nouveau_dmem_chunk *chunk)
 			 * is nothing sensible we can do if we can't copy the
 			 * data back.
 			 */
-			dpage = alloc_page(GFP_HIGHUSER | __GFP_NOFAIL);
+			dpage = alloc_page(GFP_HIGHUSER | GFP_NOFAIL);
 			dst_pfns[i] = migrate_pfn(page_to_pfn(dpage));
 			nouveau_dmem_copy_one(chunk->drm,
 					migrate_pfn_to_page(src_pfns[i]), dpage,
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 0d3d0d09f39b..95b844036925 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -93,7 +93,7 @@ virtio_gpu_get_vbuf(struct virtio_gpu_device *vgdev,
 {
 	struct virtio_gpu_vbuffer *vbuf;
 
-	vbuf = kmem_cache_zalloc(vgdev->vbufs, GFP_KERNEL | __GFP_NOFAIL);
+	vbuf = kmem_cache_zalloc(vgdev->vbufs, GFP_KERNEL | GFP_NOFAIL);
 
 	BUG_ON(size > MAX_INLINE_CMD_SIZE ||
 	       size < sizeof(struct virtio_gpu_ctrl_hdr));
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 12a707ab73f8..b2bb7dd117d7 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1170,7 +1170,7 @@ static void vmbus_force_channel_rescinded(struct vmbus_channel *channel)
 	 * otherwise the state of the hv_sock connections ends up in limbo.
 	 */
 	ctx = kzalloc(sizeof(*ctx) + sizeof(*rescind),
-		      GFP_KERNEL | __GFP_NOFAIL);
+		      GFP_KERNEL | GFP_NOFAIL);
 
 	/*
 	 * So far, these are not really used by Linux. Just set them to the
diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb4/mem.c
index a2c71a1d93d5..b9e7b902191a 100644
--- a/drivers/infiniband/hw/cxgb4/mem.c
+++ b/drivers/infiniband/hw/cxgb4/mem.c
@@ -75,7 +75,7 @@ static int _c4iw_write_mem_dma_aligned(struct c4iw_rdev *rdev, u32 addr,
 	wr_len = roundup(sizeof(*req) + sizeof(*sgl), 16);
 
 	if (!skb) {
-		skb = alloc_skb(wr_len, GFP_KERNEL | __GFP_NOFAIL);
+		skb = alloc_skb(wr_len, GFP_KERNEL | GFP_NOFAIL);
 		if (!skb)
 			return -ENOMEM;
 	}
@@ -135,7 +135,7 @@ static int _c4iw_write_mem_inline(struct c4iw_rdev *rdev, u32 addr, u32 len,
 				 16);
 
 		if (!skb) {
-			skb = alloc_skb(wr_len, GFP_KERNEL | __GFP_NOFAIL);
+			skb = alloc_skb(wr_len, GFP_KERNEL | GFP_NOFAIL);
 			if (!skb)
 				return -ENOMEM;
 		}
diff --git a/drivers/md/dm-region-hash.c b/drivers/md/dm-region-hash.c
index a4550975c27d..9a2b3f090c93 100644
--- a/drivers/md/dm-region-hash.c
+++ b/drivers/md/dm-region-hash.c
@@ -294,7 +294,7 @@ static struct dm_region *__rh_alloc(struct dm_region_hash *rh, region_t region)
 
 	nreg = mempool_alloc(&rh->region_pool, GFP_ATOMIC);
 	if (unlikely(!nreg))
-		nreg = kmalloc(sizeof(*nreg), GFP_NOIO | __GFP_NOFAIL);
+		nreg = kmalloc(sizeof(*nreg), GFP_NOIO | GFP_NOFAIL);
 
 	nreg->state = rh->log->type->in_sync(rh->log, region, 1) ?
 		      DM_RH_CLEAN : DM_RH_NOSYNC;
diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
index 6f6525983130..29a30b23b06c 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
@@ -215,7 +215,7 @@ static struct sk_buff *alloc_ctrl_skb(struct sk_buff *skb, int len)
 		__skb_trim(skb, 0);
 		refcount_inc(&skb->users);
 	} else {
-		skb = alloc_skb(len, GFP_KERNEL | __GFP_NOFAIL);
+		skb = alloc_skb(len, GFP_KERNEL | GFP_NOFAIL);
 	}
 	return skb;
 }
@@ -305,7 +305,7 @@ static void chtls_close_conn(struct sock *sk)
 	csk = rcu_dereference_sk_user_data(sk);
 	tid = csk->tid;
 
-	skb = alloc_skb(len, GFP_KERNEL | __GFP_NOFAIL);
+	skb = alloc_skb(len, GFP_KERNEL | GFP_NOFAIL);
 	req = (struct cpl_close_con_req *)__skb_put(skb, len);
 	memset(req, 0, len);
 	req->wr.wr_hi = htonl(FW_WR_OP_V(FW_TP_WR) |
@@ -1990,7 +1990,7 @@ static void send_defer_abort_rpl(struct chtls_dev *cdev, struct sk_buff *skb)
 	struct sk_buff *reply_skb;
 
 	reply_skb = alloc_skb(sizeof(struct cpl_abort_rpl),
-			      GFP_KERNEL | __GFP_NOFAIL);
+			      GFP_KERNEL | GFP_NOFAIL);
 	__skb_put(reply_skb, sizeof(struct cpl_abort_rpl));
 	set_abort_rpl_wr(reply_skb, GET_TID(req),
 			 (req->status & CPL_ABORT_NO_RST));
diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_hw.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_hw.c
index 1e67140b0f80..b949c901f2bc 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_hw.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_hw.c
@@ -98,7 +98,7 @@ void chtls_set_tcb_field_rpl_skb(struct sock *sk, u16 word,
 	wrlen = sizeof(struct cpl_set_tcb_field) + sizeof(struct ulptx_idata);
 	wrlen = roundup(wrlen, 16);
 
-	skb = alloc_skb(wrlen, GFP_KERNEL | __GFP_NOFAIL);
+	skb = alloc_skb(wrlen, GFP_KERNEL | GFP_NOFAIL);
 	if (!skb)
 		return;
 
diff --git a/drivers/target/iscsi/cxgbit/cxgbit_cm.c b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
index d9204c590d9a..a6df299e4d4f 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_cm.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
@@ -697,7 +697,7 @@ __cxgbit_abort_conn(struct cxgbit_sock *csk, struct sk_buff *skb)
 
 void cxgbit_abort_conn(struct cxgbit_sock *csk)
 {
-	struct sk_buff *skb = alloc_skb(0, GFP_KERNEL | __GFP_NOFAIL);
+	struct sk_buff *skb = alloc_skb(0, GFP_KERNEL | GFP_NOFAIL);
 
 	cxgbit_get_csk(csk);
 	cxgbit_init_wr_wait(&csk->com.wr_wait);
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index d80e9d4c974b..dfddda94756d 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -162,7 +162,7 @@ static struct tty_ldisc *tty_ldisc_get(struct tty_struct *tty, int disc)
 	 * There is no way to handle allocation failure of only 16 bytes.
 	 * Let's simplify error handling and save more memory.
 	 */
-	ld = kmalloc(sizeof(struct tty_ldisc), GFP_KERNEL | __GFP_NOFAIL);
+	ld = kmalloc(sizeof(struct tty_ldisc), GFP_KERNEL | GFP_NOFAIL);
 	ld->ops = ldops;
 	ld->tty = tty;
 
diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
index eff700e5f7a2..eaf1a6049111 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -295,9 +295,9 @@ void vduse_domain_remove_user_bounce_pages(struct vduse_iova_domain *domain)
 	count = domain->bounce_size >> PAGE_SHIFT;
 	write_unlock(&domain->bounce_lock);
 
-	pages = kmalloc_array(count, sizeof(*pages), GFP_KERNEL | __GFP_NOFAIL);
+	pages = kmalloc_array(count, sizeof(*pages), GFP_KERNEL | GFP_NOFAIL);
 	for (i = 0; i < count; i++)
-		pages[i] = alloc_page(GFP_KERNEL | __GFP_NOFAIL);
+		pages[i] = alloc_page(GFP_KERNEL | GFP_NOFAIL);
 
 	write_lock(&domain->bounce_lock);
 	if (!domain->user_bounce_pages) {
diff --git a/fs/bcachefs/btree_iter.c b/fs/bcachefs/btree_iter.c
index 36872207f09b..85d7a5393b42 100644
--- a/fs/bcachefs/btree_iter.c
+++ b/fs/bcachefs/btree_iter.c
@@ -1619,7 +1619,7 @@ static noinline void btree_paths_realloc(struct btree_trans *trans)
 			  sizeof(struct btree_trans_paths) +
 			  nr * sizeof(struct btree_path) +
 			  nr * sizeof(btree_path_idx_t) + 8 +
-			  nr * sizeof(struct btree_insert_entry), GFP_KERNEL|__GFP_NOFAIL);
+			  nr * sizeof(struct btree_insert_entry), GFP_KERNEL|GFP_NOFAIL);
 
 	unsigned long *paths_allocated = p;
 	memcpy(paths_allocated, trans->paths_allocated, BITS_TO_LONGS(trans->nr_paths) * sizeof(unsigned long));
diff --git a/fs/bcachefs/fs-io-buffered.c b/fs/bcachefs/fs-io-buffered.c
index cc33d763f722..9cbbc5dac45b 100644
--- a/fs/bcachefs/fs-io-buffered.c
+++ b/fs/bcachefs/fs-io-buffered.c
@@ -534,7 +534,7 @@ static int __bch2_writepage(struct folio *folio,
 
 	if (f_sectors > w->tmp_sectors) {
 		kfree(w->tmp);
-		w->tmp = kcalloc(f_sectors, sizeof(struct bch_folio_sector), __GFP_NOFAIL);
+		w->tmp = kcalloc(f_sectors, sizeof(struct bch_folio_sector), GFP_NOFAIL);
 		w->tmp_sectors = f_sectors;
 	}
 
diff --git a/fs/bcachefs/io_write.c b/fs/bcachefs/io_write.c
index d31c8d006d97..f5defe4dd26f 100644
--- a/fs/bcachefs/io_write.c
+++ b/fs/bcachefs/io_write.c
@@ -1279,7 +1279,7 @@ static void bch2_nocow_write(struct bch_write_op *op)
 			/* XXX allocating memory with btree locks held - rare */
 			darray_push_gfp(&buckets, ((struct bucket_to_lock) {
 						   .b = b, .gen = ptr->gen, .l = l,
-						   }), GFP_KERNEL|__GFP_NOFAIL);
+						   }), GFP_KERNEL|GFP_NOFAIL);
 
 			if (ptr->unwritten)
 				op->flags |= BCH_WRITE_CONVERT_UNWRITTEN;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index aa7f8148cd0d..29303973143a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -686,7 +686,7 @@ int btrfs_alloc_folio_array(unsigned int nr_folios, struct folio **folio_array)
  * @nr_pages:   number of pages to allocate
  * @page_array: the array to fill with pages; any existing non-null entries in
  *		the array will be skipped
- * @nofail:	whether using __GFP_NOFAIL flag
+ * @nofail:	whether using GFP_NOFAIL flag
  *
  * Return: 0        if all pages were able to be allocated;
  *         -ENOMEM  otherwise, the partially allocated pages would be freed and
@@ -695,7 +695,7 @@ int btrfs_alloc_folio_array(unsigned int nr_folios, struct folio **folio_array)
 int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
 			   bool nofail)
 {
-	const gfp_t gfp = nofail ? (GFP_NOFS | __GFP_NOFAIL) : GFP_NOFS;
+	const gfp_t gfp = nofail ? (GFP_NOFS | GFP_NOFAIL) : GFP_NOFS;
 	unsigned int allocated;
 
 	for (allocated = 0; allocated < nr_pages;) {
@@ -2674,7 +2674,7 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 {
 	struct extent_buffer *eb = NULL;
 
-	eb = kmem_cache_zalloc(extent_buffer_cache, GFP_NOFS|__GFP_NOFAIL);
+	eb = kmem_cache_zalloc(extent_buffer_cache, GFP_NOFS|GFP_NOFAIL);
 	eb->start = start;
 	eb->len = len;
 	eb->fs_info = fs_info;
@@ -2982,7 +2982,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 
 retry:
 	ret = filemap_add_folio(mapping, eb->folios[i], index + i,
-				GFP_NOFS | __GFP_NOFAIL);
+				GFP_NOFS | GFP_NOFAIL);
 	if (!ret)
 		goto finish;
 
diff --git a/fs/buffer.c b/fs/buffer.c
index e55ad471c530..64952bb73c8d 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -963,7 +963,7 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 {
 	gfp_t gfp = GFP_NOFS | __GFP_ACCOUNT;
 	if (retry)
-		gfp |= __GFP_NOFAIL;
+		gfp |= GFP_NOFAIL;
 
 	return folio_alloc_buffers(page_folio(page), size, gfp);
 }
@@ -1490,7 +1490,7 @@ struct buffer_head *__bread_gfp(struct block_device *bdev, sector_t block,
 	 * Prefer looping in the allocator rather than here, at least that
 	 * code knows what it's doing.
 	 */
-	gfp |= __GFP_NOFAIL;
+	gfp |= GFP_NOFAIL;
 
 	bh = bdev_getblk(bdev, block, size, gfp);
 
@@ -1666,7 +1666,7 @@ struct buffer_head *create_empty_buffers(struct folio *folio,
 		unsigned long blocksize, unsigned long b_state)
 {
 	struct buffer_head *bh, *head, *tail;
-	gfp_t gfp = GFP_NOFS | __GFP_ACCOUNT | __GFP_NOFAIL;
+	gfp_t gfp = GFP_NOFS | __GFP_ACCOUNT | GFP_NOFAIL;
 
 	head = folio_alloc_buffers(folio, blocksize, gfp);
 	bh = head;
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index fda16eedafb5..759a02600dc3 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -196,7 +196,7 @@ struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev)
 {
 	struct erofs_fscache_bio *io;
 
-	io = kmalloc(sizeof(*io), GFP_KERNEL | __GFP_NOFAIL);
+	io = kmalloc(sizeof(*io), GFP_KERNEL | GFP_NOFAIL);
 	bio_init(&io->bio, NULL, io->bvecs, BIO_MAX_VECS, REQ_OP_READ);
 	io->io.private = mdev->m_fscache->cookie;
 	io->io.end_io = erofs_fscache_bio_endio;
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 424f656cd765..e5192f7e75f0 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1106,7 +1106,7 @@ static void z_erofs_do_decompressed_bvec(struct z_erofs_decompress_backend *be,
 	}
 
 	/* (cold path) one pcluster is requested multiple times */
-	item = kmalloc(sizeof(*item), GFP_KERNEL | __GFP_NOFAIL);
+	item = kmalloc(sizeof(*item), GFP_KERNEL | GFP_NOFAIL);
 	item->bvec = *bvec;
 	list_add(&item->list, &be->decompressed_secondary_bvecs);
 }
@@ -1245,11 +1245,11 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	if (!be->decompressed_pages)
 		be->decompressed_pages =
 			kvcalloc(be->nr_pages, sizeof(struct page *),
-				 GFP_KERNEL | __GFP_NOFAIL);
+				 GFP_KERNEL | GFP_NOFAIL);
 	if (!be->compressed_pages)
 		be->compressed_pages =
 			kvcalloc(pclusterpages, sizeof(struct page *),
-				 GFP_KERNEL | __GFP_NOFAIL);
+				 GFP_KERNEL | GFP_NOFAIL);
 
 	z_erofs_parse_out_bvecs(be);
 	err2 = z_erofs_parse_in_bvecs(be, &overlapped);
@@ -1269,7 +1269,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 					.partial_decoding = pcl->partial,
 					.fillgaps = pcl->multibases,
 					.gfp = pcl->besteffort ?
-						GFP_KERNEL | __GFP_NOFAIL :
+						GFP_KERNEL | GFP_NOFAIL :
 						GFP_NOWAIT | __GFP_NORETRY
 				 }, be->pagepool);
 
@@ -1496,7 +1496,7 @@ static void z_erofs_fill_bio_vec(struct bio_vec *bvec,
 	folio_unlock(folio);
 	folio_put(folio);
 out_allocfolio:
-	zbv.page = erofs_allocpage(&f->pagepool, gfp | __GFP_NOFAIL);
+	zbv.page = erofs_allocpage(&f->pagepool, gfp | GFP_NOFAIL);
 	spin_lock(&pcl->obj.lockref.lock);
 	if (pcl->compressed_bvecs[nr].page) {
 		erofs_pagepool_add(&f->pagepool, zbv.page);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index e067f2dd0335..ea636f07e7c4 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -555,7 +555,7 @@ __read_extent_tree_block(const char *function, unsigned int line,
 	ext4_fsblk_t			pblk;
 
 	if (flags & EXT4_EX_NOFAIL)
-		gfp_flags |= __GFP_NOFAIL;
+		gfp_flags |= GFP_NOFAIL;
 
 	pblk = ext4_idx_pblock(idx);
 	bh = sb_getblk_gfp(inode->i_sb, pblk, gfp_flags);
@@ -891,7 +891,7 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 	gfp_t gfp_flags = GFP_NOFS;
 
 	if (flags & EXT4_EX_NOFAIL)
-		gfp_flags |= __GFP_NOFAIL;
+		gfp_flags |= GFP_NOFAIL;
 
 	eh = ext_inode_hdr(inode);
 	depth = ext_depth(inode);
@@ -1067,7 +1067,7 @@ static int ext4_ext_split(handle_t *handle, struct inode *inode,
 	size_t ext_size = 0;
 
 	if (flags & EXT4_EX_NOFAIL)
-		gfp_flags |= __GFP_NOFAIL;
+		gfp_flags |= GFP_NOFAIL;
 
 	/* make decision: where to split? */
 	/* FIXME: now decision is simplest: at current extent */
@@ -2912,7 +2912,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 				le16_to_cpu(path[k].p_hdr->eh_entries)+1;
 	} else {
 		path = kcalloc(depth + 1, sizeof(struct ext4_ext_path),
-			       GFP_NOFS | __GFP_NOFAIL);
+			       GFP_NOFS | GFP_NOFAIL);
 		if (path == NULL) {
 			ext4_journal_stop(handle);
 			return -ENOMEM;
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 17dcf13adde2..70423b01abe6 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -456,7 +456,7 @@ static inline struct pending_reservation *__alloc_pending(bool nofail)
 	if (!nofail)
 		return kmem_cache_alloc(ext4_pending_cachep, GFP_ATOMIC);
 
-	return kmem_cache_zalloc(ext4_pending_cachep, GFP_KERNEL | __GFP_NOFAIL);
+	return kmem_cache_zalloc(ext4_pending_cachep, GFP_KERNEL | GFP_NOFAIL);
 }
 
 static inline void __free_pending(struct pending_reservation *pr)
@@ -482,7 +482,7 @@ static inline struct extent_status *__es_alloc_extent(bool nofail)
 	if (!nofail)
 		return kmem_cache_alloc(ext4_es_cachep, GFP_ATOMIC);
 
-	return kmem_cache_zalloc(ext4_es_cachep, GFP_KERNEL | __GFP_NOFAIL);
+	return kmem_cache_zalloc(ext4_es_cachep, GFP_KERNEL | GFP_NOFAIL);
 }
 
 static void ext4_es_init_extent(struct inode *inode, struct extent_status *es,
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9dda9cd68ab2..fc763893e4d0 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5592,7 +5592,7 @@ void ext4_discard_preallocations(struct inode *inode)
 		group = ext4_get_group_number(sb, pa->pa_pstart);
 
 		err = ext4_mb_load_buddy_gfp(sb, group, &e4b,
-					     GFP_NOFS|__GFP_NOFAIL);
+					     GFP_NOFS|GFP_NOFAIL);
 		if (err) {
 			ext4_error_err(sb, -err, "Error %d loading buddy information for %u",
 				       err, group);
@@ -5898,7 +5898,7 @@ ext4_mb_discard_lg_preallocations(struct super_block *sb,
 
 		group = ext4_get_group_number(sb, pa->pa_pstart);
 		err = ext4_mb_load_buddy_gfp(sb, group, &e4b,
-					     GFP_NOFS|__GFP_NOFAIL);
+					     GFP_NOFS|GFP_NOFAIL);
 		if (err) {
 			ext4_error_err(sb, -err, "Error %d loading buddy information for %u",
 				       err, group);
@@ -6449,9 +6449,9 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 	count_clusters = EXT4_NUM_B2C(sbi, count);
 	trace_ext4_mballoc_free(sb, inode, block_group, bit, count_clusters);
 
-	/* __GFP_NOFAIL: retry infinitely, ignore TIF_MEMDIE and memcg limit. */
+	/* GFP_NOFAIL: retry infinitely, ignore TIF_MEMDIE and memcg limit. */
 	err = ext4_mb_load_buddy_gfp(sb, block_group, &e4b,
-				     GFP_NOFS|__GFP_NOFAIL);
+				     GFP_NOFS|GFP_NOFAIL);
 	if (err)
 		goto error_out;
 
@@ -6488,11 +6488,11 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 	     !ext4_should_writeback_data(inode))) {
 		struct ext4_free_data *new_entry;
 		/*
-		 * We use __GFP_NOFAIL because ext4_free_blocks() is not allowed
+		 * We use GFP_NOFAIL because ext4_free_blocks() is not allowed
 		 * to fail.
 		 */
 		new_entry = kmem_cache_alloc(ext4_free_data_cachep,
-				GFP_NOFS|__GFP_NOFAIL);
+				GFP_NOFS|GFP_NOFAIL);
 		new_entry->efd_start_cluster = bit;
 		new_entry->efd_group = block_group;
 		new_entry->efd_count = count_clusters;
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index ad5543866d21..4d9a557d692f 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -530,7 +530,7 @@ int ext4_bio_write_folio(struct ext4_io_submit *io, struct folio *folio,
 				if (io->io_bio)
 					ext4_io_submit(io);
 				else
-					new_gfp_flags |= __GFP_NOFAIL;
+					new_gfp_flags |= GFP_NOFAIL;
 				memalloc_retry_wait(gfp_flags);
 				gfp_flags = new_gfp_flags;
 				goto retry_encrypt;
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 55d444bec5c0..0f9d4e50373e 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -531,7 +531,7 @@ static void __add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino,
 		new = f2fs_kmem_cache_alloc(ino_entry_slab,
 						GFP_NOFS, true, NULL);
 
-	radix_tree_preload(GFP_NOFS | __GFP_NOFAIL);
+	radix_tree_preload(GFP_NOFS | GFP_NOFAIL);
 
 	spin_lock(&im->ino_lock);
 	e = radix_tree_lookup(&im->ino_root, ino);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b9b0debc6b3d..46f95caa96f6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2518,7 +2518,7 @@ int f2fs_encrypt_one_page(struct f2fs_io_info *fio)
 		if (PTR_ERR(fio->encrypted_page) == -ENOMEM) {
 			f2fs_flush_merged_writes(fio->sbi);
 			memalloc_retry_wait(GFP_NOFS);
-			gfp_flags |= __GFP_NOFAIL;
+			gfp_flags |= GFP_NOFAIL;
 			goto retry_encrypt;
 		}
 		return PTR_ERR(fio->encrypted_page);
@@ -2998,7 +2998,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	if (f2fs_compressed_file(inode) &&
 		1 << cc.log_cluster_size > F2FS_ONSTACK_PAGES) {
 		pages = f2fs_kzalloc(sbi, sizeof(struct page *) <<
-				cc.log_cluster_size, GFP_NOFS | __GFP_NOFAIL);
+				cc.log_cluster_size, GFP_NOFS | GFP_NOFAIL);
 		max_pages = 1 << cc.log_cluster_size;
 	}
 #endif
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8a9d910aa552..c8fbfb73fb95 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2814,7 +2814,7 @@ static inline void *f2fs_kmem_cache_alloc_nofail(struct kmem_cache *cachep,
 
 	entry = kmem_cache_alloc(cachep, flags);
 	if (!entry)
-		entry = kmem_cache_alloc(cachep, flags | __GFP_NOFAIL);
+		entry = kmem_cache_alloc(cachep, flags | GFP_NOFAIL);
 	return entry;
 }
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b72ef96f7e33..919c7cb9366d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2316,7 +2316,7 @@ static bool add_free_nid(struct f2fs_sb_info *sbi,
 	i->nid = nid;
 	i->state = FREE_NID;
 
-	radix_tree_preload(GFP_NOFS | __GFP_NOFAIL);
+	radix_tree_preload(GFP_NOFS | GFP_NOFAIL);
 
 	spin_lock(&nm_i->nid_list_lock);
 
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 9eb191b5c4de..8f4012060fdc 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -490,7 +490,7 @@ ssize_t fuse_simple_request(struct fuse_mount *fm, struct fuse_args *args)
 
 	if (args->force) {
 		atomic_inc(&fc->num_waiting);
-		req = fuse_request_alloc(fm, GFP_KERNEL | __GFP_NOFAIL);
+		req = fuse_request_alloc(fm, GFP_KERNEL | GFP_NOFAIL);
 
 		if (!args->nocreds)
 			fuse_force_creds(req);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f39456c65ed7..7b9ff0334d51 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -116,7 +116,7 @@ static void fuse_file_put(struct fuse_file *ff, bool sync)
 		} else {
 			args->end = fuse_release_end;
 			if (fuse_simple_background(ff->fm, args,
-						   GFP_KERNEL | __GFP_NOFAIL))
+						   GFP_KERNEL | GFP_NOFAIL))
 				fuse_release_end(ff->fm, args, -ENOTCONN);
 		}
 		kfree(ff);
@@ -1816,7 +1816,7 @@ __acquires(fi->lock)
 	err = fuse_simple_background(fm, args, GFP_ATOMIC);
 	if (err == -ENOMEM) {
 		spin_unlock(&fi->lock);
-		err = fuse_simple_background(fm, args, GFP_NOFS | __GFP_NOFAIL);
+		err = fuse_simple_background(fm, args, GFP_NOFS | GFP_NOFAIL);
 		spin_lock(&fi->lock);
 	}
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d8ab4e93916f..6861b34290b9 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -634,7 +634,7 @@ static struct fuse_sync_bucket *fuse_sync_bucket_alloc(void)
 {
 	struct fuse_sync_bucket *bucket;
 
-	bucket = kzalloc(sizeof(*bucket), GFP_KERNEL | __GFP_NOFAIL);
+	bucket = kzalloc(sizeof(*bucket), GFP_KERNEL | GFP_NOFAIL);
 	if (bucket) {
 		init_waitqueue_head(&bucket->waitq);
 		/* Initial active count */
@@ -1372,7 +1372,7 @@ void fuse_send_init(struct fuse_mount *fm)
 	struct fuse_init_args *ia;
 	u64 flags;
 
-	ia = kzalloc(sizeof(*ia), GFP_KERNEL | __GFP_NOFAIL);
+	ia = kzalloc(sizeof(*ia), GFP_KERNEL | GFP_NOFAIL);
 
 	ia->in.major = FUSE_KERNEL_VERSION;
 	ia->in.minor = FUSE_KERNEL_MINOR_VERSION;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index dd5260141615..29ff3bf6d242 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -700,7 +700,7 @@ static void virtio_fs_requests_done_work(struct work_struct *work)
 		if (req->args->may_block) {
 			struct virtio_fs_req_work *w;
 
-			w = kzalloc(sizeof(*w), GFP_NOFS | __GFP_NOFAIL);
+			w = kzalloc(sizeof(*w), GFP_NOFS | GFP_NOFAIL);
 			INIT_WORK(&w->done_work, virtio_fs_complete_req_work);
 			w->fsvq = fsvq;
 			w->req = req;
@@ -1109,7 +1109,7 @@ __releases(fiq->lock)
 	spin_unlock(&fiq->lock);
 
 	/* Allocate a buffer for the request */
-	forget = kmalloc(sizeof(*forget), GFP_NOFS | __GFP_NOFAIL);
+	forget = kmalloc(sizeof(*forget), GFP_NOFS | GFP_NOFAIL);
 	req = &forget->req;
 
 	req->ih = (struct fuse_in_header){
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 2b26e8d529aa..af5bbd443543 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -131,7 +131,7 @@ struct buffer_head *gfs2_getbuf(struct gfs2_glock *gl, u64 blkno, int create)
 	if (create) {
 		folio = __filemap_get_folio(mapping, index,
 				FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
-				mapping_gfp_mask(mapping) | __GFP_NOFAIL);
+				mapping_gfp_mask(mapping) | GFP_NOFAIL);
 		bh = folio_buffers(folio);
 		if (!bh)
 			bh = create_empty_buffers(folio,
diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index 29c772816765..bfeb0f91e0e7 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -2273,7 +2273,7 @@ static void rgblk_free(struct gfs2_sbd *sdp, struct gfs2_rgrpd *rgd,
 		if (bi != bi_prev) {
 			if (!bi->bi_clone) {
 				bi->bi_clone = kmalloc(bi->bi_bh->b_size,
-						      GFP_NOFS | __GFP_NOFAIL);
+						      GFP_NOFS | GFP_NOFAIL);
 				memcpy(bi->bi_clone + bi->bi_offset,
 				       bi->bi_bh->b_data + bi->bi_offset,
 				       bi->bi_bytes);
@@ -2702,7 +2702,7 @@ void gfs2_rlist_add(struct gfs2_inode *ip, struct gfs2_rgrp_list *rlist,
 		new_space = rlist->rl_space + 10;
 
 		tmp = kcalloc(new_space, sizeof(struct gfs2_rgrpd *),
-			      GFP_NOFS | __GFP_NOFAIL);
+			      GFP_NOFS | GFP_NOFAIL);
 
 		if (rlist->rl_rgd) {
 			memcpy(tmp, rlist->rl_rgd,
@@ -2735,7 +2735,7 @@ void gfs2_rlist_alloc(struct gfs2_rgrp_list *rlist,
 
 	rlist->rl_ghs = kmalloc_array(rlist->rl_rgrps,
 				      sizeof(struct gfs2_holder),
-				      GFP_NOFS | __GFP_NOFAIL);
+				      GFP_NOFS | GFP_NOFAIL);
 	for (x = 0; x < rlist->rl_rgrps; x++)
 		gfs2_holder_init(rlist->rl_rgd[x]->rd_gl, state, flags,
 				 &rlist->rl_ghs[x]);
diff --git a/fs/gfs2/trans.c b/fs/gfs2/trans.c
index 192213c7359a..8cbbdc09a46c 100644
--- a/fs/gfs2/trans.c
+++ b/fs/gfs2/trans.c
@@ -165,7 +165,7 @@ static struct gfs2_bufdata *gfs2_alloc_bufdata(struct gfs2_glock *gl,
 {
 	struct gfs2_bufdata *bd;
 
-	bd = kmem_cache_zalloc(gfs2_bufdata_cachep, GFP_NOFS | __GFP_NOFAIL);
+	bd = kmem_cache_zalloc(gfs2_bufdata_cachep, GFP_NOFS | GFP_NOFAIL);
 	bd->bd_bh = bh;
 	bd->bd_gl = gl;
 	INIT_LIST_HEAD(&bd->bd_list);
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f420c53d86ac..0b25c5501894 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -192,7 +192,7 @@ static struct iomap_folio_state *ifs_alloc(struct inode *inode,
 	if (flags & IOMAP_NOWAIT)
 		gfp = GFP_NOWAIT;
 	else
-		gfp = GFP_NOFS | __GFP_NOFAIL;
+		gfp = GFP_NOFS | GFP_NOFAIL;
 
 	/*
 	 * ifs->state tracks two sets of state flags when the
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 1ebf2393bfb7..cbfb45cb4a0b 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -338,7 +338,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 	 */
 	J_ASSERT_BH(bh_in, buffer_jbddirty(bh_in));
 
-	new_bh = alloc_buffer_head(GFP_NOFS|__GFP_NOFAIL);
+	new_bh = alloc_buffer_head(GFP_NOFS|GFP_NOFAIL);
 
 	/* keep subsequent assertions sane */
 	atomic_set(&new_bh->b_count, 1);
@@ -2864,7 +2864,7 @@ static struct journal_head *journal_alloc_journal_head(void)
 		jbd2_debug(1, "out of memory for journal_head\n");
 		pr_notice_ratelimited("ENOMEM in %s, retrying.\n", __func__);
 		ret = kmem_cache_zalloc(jbd2_journal_head_cache,
-				GFP_NOFS | __GFP_NOFAIL);
+				GFP_NOFS | GFP_NOFAIL);
 	}
 	if (ret)
 		spin_lock_init(&ret->b_state_lock);
diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
index 4556e4689024..2af21686b037 100644
--- a/fs/jbd2/revoke.c
+++ b/fs/jbd2/revoke.c
@@ -141,7 +141,7 @@ static int insert_revoke_hash(journal_t *journal, unsigned long long blocknr,
 	gfp_t gfp_mask = GFP_NOFS;
 
 	if (journal_oom_retry)
-		gfp_mask |= __GFP_NOFAIL;
+		gfp_mask |= GFP_NOFAIL;
 	record = kmem_cache_alloc(jbd2_revoke_record_cache, gfp_mask);
 	if (!record)
 		return -ENOMEM;
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 66513c18ca29..76551cd71260 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -351,7 +351,7 @@ static int start_this_handle(journal_t *journal, handle_t *handle,
 		 * inside the fs writeback layer, so we MUST NOT fail.
 		 */
 		if ((gfp_mask & __GFP_FS) == 0)
-			gfp_mask |= __GFP_NOFAIL;
+			gfp_mask |= GFP_NOFAIL;
 		new_transaction = kmem_cache_zalloc(transaction_cache,
 						    gfp_mask);
 		if (!new_transaction)
@@ -1115,7 +1115,7 @@ do_get_write_access(handle_t *handle, struct journal_head *jh,
 			JBUFFER_TRACE(jh, "allocate memory for buffer");
 			spin_unlock(&jh->b_state_lock);
 			frozen_buffer = jbd2_alloc(jh2bh(jh)->b_size,
-						   GFP_NOFS | __GFP_NOFAIL);
+						   GFP_NOFS | GFP_NOFAIL);
 			goto repeat;
 		}
 		jh->b_frozen_data = frozen_buffer;
@@ -1393,7 +1393,7 @@ int jbd2_journal_get_undo_access(handle_t *handle, struct buffer_head *bh)
 repeat:
 	if (!jh->b_committed_data)
 		committed_data = jbd2_alloc(jh2bh(jh)->b_size,
-					    GFP_NOFS|__GFP_NOFAIL);
+					    GFP_NOFS|GFP_NOFAIL);
 
 	spin_lock(&jh->b_state_lock);
 	if (!jh->b_committed_data) {
diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 224bccaab4cc..2704b5b66e8e 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -794,7 +794,7 @@ static struct fanotify_event *fanotify_alloc_event(
 	 * target monitoring memcg as it may have security repercussion.
 	 */
 	if (group->max_events == UINT_MAX)
-		gfp |= __GFP_NOFAIL;
+		gfp |= GFP_NOFAIL;
 	else
 		gfp |= __GFP_RETRY_MAYFAIL;
 
diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index e477ee0ff35d..93d3238a5d1b 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -2570,7 +2570,7 @@ static struct reiserfs_journal_list *alloc_journal_list(struct super_block *s)
 {
 	struct reiserfs_journal_list *jl;
 	jl = kzalloc(sizeof(struct reiserfs_journal_list),
-		     GFP_NOFS | __GFP_NOFAIL);
+		     GFP_NOFS | GFP_NOFAIL);
 	INIT_LIST_HEAD(&jl->j_list);
 	INIT_LIST_HEAD(&jl->j_working_list);
 	INIT_LIST_HEAD(&jl->j_tail_bh_list);
diff --git a/fs/udf/directory.c b/fs/udf/directory.c
index 93153665eb37..1f040ff7c15b 100644
--- a/fs/udf/directory.c
+++ b/fs/udf/directory.c
@@ -252,7 +252,7 @@ int udf_fiiter_init(struct udf_fileident_iter *iter, struct inode *dir,
 	 * fail and it can be difficult to undo without corrupting filesystem.
 	 * So just do not allow memory allocation failures here.
 	 */
-	iter->namebuf = kmalloc(UDF_NAME_LEN_CS0, GFP_KERNEL | __GFP_NOFAIL);
+	iter->namebuf = kmalloc(UDF_NAME_LEN_CS0, GFP_KERNEL | GFP_NOFAIL);
 
 	if (iinfo->i_alloc_type == ICBTAG_FLAG_AD_IN_ICB) {
 		err = udf_copy_fi(iter);
diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 59326f84f6a5..e32e95c29280 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -2649,7 +2649,7 @@ xfs_defer_extent_free(
 		return -EFSCORRUPTED;
 
 	xefi = kmem_cache_zalloc(xfs_extfree_item_cache,
-			       GFP_KERNEL | __GFP_NOFAIL);
+			       GFP_KERNEL | GFP_NOFAIL);
 	xefi->xefi_startblock = bno;
 	xefi->xefi_blockcount = (xfs_extlen_t)len;
 	xefi->xefi_agresv = type;
diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
index b9e98950eb3d..9cc06f758d85 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -954,7 +954,7 @@ xfs_attr_shortform_to_leaf(
 
 	trace_xfs_attr_sf_to_leaf(args);
 
-	tmpbuffer = kmalloc(size, GFP_KERNEL | __GFP_NOFAIL);
+	tmpbuffer = kmalloc(size, GFP_KERNEL | GFP_NOFAIL);
 	memcpy(tmpbuffer, ifp->if_data, size);
 	sf = (struct xfs_attr_sf_hdr *)tmpbuffer;
 
@@ -1138,7 +1138,7 @@ xfs_attr3_leaf_to_shortform(
 
 	trace_xfs_attr_leaf_to_sf(args);
 
-	tmpbuffer = kmalloc(args->geo->blksize, GFP_KERNEL | __GFP_NOFAIL);
+	tmpbuffer = kmalloc(args->geo->blksize, GFP_KERNEL | GFP_NOFAIL);
 	if (!tmpbuffer)
 		return -ENOMEM;
 
@@ -1613,7 +1613,7 @@ xfs_attr3_leaf_compact(
 
 	trace_xfs_attr_leaf_compact(args);
 
-	tmpbuffer = kmalloc(args->geo->blksize, GFP_KERNEL | __GFP_NOFAIL);
+	tmpbuffer = kmalloc(args->geo->blksize, GFP_KERNEL | GFP_NOFAIL);
 	memcpy(tmpbuffer, bp->b_addr, args->geo->blksize);
 	memset(bp->b_addr, 0, args->geo->blksize);
 	leaf_src = (xfs_attr_leafblock_t *)tmpbuffer;
@@ -2331,7 +2331,7 @@ xfs_attr3_leaf_unbalance(
 		struct xfs_attr3_icleaf_hdr tmphdr;
 
 		tmp_leaf = kzalloc(state->args->geo->blksize,
-				GFP_KERNEL | __GFP_NOFAIL);
+				GFP_KERNEL | GFP_NOFAIL);
 
 		/*
 		 * Copy the header into the temp leaf so that all the stuff
diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 7df74c35d9f9..6accbb03ec8a 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -6246,7 +6246,7 @@ __xfs_bmap_add(
 	    bmap->br_startblock == DELAYSTARTBLOCK)
 		return;
 
-	bi = kmem_cache_alloc(xfs_bmap_intent_cache, GFP_KERNEL | __GFP_NOFAIL);
+	bi = kmem_cache_alloc(xfs_bmap_intent_cache, GFP_KERNEL | GFP_NOFAIL);
 	INIT_LIST_HEAD(&bi->bi_list);
 	bi->bi_type = type;
 	bi->bi_owner = ip;
diff --git a/fs/xfs/libxfs/xfs_btree.h b/fs/xfs/libxfs/xfs_btree.h
index 10b7ddc3b2b3..4df96e12603c 100644
--- a/fs/xfs/libxfs/xfs_btree.h
+++ b/fs/xfs/libxfs/xfs_btree.h
@@ -663,7 +663,7 @@ xfs_btree_alloc_cursor(
 
 	/* BMBT allocations can come through from non-transactional context. */
 	cur = kmem_cache_zalloc(cache,
-			GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_NOFAIL);
+			GFP_KERNEL | __GFP_NOLOCKDEP | GFP_NOFAIL);
 	cur->bc_ops = ops;
 	cur->bc_tp = tp;
 	cur->bc_mp = mp;
diff --git a/fs/xfs/libxfs/xfs_btree_staging.c b/fs/xfs/libxfs/xfs_btree_staging.c
index 694929703152..fa13fb00be31 100644
--- a/fs/xfs/libxfs/xfs_btree_staging.c
+++ b/fs/xfs/libxfs/xfs_btree_staging.c
@@ -303,7 +303,7 @@ xfs_btree_bload_prep_block(
 
 		/* Allocate a new incore btree root block. */
 		new_size = bbl->iroot_size(cur, level, nr_this_block, priv);
-		ifp->if_broot = kzalloc(new_size, GFP_KERNEL | __GFP_NOFAIL);
+		ifp->if_broot = kzalloc(new_size, GFP_KERNEL | GFP_NOFAIL);
 		ifp->if_broot_bytes = (int)new_size;
 
 		/* Initialize it and send it out. */
diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
index 16a529a88780..846678b2ce3c 100644
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -87,7 +87,7 @@ xfs_da_state_alloc(
 	struct xfs_da_state	*state;
 
 	state = kmem_cache_zalloc(xfs_da_state_cache,
-			GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_NOFAIL);
+			GFP_KERNEL | __GFP_NOLOCKDEP | GFP_NOFAIL);
 	state->args = args;
 	state->mp = args->dp->i_mount;
 	return state;
@@ -2323,7 +2323,7 @@ xfs_da_grow_inode_int(
 		 * try without the CONTIG flag.  Loop until we get it all.
 		 */
 		mapp = kmalloc(sizeof(*mapp) * count,
-				GFP_KERNEL | __GFP_NOFAIL);
+				GFP_KERNEL | GFP_NOFAIL);
 		for (b = *bno, mapi = 0; b < *bno + count; ) {
 			c = (int)(*bno + count - b);
 			nmap = min(XFS_BMAP_MAX_NMAP, c);
@@ -2702,7 +2702,7 @@ xfs_dabuf_map(
 
 	if (nfsb > 1)
 		irecs = kzalloc(sizeof(irec) * nfsb,
-				GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_NOFAIL);
+				GFP_KERNEL | __GFP_NOLOCKDEP | GFP_NOFAIL);
 
 	nirecs = nfsb;
 	error = xfs_bmapi_read(dp, bno, nfsb, irecs, &nirecs,
@@ -2716,7 +2716,7 @@ xfs_dabuf_map(
 	 */
 	if (nirecs > 1) {
 		map = kzalloc(nirecs * sizeof(struct xfs_buf_map),
-				GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_NOFAIL);
+				GFP_KERNEL | __GFP_NOLOCKDEP | GFP_NOFAIL);
 		if (!map) {
 			error = -ENOMEM;
 			goto out_free_irecs;
diff --git a/fs/xfs/libxfs/xfs_defer.c b/fs/xfs/libxfs/xfs_defer.c
index 40021849b42f..08c5ee66e44c 100644
--- a/fs/xfs/libxfs/xfs_defer.c
+++ b/fs/xfs/libxfs/xfs_defer.c
@@ -828,7 +828,7 @@ xfs_defer_alloc(
 	struct xfs_defer_pending	*dfp;
 
 	dfp = kmem_cache_zalloc(xfs_defer_pending_cache,
-			GFP_KERNEL | __GFP_NOFAIL);
+			GFP_KERNEL | GFP_NOFAIL);
 	dfp->dfp_ops = ops;
 	INIT_LIST_HEAD(&dfp->dfp_work);
 	list_add_tail(&dfp->dfp_list, dfops);
@@ -977,7 +977,7 @@ xfs_defer_ops_capture(
 		return ERR_PTR(error);
 
 	/* Create an object to capture the defer ops. */
-	dfc = kzalloc(sizeof(*dfc), GFP_KERNEL | __GFP_NOFAIL);
+	dfc = kzalloc(sizeof(*dfc), GFP_KERNEL | GFP_NOFAIL);
 	INIT_LIST_HEAD(&dfc->dfc_list);
 	INIT_LIST_HEAD(&dfc->dfc_dfops);
 
diff --git a/fs/xfs/libxfs/xfs_dir2.c b/fs/xfs/libxfs/xfs_dir2.c
index 202468223bf9..1884428eda5f 100644
--- a/fs/xfs/libxfs/xfs_dir2.c
+++ b/fs/xfs/libxfs/xfs_dir2.c
@@ -248,7 +248,7 @@ xfs_dir_init(
 	if (error)
 		return error;
 
-	args = kzalloc(sizeof(*args), GFP_KERNEL | __GFP_NOFAIL);
+	args = kzalloc(sizeof(*args), GFP_KERNEL | GFP_NOFAIL);
 	if (!args)
 		return -ENOMEM;
 
@@ -341,7 +341,7 @@ xfs_dir_createname(
 		XFS_STATS_INC(dp->i_mount, xs_dir_create);
 	}
 
-	args = kzalloc(sizeof(*args), GFP_KERNEL | __GFP_NOFAIL);
+	args = kzalloc(sizeof(*args), GFP_KERNEL | GFP_NOFAIL);
 	if (!args)
 		return -ENOMEM;
 
@@ -439,7 +439,7 @@ xfs_dir_lookup(
 	XFS_STATS_INC(dp->i_mount, xs_dir_lookup);
 
 	args = kzalloc(sizeof(*args),
-			GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_NOFAIL);
+			GFP_KERNEL | __GFP_NOLOCKDEP | GFP_NOFAIL);
 	args->geo = dp->i_mount->m_dir_geo;
 	args->name = name->name;
 	args->namelen = name->len;
@@ -504,7 +504,7 @@ xfs_dir_removename(
 	ASSERT(S_ISDIR(VFS_I(dp)->i_mode));
 	XFS_STATS_INC(dp->i_mount, xs_dir_remove);
 
-	args = kzalloc(sizeof(*args), GFP_KERNEL | __GFP_NOFAIL);
+	args = kzalloc(sizeof(*args), GFP_KERNEL | GFP_NOFAIL);
 	if (!args)
 		return -ENOMEM;
 
@@ -564,7 +564,7 @@ xfs_dir_replace(
 	if (rval)
 		return rval;
 
-	args = kzalloc(sizeof(*args), GFP_KERNEL | __GFP_NOFAIL);
+	args = kzalloc(sizeof(*args), GFP_KERNEL | GFP_NOFAIL);
 	if (!args)
 		return -ENOMEM;
 
diff --git a/fs/xfs/libxfs/xfs_dir2_block.c b/fs/xfs/libxfs/xfs_dir2_block.c
index 0f93ed1a4a74..555f840e8465 100644
--- a/fs/xfs/libxfs/xfs_dir2_block.c
+++ b/fs/xfs/libxfs/xfs_dir2_block.c
@@ -1116,7 +1116,7 @@ xfs_dir2_sf_to_block(
 	 * Copy the directory into a temporary buffer.
 	 * Then pitch the incore inode data so we can make extents.
 	 */
-	sfp = kmalloc(ifp->if_bytes, GFP_KERNEL | __GFP_NOFAIL);
+	sfp = kmalloc(ifp->if_bytes, GFP_KERNEL | GFP_NOFAIL);
 	memcpy(sfp, oldsfp, ifp->if_bytes);
 
 	xfs_idata_realloc(dp, -ifp->if_bytes, XFS_DATA_FORK);
diff --git a/fs/xfs/libxfs/xfs_dir2_sf.c b/fs/xfs/libxfs/xfs_dir2_sf.c
index 17a20384c8b7..4c0f65e2e0a6 100644
--- a/fs/xfs/libxfs/xfs_dir2_sf.c
+++ b/fs/xfs/libxfs/xfs_dir2_sf.c
@@ -276,7 +276,7 @@ xfs_dir2_block_to_sf(
 	 * format the data into.  Once we have formatted the data, we can free
 	 * the block and copy the formatted data into the inode literal area.
 	 */
-	sfp = kmalloc(mp->m_sb.sb_inodesize, GFP_KERNEL | __GFP_NOFAIL);
+	sfp = kmalloc(mp->m_sb.sb_inodesize, GFP_KERNEL | GFP_NOFAIL);
 	memcpy(sfp, sfhp, xfs_dir2_sf_hdr_size(sfhp->i8count));
 
 	/*
@@ -524,7 +524,7 @@ xfs_dir2_sf_addname_hard(
 	 * Copy the old directory to the stack buffer.
 	 */
 	old_isize = (int)dp->i_disk_size;
-	buf = kmalloc(old_isize, GFP_KERNEL | __GFP_NOFAIL);
+	buf = kmalloc(old_isize, GFP_KERNEL | GFP_NOFAIL);
 	oldsfp = (xfs_dir2_sf_hdr_t *)buf;
 	memcpy(oldsfp, dp->i_df.if_data, old_isize);
 	/*
@@ -1151,7 +1151,7 @@ xfs_dir2_sf_toino4(
 	 * Don't want xfs_idata_realloc copying the data here.
 	 */
 	oldsize = dp->i_df.if_bytes;
-	buf = kmalloc(oldsize, GFP_KERNEL | __GFP_NOFAIL);
+	buf = kmalloc(oldsize, GFP_KERNEL | GFP_NOFAIL);
 	ASSERT(oldsfp->i8count == 1);
 	memcpy(buf, oldsfp, oldsize);
 	/*
@@ -1223,7 +1223,7 @@ xfs_dir2_sf_toino8(
 	 * Don't want xfs_idata_realloc copying the data here.
 	 */
 	oldsize = dp->i_df.if_bytes;
-	buf = kmalloc(oldsize, GFP_KERNEL | __GFP_NOFAIL);
+	buf = kmalloc(oldsize, GFP_KERNEL | GFP_NOFAIL);
 	ASSERT(oldsfp->i8count == 0);
 	memcpy(buf, oldsfp, oldsize);
 	/*
diff --git a/fs/xfs/libxfs/xfs_exchmaps.c b/fs/xfs/libxfs/xfs_exchmaps.c
index 2021396651de..eabbb13bd02c 100644
--- a/fs/xfs/libxfs/xfs_exchmaps.c
+++ b/fs/xfs/libxfs/xfs_exchmaps.c
@@ -499,7 +499,7 @@ xfs_exchmaps_link_to_sf(
 
 	/* Read the current symlink target into a buffer. */
 	buf = kmalloc(ip->i_disk_size + 1,
-			GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_NOFAIL);
+			GFP_KERNEL | __GFP_NOLOCKDEP | GFP_NOFAIL);
 	if (!buf) {
 		ASSERT(0);
 		return -ENOMEM;
@@ -978,7 +978,7 @@ xfs_exchmaps_init_intent(
 	unsigned int			rs = 0;
 
 	xmi = kmem_cache_zalloc(xfs_exchmaps_intent_cache,
-			GFP_NOFS | __GFP_NOFAIL);
+			GFP_NOFS | GFP_NOFAIL);
 	INIT_LIST_HEAD(&xmi->xmi_list);
 	xmi->xmi_ip1 = req->ip1;
 	xmi->xmi_ip2 = req->ip2;
diff --git a/fs/xfs/libxfs/xfs_iext_tree.c b/fs/xfs/libxfs/xfs_iext_tree.c
index 8796f2b3e534..367dc8dbb886 100644
--- a/fs/xfs/libxfs/xfs_iext_tree.c
+++ b/fs/xfs/libxfs/xfs_iext_tree.c
@@ -398,7 +398,7 @@ static inline void *
 xfs_iext_alloc_node(
 	int	size)
 {
-	return kzalloc(size, GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_NOFAIL);
+	return kzalloc(size, GFP_KERNEL | __GFP_NOLOCKDEP | GFP_NOFAIL);
 }
 
 static void
@@ -611,7 +611,7 @@ xfs_iext_realloc_root(
 		new_size = NODE_SIZE;
 
 	new = krealloc(ifp->if_data, new_size,
-			GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_NOFAIL);
+			GFP_KERNEL | __GFP_NOLOCKDEP | GFP_NOFAIL);
 	memset(new + ifp->if_bytes, 0, new_size - ifp->if_bytes);
 	ifp->if_data = new;
 	cur->leaf = new;
diff --git a/fs/xfs/libxfs/xfs_inode_fork.c b/fs/xfs/libxfs/xfs_inode_fork.c
index 9d11ae015909..e087337bdaa8 100644
--- a/fs/xfs/libxfs/xfs_inode_fork.c
+++ b/fs/xfs/libxfs/xfs_inode_fork.c
@@ -53,7 +53,7 @@ xfs_init_local_fork(
 
 	if (size) {
 		char *new_data = kmalloc(mem_size,
-				GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_NOFAIL);
+				GFP_KERNEL | __GFP_NOLOCKDEP | GFP_NOFAIL);
 
 		memcpy(new_data, data, size);
 		if (zero_terminate)
@@ -213,7 +213,7 @@ xfs_iformat_btree(
 
 	ifp->if_broot_bytes = size;
 	ifp->if_broot = kmalloc(size,
-				GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_NOFAIL);
+				GFP_KERNEL | __GFP_NOLOCKDEP | GFP_NOFAIL);
 	ASSERT(ifp->if_broot != NULL);
 	/*
 	 * Copy and convert from the on-disk structure
@@ -411,7 +411,7 @@ xfs_iroot_realloc(
 		if (ifp->if_broot_bytes == 0) {
 			new_size = XFS_BMAP_BROOT_SPACE_CALC(mp, rec_diff);
 			ifp->if_broot = kmalloc(new_size,
-						GFP_KERNEL | __GFP_NOFAIL);
+						GFP_KERNEL | GFP_NOFAIL);
 			ifp->if_broot_bytes = (int)new_size;
 			return;
 		}
@@ -426,7 +426,7 @@ xfs_iroot_realloc(
 		new_max = cur_max + rec_diff;
 		new_size = XFS_BMAP_BROOT_SPACE_CALC(mp, new_max);
 		ifp->if_broot = krealloc(ifp->if_broot, new_size,
-					 GFP_KERNEL | __GFP_NOFAIL);
+					 GFP_KERNEL | GFP_NOFAIL);
 		op = (char *)XFS_BMAP_BROOT_PTR_ADDR(mp, ifp->if_broot, 1,
 						     ifp->if_broot_bytes);
 		np = (char *)XFS_BMAP_BROOT_PTR_ADDR(mp, ifp->if_broot, 1,
@@ -452,7 +452,7 @@ xfs_iroot_realloc(
 	else
 		new_size = 0;
 	if (new_size > 0) {
-		new_broot = kmalloc(new_size, GFP_KERNEL | __GFP_NOFAIL);
+		new_broot = kmalloc(new_size, GFP_KERNEL | GFP_NOFAIL);
 		/*
 		 * First copy over the btree block header.
 		 */
@@ -521,7 +521,7 @@ xfs_idata_realloc(
 
 	if (byte_diff) {
 		ifp->if_data = krealloc(ifp->if_data, new_size,
-					GFP_KERNEL | __GFP_NOFAIL);
+					GFP_KERNEL | GFP_NOFAIL);
 		if (new_size == 0)
 			ifp->if_data = NULL;
 		ifp->if_bytes = new_size;
@@ -701,7 +701,7 @@ xfs_ifork_init_cow(
 		return;
 
 	ip->i_cowfp = kmem_cache_zalloc(xfs_ifork_cache,
-				GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_NOFAIL);
+				GFP_KERNEL | __GFP_NOLOCKDEP | GFP_NOFAIL);
 	ip->i_cowfp->if_format = XFS_DINODE_FMT_EXTENTS;
 }
 
diff --git a/fs/xfs/libxfs/xfs_refcount.c b/fs/xfs/libxfs/xfs_refcount.c
index 198b84117df1..05d746e8939d 100644
--- a/fs/xfs/libxfs/xfs_refcount.c
+++ b/fs/xfs/libxfs/xfs_refcount.c
@@ -1430,7 +1430,7 @@ __xfs_refcount_add(
 	struct xfs_refcount_intent	*ri;
 
 	ri = kmem_cache_alloc(xfs_refcount_intent_cache,
-			GFP_KERNEL | __GFP_NOFAIL);
+			GFP_KERNEL | GFP_NOFAIL);
 	INIT_LIST_HEAD(&ri->ri_list);
 	ri->ri_type = type;
 	ri->ri_startblock = startblock;
@@ -1876,7 +1876,7 @@ xfs_refcount_recover_extent(
 	}
 
 	rr = kmalloc(sizeof(struct xfs_refcount_recovery),
-			GFP_KERNEL | __GFP_NOFAIL);
+			GFP_KERNEL | GFP_NOFAIL);
 	INIT_LIST_HEAD(&rr->rr_list);
 	xfs_refcount_btrec_to_irec(rec, &rr->rr_rrec);
 
diff --git a/fs/xfs/libxfs/xfs_rmap.c b/fs/xfs/libxfs/xfs_rmap.c
index 6ef4687b3aba..da360a213871 100644
--- a/fs/xfs/libxfs/xfs_rmap.c
+++ b/fs/xfs/libxfs/xfs_rmap.c
@@ -2650,7 +2650,7 @@ __xfs_rmap_add(
 {
 	struct xfs_rmap_intent		*ri;
 
-	ri = kmem_cache_alloc(xfs_rmap_intent_cache, GFP_KERNEL | __GFP_NOFAIL);
+	ri = kmem_cache_alloc(xfs_rmap_intent_cache, GFP_KERNEL | GFP_NOFAIL);
 	INIT_LIST_HEAD(&ri->ri_list);
 	ri->ri_type = type;
 	ri->ri_owner = owner;
diff --git a/fs/xfs/xfs_attr_item.c b/fs/xfs/xfs_attr_item.c
index f683b7a9323f..27ab8c15d666 100644
--- a/fs/xfs/xfs_attr_item.c
+++ b/fs/xfs/xfs_attr_item.c
@@ -275,7 +275,7 @@ xfs_attri_init(
 {
 	struct xfs_attri_log_item	*attrip;
 
-	attrip = kmem_cache_zalloc(xfs_attri_cache, GFP_KERNEL | __GFP_NOFAIL);
+	attrip = kmem_cache_zalloc(xfs_attri_cache, GFP_KERNEL | GFP_NOFAIL);
 
 	/*
 	 * Grab an extra reference to the name/value buffer for this log item.
@@ -673,7 +673,7 @@ xfs_attri_recover_work(
 	}
 
 	attr = kzalloc(sizeof(struct xfs_attr_intent) +
-			sizeof(struct xfs_da_args), GFP_KERNEL | __GFP_NOFAIL);
+			sizeof(struct xfs_da_args), GFP_KERNEL | GFP_NOFAIL);
 	args = (struct xfs_da_args *)(attr + 1);
 
 	attr->xattri_da_args = args;
@@ -858,7 +858,7 @@ xfs_attr_create_done(
 
 	attrip = ATTRI_ITEM(intent);
 
-	attrdp = kmem_cache_zalloc(xfs_attrd_cache, GFP_KERNEL | __GFP_NOFAIL);
+	attrdp = kmem_cache_zalloc(xfs_attrd_cache, GFP_KERNEL | GFP_NOFAIL);
 
 	xfs_log_item_init(tp->t_mountp, &attrdp->attrd_item, XFS_LI_ATTRD,
 			  &xfs_attrd_item_ops);
@@ -885,7 +885,7 @@ xfs_attr_defer_add(
 	}
 
 	new = kmem_cache_zalloc(xfs_attr_intent_cache,
-			GFP_NOFS | __GFP_NOFAIL);
+			GFP_NOFS | GFP_NOFAIL);
 	new->xattri_da_args = args;
 
 	/* Compute log operation from the higher level op and namespace. */
diff --git a/fs/xfs/xfs_attr_list.c b/fs/xfs/xfs_attr_list.c
index 5c947e5ce8b8..7161cf86ccc6 100644
--- a/fs/xfs/xfs_attr_list.c
+++ b/fs/xfs/xfs_attr_list.c
@@ -114,7 +114,7 @@ xfs_attr_shortform_list(
 	 * It didn't all fit, so we have to sort everything on hashval.
 	 */
 	sbsize = sf->count * sizeof(*sbuf);
-	sbp = sbuf = kmalloc(sbsize, GFP_KERNEL | __GFP_NOFAIL);
+	sbp = sbuf = kmalloc(sbsize, GFP_KERNEL | GFP_NOFAIL);
 
 	/*
 	 * Scan the attribute list for the rest of the entries, storing
diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
index e224b49b7cff..3265a74bc457 100644
--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -142,7 +142,7 @@ xfs_bui_init(
 {
 	struct xfs_bui_log_item		*buip;
 
-	buip = kmem_cache_zalloc(xfs_bui_cache, GFP_KERNEL | __GFP_NOFAIL);
+	buip = kmem_cache_zalloc(xfs_bui_cache, GFP_KERNEL | GFP_NOFAIL);
 
 	xfs_log_item_init(mp, &buip->bui_item, XFS_LI_BUI, &xfs_bui_item_ops);
 	buip->bui_format.bui_nextents = XFS_BUI_MAX_FAST_EXTENTS;
@@ -309,7 +309,7 @@ xfs_bmap_update_create_done(
 	struct xfs_bui_log_item		*buip = BUI_ITEM(intent);
 	struct xfs_bud_log_item		*budp;
 
-	budp = kmem_cache_zalloc(xfs_bud_cache, GFP_KERNEL | __GFP_NOFAIL);
+	budp = kmem_cache_zalloc(xfs_bud_cache, GFP_KERNEL | GFP_NOFAIL);
 	xfs_log_item_init(tp->t_mountp, &budp->bud_item, XFS_LI_BUD,
 			  &xfs_bud_item_ops);
 	budp->bud_buip = buip;
@@ -452,7 +452,7 @@ xfs_bui_recover_work(
 		return ERR_PTR(error);
 
 	bi = kmem_cache_zalloc(xfs_bmap_intent_cache,
-			GFP_KERNEL | __GFP_NOFAIL);
+			GFP_KERNEL | GFP_NOFAIL);
 	bi->bi_whichfork = (map->me_flags & XFS_BMAP_EXTENT_ATTR_FORK) ?
 			XFS_ATTR_FORK : XFS_DATA_FORK;
 	bi->bi_type = map->me_flags & XFS_BMAP_EXTENT_TYPE_MASK;
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index aa4dbda7b536..bf6c1a83a70d 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -196,7 +196,7 @@ xfs_buf_get_maps(
 	}
 
 	bp->b_maps = kzalloc(map_count * sizeof(struct xfs_buf_map),
-			GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_NOFAIL);
+			GFP_KERNEL | __GFP_NOLOCKDEP | GFP_NOFAIL);
 	if (!bp->b_maps)
 		return -ENOMEM;
 	return 0;
@@ -229,7 +229,7 @@ _xfs_buf_alloc(
 
 	*bpp = NULL;
 	bp = kmem_cache_zalloc(xfs_buf_cache,
-			GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_NOFAIL);
+			GFP_KERNEL | __GFP_NOLOCKDEP | GFP_NOFAIL);
 
 	/*
 	 * We don't want certain flags to appear in b_flags unless they are
@@ -334,7 +334,7 @@ xfs_buf_alloc_kmem(
 	struct xfs_buf	*bp,
 	xfs_buf_flags_t	flags)
 {
-	gfp_t		gfp_mask = GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_NOFAIL;
+	gfp_t		gfp_mask = GFP_KERNEL | __GFP_NOLOCKDEP | GFP_NOFAIL;
 	size_t		size = BBTOB(bp->b_length);
 
 	/* Assure zeroed buffer for non-read cases. */
@@ -2106,7 +2106,7 @@ xfs_alloc_buftarg(
 #if defined(CONFIG_FS_DAX) && defined(CONFIG_MEMORY_FAILURE)
 	ops = &xfs_dax_holder_operations;
 #endif
-	btp = kzalloc(sizeof(*btp), GFP_KERNEL | __GFP_NOFAIL);
+	btp = kzalloc(sizeof(*btp), GFP_KERNEL | GFP_NOFAIL);
 
 	btp->bt_mount = mp;
 	btp->bt_bdev_file = bdev_file;
diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index 47549cfa61cd..c35fc6897c82 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -838,7 +838,7 @@ xfs_buf_item_get_format(
 	}
 
 	bip->bli_formats = kzalloc(count * sizeof(struct xfs_buf_log_format),
-				GFP_KERNEL | __GFP_NOFAIL);
+				GFP_KERNEL | GFP_NOFAIL);
 }
 
 STATIC void
@@ -879,7 +879,7 @@ xfs_buf_item_init(
 		return 0;
 	}
 
-	bip = kmem_cache_zalloc(xfs_buf_item_cache, GFP_KERNEL | __GFP_NOFAIL);
+	bip = kmem_cache_zalloc(xfs_buf_item_cache, GFP_KERNEL | GFP_NOFAIL);
 	xfs_log_item_init(mp, &bip->bli_item, XFS_LI_BUF, &xfs_buf_item_ops);
 	bip->bli_buf = bp;
 
diff --git a/fs/xfs/xfs_buf_item_recover.c b/fs/xfs/xfs_buf_item_recover.c
index 09e893cf563c..df4d0bfe0547 100644
--- a/fs/xfs/xfs_buf_item_recover.c
+++ b/fs/xfs/xfs_buf_item_recover.c
@@ -85,7 +85,7 @@ xlog_add_buffer_cancelled(
 		return false;
 	}
 
-	bcp = kmalloc(sizeof(struct xfs_buf_cancel), GFP_KERNEL | __GFP_NOFAIL);
+	bcp = kmalloc(sizeof(struct xfs_buf_cancel), GFP_KERNEL | GFP_NOFAIL);
 	bcp->bc_blkno = blkno;
 	bcp->bc_len = len;
 	bcp->bc_refcount = 1;
diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index c1b211c260a9..db6e78b485ea 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -494,7 +494,7 @@ xfs_dquot_alloc(
 {
 	struct xfs_dquot	*dqp;
 
-	dqp = kmem_cache_zalloc(xfs_dquot_cache, GFP_KERNEL | __GFP_NOFAIL);
+	dqp = kmem_cache_zalloc(xfs_dquot_cache, GFP_KERNEL | GFP_NOFAIL);
 
 	dqp->q_type = type;
 	dqp->q_id = id;
diff --git a/fs/xfs/xfs_exchmaps_item.c b/fs/xfs/xfs_exchmaps_item.c
index 264a121c5e16..af790026296a 100644
--- a/fs/xfs/xfs_exchmaps_item.c
+++ b/fs/xfs/xfs_exchmaps_item.c
@@ -134,7 +134,7 @@ xfs_xmi_init(
 {
 	struct xfs_xmi_log_item	*xmi_lip;
 
-	xmi_lip = kmem_cache_zalloc(xfs_xmi_cache, GFP_KERNEL | __GFP_NOFAIL);
+	xmi_lip = kmem_cache_zalloc(xfs_xmi_cache, GFP_KERNEL | GFP_NOFAIL);
 
 	xfs_log_item_init(mp, &xmi_lip->xmi_item, XFS_LI_XMI, &xfs_xmi_item_ops);
 	xmi_lip->xmi_format.xmi_id = (uintptr_t)(void *)xmi_lip;
@@ -253,7 +253,7 @@ xfs_exchmaps_create_done(
 	struct xfs_xmi_log_item		*xmi_lip = XMI_ITEM(intent);
 	struct xfs_xmd_log_item		*xmd_lip;
 
-	xmd_lip = kmem_cache_zalloc(xfs_xmd_cache, GFP_KERNEL | __GFP_NOFAIL);
+	xmd_lip = kmem_cache_zalloc(xfs_xmd_cache, GFP_KERNEL | GFP_NOFAIL);
 	xfs_log_item_init(tp->t_mountp, &xmd_lip->xmd_item, XFS_LI_XMD,
 			  &xfs_xmd_item_ops);
 	xmd_lip->xmd_intent_log_item = xmi_lip;
diff --git a/fs/xfs/xfs_extent_busy.c b/fs/xfs/xfs_extent_busy.c
index a73e7c73b664..a6c9953781fb 100644
--- a/fs/xfs/xfs_extent_busy.c
+++ b/fs/xfs/xfs_extent_busy.c
@@ -33,7 +33,7 @@ xfs_extent_busy_insert_list(
 	struct rb_node		*parent = NULL;
 
 	new = kzalloc(sizeof(struct xfs_extent_busy),
-			GFP_KERNEL | __GFP_NOFAIL);
+			GFP_KERNEL | GFP_NOFAIL);
 	new->agno = pag->pag_agno;
 	new->bno = bno;
 	new->length = len;
diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
index abffc74a924f..e09713ad83b5 100644
--- a/fs/xfs/xfs_extfree_item.c
+++ b/fs/xfs/xfs_extfree_item.c
@@ -148,10 +148,10 @@ xfs_efi_init(
 	ASSERT(nextents > 0);
 	if (nextents > XFS_EFI_MAX_FAST_EXTENTS) {
 		efip = kzalloc(xfs_efi_log_item_sizeof(nextents),
-				GFP_KERNEL | __GFP_NOFAIL);
+				GFP_KERNEL | GFP_NOFAIL);
 	} else {
 		efip = kmem_cache_zalloc(xfs_efi_cache,
-					 GFP_KERNEL | __GFP_NOFAIL);
+					 GFP_KERNEL | GFP_NOFAIL);
 	}
 
 	xfs_log_item_init(mp, &efip->efi_item, XFS_LI_EFI, &xfs_efi_item_ops);
@@ -421,10 +421,10 @@ xfs_extent_free_create_done(
 
 	if (count > XFS_EFD_MAX_FAST_EXTENTS) {
 		efdp = kzalloc(xfs_efd_log_item_sizeof(count),
-				GFP_KERNEL | __GFP_NOFAIL);
+				GFP_KERNEL | GFP_NOFAIL);
 	} else {
 		efdp = kmem_cache_zalloc(xfs_efd_cache,
-					GFP_KERNEL | __GFP_NOFAIL);
+					GFP_KERNEL | GFP_NOFAIL);
 	}
 
 	xfs_log_item_init(tp->t_mountp, &efdp->efd_item, XFS_LI_EFD,
@@ -573,7 +573,7 @@ xfs_efi_recover_work(
 	struct xfs_extent_free_item	*xefi;
 
 	xefi = kmem_cache_zalloc(xfs_extfree_item_cache,
-			       GFP_KERNEL | __GFP_NOFAIL);
+			       GFP_KERNEL | GFP_NOFAIL);
 	xefi->xefi_startblock = extp->ext_start;
 	xefi->xefi_blockcount = extp->ext_len;
 	xefi->xefi_agresv = XFS_AG_RESV_NONE;
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index cf629302d48e..821dfa6a4cb9 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -79,7 +79,7 @@ xfs_inode_alloc(
 	 * XXX: If this didn't occur in transactions, we could drop GFP_NOFAIL
 	 * and return NULL here on ENOMEM.
 	 */
-	ip = alloc_inode_sb(mp->m_super, xfs_inode_cache, GFP_KERNEL | __GFP_NOFAIL);
+	ip = alloc_inode_sb(mp->m_super, xfs_inode_cache, GFP_KERNEL | GFP_NOFAIL);
 
 	if (inode_init_always(mp->m_super, VFS_I(ip))) {
 		kmem_cache_free(xfs_inode_cache, ip);
diff --git a/fs/xfs/xfs_icreate_item.c b/fs/xfs/xfs_icreate_item.c
index 4345db501714..dd74eefa82f9 100644
--- a/fs/xfs/xfs_icreate_item.c
+++ b/fs/xfs/xfs_icreate_item.c
@@ -98,7 +98,7 @@ xfs_icreate_log(
 {
 	struct xfs_icreate_item	*icp;
 
-	icp = kmem_cache_zalloc(xfs_icreate_cache, GFP_KERNEL | __GFP_NOFAIL);
+	icp = kmem_cache_zalloc(xfs_icreate_cache, GFP_KERNEL | GFP_NOFAIL);
 
 	xfs_log_item_init(tp->t_mountp, &icp->ic_item, XFS_LI_ICREATE,
 			  &xfs_icreate_item_ops);
diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index b509cbd191f4..a61b97ba6cfe 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -868,7 +868,7 @@ xfs_inode_item_init(
 
 	ASSERT(ip->i_itemp == NULL);
 	iip = ip->i_itemp = kmem_cache_zalloc(xfs_ili_cache,
-					      GFP_KERNEL | __GFP_NOFAIL);
+					      GFP_KERNEL | GFP_NOFAIL);
 
 	iip->ili_inode = ip;
 	spin_lock_init(&iip->ili_lock);
diff --git a/fs/xfs/xfs_inode_item_recover.c b/fs/xfs/xfs_inode_item_recover.c
index dbdab4ce7c44..bbc2c33cff07 100644
--- a/fs/xfs/xfs_inode_item_recover.c
+++ b/fs/xfs/xfs_inode_item_recover.c
@@ -292,7 +292,7 @@ xlog_recover_inode_commit_pass2(
 		in_f = item->ri_buf[0].i_addr;
 	} else {
 		in_f = kmalloc(sizeof(struct xfs_inode_log_format),
-				GFP_KERNEL | __GFP_NOFAIL);
+				GFP_KERNEL | GFP_NOFAIL);
 		need_free = 1;
 		error = xfs_inode_item_format_convert(&item->ri_buf[0], in_f);
 		if (error)
diff --git a/fs/xfs/xfs_iunlink_item.c b/fs/xfs/xfs_iunlink_item.c
index 2ddccb172fa0..bba7861c7451 100644
--- a/fs/xfs/xfs_iunlink_item.c
+++ b/fs/xfs/xfs_iunlink_item.c
@@ -161,7 +161,7 @@ xfs_iunlink_log_inode(
 		return 0;
 	}
 
-	iup = kmem_cache_zalloc(xfs_iunlink_cache, GFP_KERNEL | __GFP_NOFAIL);
+	iup = kmem_cache_zalloc(xfs_iunlink_cache, GFP_KERNEL | GFP_NOFAIL);
 	xfs_log_item_init(mp, &iup->item, XFS_LI_IUNLINK,
 			  &xfs_iunlink_item_ops);
 
diff --git a/fs/xfs/xfs_iwalk.c b/fs/xfs/xfs_iwalk.c
index 86f14ec7c31f..75c290e1dab3 100644
--- a/fs/xfs/xfs_iwalk.c
+++ b/fs/xfs/xfs_iwalk.c
@@ -659,7 +659,7 @@ xfs_iwalk_threaded(
 			break;
 
 		iwag = kzalloc(sizeof(struct xfs_iwalk_ag),
-				GFP_KERNEL | __GFP_NOFAIL);
+				GFP_KERNEL | GFP_NOFAIL);
 		iwag->mp = mp;
 
 		/*
diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index 817ea7e0a8ab..ed513ede0c44 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -3244,7 +3244,7 @@ xlog_ticket_alloc(
 	int			unit_res;
 
 	tic = kmem_cache_zalloc(xfs_log_ticket_cache,
-			GFP_KERNEL | __GFP_NOFAIL);
+			GFP_KERNEL | GFP_NOFAIL);
 
 	unit_res = xlog_calc_unit_res(log, unit_bytes, &tic->t_iclog_hdrs);
 
diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
index 391a938d690c..c101ba39a172 100644
--- a/fs/xfs/xfs_log_cil.c
+++ b/fs/xfs/xfs_log_cil.c
@@ -100,7 +100,7 @@ xlog_cil_ctx_alloc(void)
 {
 	struct xfs_cil_ctx	*ctx;
 
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL | __GFP_NOFAIL);
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL | GFP_NOFAIL);
 	INIT_LIST_HEAD(&ctx->committing);
 	INIT_LIST_HEAD(&ctx->busy_extents.extent_list);
 	INIT_LIST_HEAD(&ctx->log_items);
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 1997981827fb..86aca82656d5 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2087,7 +2087,7 @@ xlog_recover_add_item(
 	struct xlog_recover_item *item;
 
 	item = kzalloc(sizeof(struct xlog_recover_item),
-			GFP_KERNEL | __GFP_NOFAIL);
+			GFP_KERNEL | GFP_NOFAIL);
 	INIT_LIST_HEAD(&item->ri_list);
 	list_add_tail(&item->ri_list, head);
 }
@@ -2218,7 +2218,7 @@ xlog_recover_add_to_trans(
 
 		item->ri_total = in_f->ilf_size;
 		item->ri_buf = kzalloc(item->ri_total * sizeof(xfs_log_iovec_t),
-				GFP_KERNEL | __GFP_NOFAIL);
+				GFP_KERNEL | GFP_NOFAIL);
 	}
 
 	if (item->ri_total <= item->ri_cnt) {
@@ -2361,7 +2361,7 @@ xlog_recover_ophdr_to_trans(
 	 * This is a new transaction so allocate a new recovery container to
 	 * hold the recovery ops that will follow.
 	 */
-	trans = kzalloc(sizeof(struct xlog_recover), GFP_KERNEL | __GFP_NOFAIL);
+	trans = kzalloc(sizeof(struct xlog_recover), GFP_KERNEL | GFP_NOFAIL);
 	trans->r_log_tid = tid;
 	trans->r_lsn = be64_to_cpu(rhead->h_lsn);
 	INIT_LIST_HEAD(&trans->r_itemq);
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 09eef1721ef4..6b0cd7099fc8 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -86,7 +86,7 @@ xfs_uuid_mount(
 	if (hole < 0) {
 		xfs_uuid_table = krealloc(xfs_uuid_table,
 			(xfs_uuid_table_size + 1) * sizeof(*xfs_uuid_table),
-			GFP_KERNEL | __GFP_NOFAIL);
+			GFP_KERNEL | GFP_NOFAIL);
 		hole = xfs_uuid_table_size++;
 	}
 	xfs_uuid_table[hole] = *uuid;
diff --git a/fs/xfs/xfs_mru_cache.c b/fs/xfs/xfs_mru_cache.c
index 7443debaffd6..b53797f257e4 100644
--- a/fs/xfs/xfs_mru_cache.c
+++ b/fs/xfs/xfs_mru_cache.c
@@ -333,14 +333,14 @@ xfs_mru_cache_create(
 	if (!(grp_time = msecs_to_jiffies(lifetime_ms) / grp_count))
 		return -EINVAL;
 
-	mru = kzalloc(sizeof(*mru), GFP_KERNEL | __GFP_NOFAIL);
+	mru = kzalloc(sizeof(*mru), GFP_KERNEL | GFP_NOFAIL);
 	if (!mru)
 		return -ENOMEM;
 
 	/* An extra list is needed to avoid reaping up to a grp_time early. */
 	mru->grp_count = grp_count + 1;
 	mru->lists = kzalloc(mru->grp_count * sizeof(*mru->lists),
-				GFP_KERNEL | __GFP_NOFAIL);
+				GFP_KERNEL | GFP_NOFAIL);
 	if (!mru->lists) {
 		err = -ENOMEM;
 		goto exit;
diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index 9490b913a4ab..23b02066bcee 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -630,7 +630,7 @@ xfs_qm_init_quotainfo(
 	ASSERT(XFS_IS_QUOTA_ON(mp));
 
 	qinf = mp->m_quotainfo = kzalloc(sizeof(struct xfs_quotainfo),
-					GFP_KERNEL | __GFP_NOFAIL);
+					GFP_KERNEL | GFP_NOFAIL);
 
 	error = list_lru_init(&qinf->qi_lru);
 	if (error)
@@ -1011,7 +1011,7 @@ xfs_qm_reset_dqcounts_buf(
 		return 0;
 
 	map = kmalloc(XFS_DQITER_MAP_SIZE * sizeof(*map),
-			GFP_KERNEL | __GFP_NOFAIL);
+			GFP_KERNEL | GFP_NOFAIL);
 
 	lblkno = 0;
 	maxlblkcnt = XFS_B_TO_FSB(mp, mp->m_super->s_maxbytes);
diff --git a/fs/xfs/xfs_refcount_item.c b/fs/xfs/xfs_refcount_item.c
index 27398512b179..8899048ae6f6 100644
--- a/fs/xfs/xfs_refcount_item.c
+++ b/fs/xfs/xfs_refcount_item.c
@@ -146,10 +146,10 @@ xfs_cui_init(
 	ASSERT(nextents > 0);
 	if (nextents > XFS_CUI_MAX_FAST_EXTENTS)
 		cuip = kzalloc(xfs_cui_log_item_sizeof(nextents),
-				GFP_KERNEL | __GFP_NOFAIL);
+				GFP_KERNEL | GFP_NOFAIL);
 	else
 		cuip = kmem_cache_zalloc(xfs_cui_cache,
-					 GFP_KERNEL | __GFP_NOFAIL);
+					 GFP_KERNEL | GFP_NOFAIL);
 
 	xfs_log_item_init(mp, &cuip->cui_item, XFS_LI_CUI, &xfs_cui_item_ops);
 	cuip->cui_format.cui_nextents = nextents;
@@ -311,7 +311,7 @@ xfs_refcount_update_create_done(
 	struct xfs_cui_log_item		*cuip = CUI_ITEM(intent);
 	struct xfs_cud_log_item		*cudp;
 
-	cudp = kmem_cache_zalloc(xfs_cud_cache, GFP_KERNEL | __GFP_NOFAIL);
+	cudp = kmem_cache_zalloc(xfs_cud_cache, GFP_KERNEL | GFP_NOFAIL);
 	xfs_log_item_init(tp->t_mountp, &cudp->cud_item, XFS_LI_CUD,
 			  &xfs_cud_item_ops);
 	cudp->cud_cuip = cuip;
@@ -427,7 +427,7 @@ xfs_cui_recover_work(
 	struct xfs_refcount_intent	*ri;
 
 	ri = kmem_cache_alloc(xfs_refcount_intent_cache,
-			GFP_KERNEL | __GFP_NOFAIL);
+			GFP_KERNEL | GFP_NOFAIL);
 	ri->ri_type = pmap->pe_flags & XFS_REFCOUNT_EXTENT_TYPE_MASK;
 	ri->ri_startblock = pmap->pe_startblock;
 	ri->ri_blockcount = pmap->pe_len;
diff --git a/fs/xfs/xfs_rmap_item.c b/fs/xfs/xfs_rmap_item.c
index 88b5580e1e19..d711d290ff02 100644
--- a/fs/xfs/xfs_rmap_item.c
+++ b/fs/xfs/xfs_rmap_item.c
@@ -145,10 +145,10 @@ xfs_rui_init(
 	ASSERT(nextents > 0);
 	if (nextents > XFS_RUI_MAX_FAST_EXTENTS)
 		ruip = kzalloc(xfs_rui_log_item_sizeof(nextents),
-				GFP_KERNEL | __GFP_NOFAIL);
+				GFP_KERNEL | GFP_NOFAIL);
 	else
 		ruip = kmem_cache_zalloc(xfs_rui_cache,
-					 GFP_KERNEL | __GFP_NOFAIL);
+					 GFP_KERNEL | GFP_NOFAIL);
 
 	xfs_log_item_init(mp, &ruip->rui_item, XFS_LI_RUI, &xfs_rui_item_ops);
 	ruip->rui_format.rui_nextents = nextents;
@@ -334,7 +334,7 @@ xfs_rmap_update_create_done(
 	struct xfs_rui_log_item		*ruip = RUI_ITEM(intent);
 	struct xfs_rud_log_item		*rudp;
 
-	rudp = kmem_cache_zalloc(xfs_rud_cache, GFP_KERNEL | __GFP_NOFAIL);
+	rudp = kmem_cache_zalloc(xfs_rud_cache, GFP_KERNEL | GFP_NOFAIL);
 	xfs_log_item_init(tp->t_mountp, &rudp->rud_item, XFS_LI_RUD,
 			  &xfs_rud_item_ops);
 	rudp->rud_ruip = ruip;
@@ -454,7 +454,7 @@ xfs_rui_recover_work(
 {
 	struct xfs_rmap_intent		*ri;
 
-	ri = kmem_cache_alloc(xfs_rmap_intent_cache, GFP_KERNEL | __GFP_NOFAIL);
+	ri = kmem_cache_alloc(xfs_rmap_intent_cache, GFP_KERNEL | GFP_NOFAIL);
 
 	switch (map->me_flags & XFS_RMAP_EXTENT_TYPE_MASK) {
 	case XFS_RMAP_EXTENT_MAP:
diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index 0c3e96c621a6..3a5c260a4d75 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -901,7 +901,7 @@ xfs_growfs_rt(
 	/*
 	 * Allocate a new (fake) mount/sb.
 	 */
-	nmp = kmalloc(sizeof(*nmp), GFP_KERNEL | __GFP_NOFAIL);
+	nmp = kmalloc(sizeof(*nmp), GFP_KERNEL | GFP_NOFAIL);
 	/*
 	 * Loop over the bitmap blocks.
 	 * We will do everything one bitmap block at a time.
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 27e9f749c4c7..5f01da8300fa 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -2004,7 +2004,7 @@ static int xfs_init_fs_context(
 {
 	struct xfs_mount	*mp;
 
-	mp = kzalloc(sizeof(struct xfs_mount), GFP_KERNEL | __GFP_NOFAIL);
+	mp = kzalloc(sizeof(struct xfs_mount), GFP_KERNEL | GFP_NOFAIL);
 	if (!mp)
 		return -ENOMEM;
 
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index bdf3704dc301..e67b0ef50375 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -93,7 +93,7 @@ xfs_trans_dup(
 
 	trace_xfs_trans_dup(tp, _RET_IP_);
 
-	ntp = kmem_cache_zalloc(xfs_trans_cache, GFP_KERNEL | __GFP_NOFAIL);
+	ntp = kmem_cache_zalloc(xfs_trans_cache, GFP_KERNEL | GFP_NOFAIL);
 
 	/*
 	 * Initialize the new transaction structure.
@@ -259,7 +259,7 @@ xfs_trans_alloc(
 	 * by doing GFP_KERNEL allocations inside sb_start_intwrite().
 	 */
 retry:
-	tp = kmem_cache_zalloc(xfs_trans_cache, GFP_KERNEL | __GFP_NOFAIL);
+	tp = kmem_cache_zalloc(xfs_trans_cache, GFP_KERNEL | GFP_NOFAIL);
 	if (!(flags & XFS_TRANS_NO_WRITECOUNT))
 		sb_start_intwrite(mp->m_super);
 	xfs_trans_set_context(tp);
diff --git a/fs/xfs/xfs_trans_dquot.c b/fs/xfs/xfs_trans_dquot.c
index b368e13424c4..840b3ca0804f 100644
--- a/fs/xfs/xfs_trans_dquot.c
+++ b/fs/xfs/xfs_trans_dquot.c
@@ -1013,7 +1013,7 @@ xfs_trans_alloc_dqinfo(
 	xfs_trans_t	*tp)
 {
 	tp->t_dqinfo = kmem_cache_zalloc(xfs_dqtrx_cache,
-					 GFP_KERNEL | __GFP_NOFAIL);
+					 GFP_KERNEL | GFP_NOFAIL);
 }
 
 void
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 14acf1bbe0ce..8a26d25f2274 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -365,7 +365,7 @@ static inline struct buffer_head *getblk_unmovable(struct block_device *bdev,
 	gfp_t gfp;
 
 	gfp = mapping_gfp_constraint(bdev->bd_mapping, ~__GFP_FS);
-	gfp |= __GFP_NOFAIL;
+	gfp |= GFP_NOFAIL;
 
 	return bdev_getblk(bdev, block, size, gfp);
 }
@@ -376,7 +376,7 @@ static inline struct buffer_head *__getblk(struct block_device *bdev,
 	gfp_t gfp;
 
 	gfp = mapping_gfp_constraint(bdev->bd_mapping, ~__GFP_FS);
-	gfp |= __GFP_MOVABLE | __GFP_NOFAIL;
+	gfp |= __GFP_MOVABLE | GFP_NOFAIL;
 
 	return bdev_getblk(bdev, block, size, gfp);
 }
diff --git a/kernel/resource.c b/kernel/resource.c
index 9f747bb7cd03..c4c26f54d60e 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1376,7 +1376,7 @@ void release_mem_region_adjustable(resource_size_t start, resource_size_t size)
 	 * similarly).
 	 */
 retry:
-	new_res = alloc_resource(GFP_KERNEL | (alloc_nofail ? __GFP_NOFAIL : 0));
+	new_res = alloc_resource(GFP_KERNEL | (alloc_nofail ? GFP_NOFAIL : 0));
 
 	p = &parent->child;
 	write_lock(&resource_lock);
diff --git a/lib/list-test.c b/lib/list-test.c
index 37cbc33e9fdb..21ffa455ff0e 100644
--- a/lib/list-test.c
+++ b/lib/list-test.c
@@ -26,10 +26,10 @@ static void list_test_list_init(struct kunit *test)
 
 	INIT_LIST_HEAD(&list2);
 
-	list4 = kzalloc(sizeof(*list4), GFP_KERNEL | __GFP_NOFAIL);
+	list4 = kzalloc(sizeof(*list4), GFP_KERNEL | GFP_NOFAIL);
 	INIT_LIST_HEAD(list4);
 
-	list5 = kmalloc(sizeof(*list5), GFP_KERNEL | __GFP_NOFAIL);
+	list5 = kmalloc(sizeof(*list5), GFP_KERNEL | GFP_NOFAIL);
 	memset(list5, 0xFF, sizeof(*list5));
 	INIT_LIST_HEAD(list5);
 
@@ -821,10 +821,10 @@ static void hlist_test_init(struct kunit *test)
 
 	INIT_HLIST_HEAD(&list2);
 
-	list4 = kzalloc(sizeof(*list4), GFP_KERNEL | __GFP_NOFAIL);
+	list4 = kzalloc(sizeof(*list4), GFP_KERNEL | GFP_NOFAIL);
 	INIT_HLIST_HEAD(list4);
 
-	list5 = kmalloc(sizeof(*list5), GFP_KERNEL | __GFP_NOFAIL);
+	list5 = kmalloc(sizeof(*list5), GFP_KERNEL | GFP_NOFAIL);
 	memset(list5, 0xFF, sizeof(*list5));
 	INIT_HLIST_HEAD(list5);
 
diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
index cf5609b1ca79..04beeb01b478 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -199,7 +199,7 @@ int ref_tracker_alloc(struct ref_tracker_dir *dir,
 		return 0;
 	}
 	if (gfp & __GFP_DIRECT_RECLAIM)
-		gfp_mask |= __GFP_NOFAIL;
+		gfp_mask |= GFP_NOFAIL;
 	*trackerp = tracker = kzalloc(sizeof(*tracker), gfp_mask);
 	if (unlikely(!tracker)) {
 		pr_err_once("memory allocation failure, unreliable refcount tracker.\n");
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index dbbed19f8fff..994b7582976b 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -189,7 +189,7 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 
 	size = nbuckets;
 
-	if (tbl == NULL && (gfp & ~__GFP_NOFAIL) != GFP_KERNEL) {
+	if (tbl == NULL && (gfp & ~GFP_NOFAIL) != GFP_KERNEL) {
 		tbl = nested_bucket_table_alloc(ht, nbuckets, gfp);
 		nbuckets = 0;
 	}
@@ -1066,12 +1066,12 @@ int rhashtable_init_noprof(struct rhashtable *ht,
 	/*
 	 * This is api initialization and thus we need to guarantee the
 	 * initial rhashtable allocation. Upon failure, retry with the
-	 * smallest possible size with __GFP_NOFAIL semantics.
+	 * smallest possible size with GFP_NOFAIL semantics.
 	 */
 	tbl = bucket_table_alloc(ht, size, GFP_KERNEL);
 	if (unlikely(tbl == NULL)) {
 		size = max_t(u16, ht->p.min_size, HASH_MIN_SIZE);
-		tbl = bucket_table_alloc(ht, size, GFP_KERNEL | __GFP_NOFAIL);
+		tbl = bucket_table_alloc(ht, size, GFP_KERNEL | GFP_NOFAIL);
 	}
 
 	atomic_set(&ht->nelems, 0);
diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index ee20e1f9bae9..cfad88651a1f 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -1226,8 +1226,8 @@ static void dmirror_device_evict_chunk(struct dmirror_chunk *chunk)
 	unsigned long *src_pfns;
 	unsigned long *dst_pfns;
 
-	src_pfns = kvcalloc(npages, sizeof(*src_pfns), GFP_KERNEL | __GFP_NOFAIL);
-	dst_pfns = kvcalloc(npages, sizeof(*dst_pfns), GFP_KERNEL | __GFP_NOFAIL);
+	src_pfns = kvcalloc(npages, sizeof(*src_pfns), GFP_KERNEL | GFP_NOFAIL);
+	dst_pfns = kvcalloc(npages, sizeof(*dst_pfns), GFP_KERNEL | GFP_NOFAIL);
 
 	migrate_device_range(src_pfns, start_pfn, npages);
 	for (i = 0; i < npages; i++) {
@@ -1241,7 +1241,7 @@ static void dmirror_device_evict_chunk(struct dmirror_chunk *chunk)
 			    !is_device_coherent_page(spage)))
 			continue;
 		spage = BACKING_PAGE(spage);
-		dpage = alloc_page(GFP_HIGHUSER_MOVABLE | __GFP_NOFAIL);
+		dpage = alloc_page(GFP_HIGHUSER_MOVABLE | GFP_NOFAIL);
 		lock_page(dpage);
 		copy_highpage(dpage, spage);
 		dst_pfns[i] = migrate_pfn(page_to_pfn(dpage));
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 9d078b37fe0b..424b543c0477 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1285,7 +1285,7 @@ static struct ceph_osd *create_osd(struct ceph_osd_client *osdc, int onum)
 
 	WARN_ON(onum == CEPH_HOMELESS_OSD);
 
-	osd = kzalloc(sizeof(*osd), GFP_NOIO | __GFP_NOFAIL);
+	osd = kzalloc(sizeof(*osd), GFP_NOIO | GFP_NOFAIL);
 	osd_init(osd);
 	osd->o_osdc = osdc;
 	osd->o_osd = onum;
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 295098873861..f760d47c6e99 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -2142,7 +2142,7 @@ void ceph_oid_copy(struct ceph_object_id *dest,
 	if (src->name != src->inline_name) {
 		/* very rare, see ceph_object_id definition */
 		dest->name = kmalloc(src->name_len + 1,
-				     GFP_NOIO | __GFP_NOFAIL);
+				     GFP_NOIO | GFP_NOFAIL);
 	} else {
 		dest->name = dest->inline_name;
 	}
@@ -2410,7 +2410,7 @@ void __ceph_object_locator_to_pg(struct ceph_pg_pool_info *pi,
 		size_t total = nsl + 1 + oid->name_len;
 
 		if (total > sizeof(stack_buf))
-			buf = kmalloc(total, GFP_NOIO | __GFP_NOFAIL);
+			buf = kmalloc(total, GFP_NOIO | GFP_NOFAIL);
 		memcpy(buf, oloc->pool_ns->str, nsl);
 		buf[nsl] = '\037';
 		memcpy(buf + nsl + 1, oid->name, oid->name_len);
diff --git a/net/core/sock.c b/net/core/sock.c
index 9abc4fe25953..fa46b1ecab0b 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3155,10 +3155,10 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 		 * In this case we cannot block, so that we have to fail.
 		 */
 		if (sk->sk_wmem_queued + size >= sk->sk_sndbuf) {
-			/* Force charge with __GFP_NOFAIL */
+			/* Force charge with GFP_NOFAIL */
 			if (memcg && !charged) {
 				mem_cgroup_charge_skmem(memcg, amt,
-					gfp_memcg_charge() | __GFP_NOFAIL);
+					gfp_memcg_charge() | GFP_NOFAIL);
 			}
 			return 1;
 		}
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 64d07b842e73..e933a54db1a7 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -732,7 +732,7 @@ struct sock *inet_csk_accept(struct sock *sk, struct proto_accept_arg *arg)
 
 		if (amt)
 			mem_cgroup_charge_skmem(newsk->sk_memcg, amt,
-						GFP_KERNEL | __GFP_NOFAIL);
+						GFP_KERNEL | GFP_NOFAIL);
 
 		release_sock(newsk);
 	}
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 16c48df8df4c..8d05ed592881 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3566,7 +3566,7 @@ void sk_forced_mem_schedule(struct sock *sk, int size)
 
 	if (mem_cgroup_sockets_enabled && sk->sk_memcg)
 		mem_cgroup_charge_skmem(sk->sk_memcg, amt,
-					gfp_memcg_charge() | __GFP_NOFAIL);
+					gfp_memcg_charge() | GFP_NOFAIL);
 }
 
 /* Send a FIN. The caller locks the socket for us.
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index e22aad7604e8..9c2df7d77886 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -694,7 +694,7 @@ static void smk_cipso_doi(void)
 		printk(KERN_WARNING "%s:%d remove rc = %d\n",
 		       __func__, __LINE__, rc);
 
-	doip = kmalloc(sizeof(struct cipso_v4_doi), GFP_KERNEL | __GFP_NOFAIL);
+	doip = kmalloc(sizeof(struct cipso_v4_doi), GFP_KERNEL | GFP_NOFAIL);
 	doip->map.std = NULL;
 	doip->doi = smk_cipso_doi_value;
 	doip->type = CIPSO_V4_MAP_PASS;
-- 
2.34.1

