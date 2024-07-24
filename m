Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BD11CAA1
	for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 08:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721811366; cv=none; b=MOVc2ZFDUZb1vHHllHYSSonzEu0IJMTmuXJin//67VfKjXhlerkRC7MnUOz1EzEZ0bTqC///qzrKn31yTjs4AQyf8Ehd4R4z2XXZxlAnkNmm53VqDKTQRNU9qTxf9gMCv3ImWxrruTBZ40Uc0jG0LVmaatqc4vqIMrsKhyOpTzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721811366; c=relaxed/simple;
	bh=jd/PgWgS3T8w3knomgrbODVvecdewp4ummsl7lKrakk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZGCcd75CCAmPTz7BBB3l98oNJCnq6EhDEmEskVUXRbyxEyupfQvJHa1/6X6JrJTzjb2UoPX1uBXMTUr7a22MasAuzFYzgp3l8qdcfvfKpwFFCfSoXemKyMJP5Sfum1/fOCCpUxEEX8Dj++Nm+TcAX9omwx3iXahcTmjl1OmAVyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQDVxmVP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQDVxmVP"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc611a0f8cso6379095ad.2
        for <virtualization@lists.linux.dev>; Wed, 24 Jul 2024 01:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721811363; x=1722416163; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sr5l2PoDQntW7pen7diA9kDEWAvllnWAgEUGtFBQtxY=;
        b=IQDVxmVPsfibOoq80I0H9bqkJOD95gvx2aerOEO/v7+0K/xHDGvD8kn+a3774Yrv+m
         sl4JF1s7xgtJjBl4aRqp9drCPimgjUD/DTEIPnLwzi8Oo5YBOZQX0Ygvo39b+VB4FuvO
         K3wdcwaBGjOEL0zLfKDAGScXAEGOR7Vd6nnMfyjmlIOVUkvl788AQ2jsYh0PiK8dgUCX
         sFOh98BUSa82JtyCIhXFC1qzZkK/sdSnkkBReHhjGIWOS3LPdfaZVf/FKHhAXc3DLI+c
         xbcLXfVhaiUGmi+NC+oGqlvHCLPTNk6Ex6cG2Gf8wP+3aVEboqUiZ0+vJmnMWLsmoLU2
         m2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721811363; x=1722416163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sr5l2PoDQntW7pen7diA9kDEWAvllnWAgEUGtFBQtxY=;
        b=o9SyGVfo8+CJ1vkTm2o/su9KOZWtXWg+pFVCIWQwPfsNK8lxWPdpXbPTiLBSb2TwLK
         AsAicKAR6jGhZ9dA8oALTfjKfxhL7WiAMqdzRJ2pDHhKDcSuF4hBUu4eroQZwKVdK7vZ
         9UnziXgF1lrha4n4V8WSeRosMR22FlIRtn+eSIjOA+Q7LGFJMPS2ZpKNEKRvJs4uuCP8
         HMYpdmd7GaZfgpuUiyZMhWZTGt+azMJOKLCrr8+DfOD9mus9pxdrHmHmoMtKeoNVlqCY
         dLr+1IrQJHjqGskHaIsURiP9lGqGe1ZaF3dFASQhJZWupsRJGY3cvKCw9cF7afqDG/Si
         Letw==
X-Forwarded-Encrypted: i=1; AJvYcCVhhOcuncMmK7iegHJm/WiChQZ3Qr6KIEPGbo/Q1LAAYL34W6fQZrLyxarAuEZPDKoZcA60JkhVh/yn3T1A6/5nq7wKfG10GolC7nuhPHk=
X-Gm-Message-State: AOJu0Yy7AsjsAagOS6EeXO8RaamcpyEzTzoYSj4FU5petDfydnCfey+Q
	PUtejSCuym5QRx1zhtSMRv5+5n7eulqqYQKF85X5yYtb4yA/IHT1
X-Google-Smtp-Source: AGHT+IHHqAJFPf2gJe+CIjeS/66rCq3xfxiwRk+XdtHHfCi8++/OivS10/aAkJw/sTSnK26xSxgB9Q==
X-Received: by 2002:a17:902:d2cc:b0:1fc:57b7:995c with SMTP id d9443c01a7336-1fd7457385dmr94959655ad.7.1721811362773;
        Wed, 24 Jul 2024 01:56:02 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f31855fsm89021895ad.156.2024.07.24.01.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 01:56:02 -0700 (PDT)
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
Subject: [PATCH 0/5] mm: clarify nofail memory allocation
Date: Wed, 24 Jul 2024 20:55:39 +1200
Message-Id: <20240724085544.299090-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

__GFP_NOFAIL carries the semantics of never failing, so its callers
do not check the return value:
  %__GFP_NOFAIL: The VM implementation _must_ retry infinitely: the caller
  cannot handle allocation failures. The allocation could block
  indefinitely but will never return with failure. Testing for
  failure is pointless.

However, __GFP_NOFAIL can sometimes fail if it exceeds size limits
or is used with GFP_ATOMIC/GFP_NOWAIT in a non-sleepable context.
This can expose security vulnerabilities due to potential NULL
dereferences.

Since __GFP_NOFAIL does not support non-blocking allocation, we introduce
GFP_NOFAIL with inclusive blocking semantics and encourage using GFP_NOFAIL
as a replacement for __GFP_NOFAIL in non-mm.

If we must still fail a nofail allocation, we should trigger a BUG rather
than exposing NULL dereferences to callers who do not check the return
value.

* The discussion started from this topic:
 [PATCH RFC] mm: warn potential return NULL for kmalloc_array and
             kvmalloc_array with __GFP_NOFAIL

 https://lore.kernel.org/linux-mm/20240717230025.77361-1-21cnbao@gmail.com/

Thank you to Michal, Christoph, Vlastimil, and Hailong for all the
comments.

Barry Song (5):
  vpda: try to fix the potential crash due to misusing __GFP_NOFAIL
  mm: Document __GFP_NOFAIL must be blockable
  mm: BUG_ON to avoid NULL deference while __GFP_NOFAIL fails
  mm: Introduce GFP_NOFAIL with the inclusion of __GFP_RECLAIM
  non-mm: discourage the usage of __GFP_NOFAIL and encourage GFP_NOFAIL

 arch/powerpc/sysdev/xive/common.c             |  2 +-
 drivers/gpu/drm/drm_modeset_lock.c            |  2 +-
 drivers/gpu/drm/nouveau/nouveau_dmem.c        |  8 +++----
 drivers/gpu/drm/virtio/virtgpu_vq.c           |  2 +-
 drivers/hv/vmbus_drv.c                        |  2 +-
 drivers/infiniband/hw/cxgb4/mem.c             |  4 ++--
 drivers/md/dm-region-hash.c                   |  2 +-
 .../chelsio/inline_crypto/chtls/chtls_cm.c    |  6 ++---
 .../chelsio/inline_crypto/chtls/chtls_hw.c    |  2 +-
 drivers/target/iscsi/cxgbit/cxgbit_cm.c       |  2 +-
 drivers/tty/tty_ldisc.c                       |  2 +-
 drivers/vdpa/vdpa_user/iova_domain.c          | 24 +++++++++++++++----
 fs/bcachefs/btree_iter.c                      |  2 +-
 fs/bcachefs/fs-io-buffered.c                  |  2 +-
 fs/bcachefs/io_write.c                        |  2 +-
 fs/btrfs/extent_io.c                          |  8 +++----
 fs/buffer.c                                   |  6 ++---
 fs/erofs/fscache.c                            |  2 +-
 fs/erofs/zdata.c                              | 10 ++++----
 fs/ext4/extents.c                             |  8 +++----
 fs/ext4/extents_status.c                      |  4 ++--
 fs/ext4/mballoc.c                             | 12 +++++-----
 fs/ext4/page-io.c                             |  2 +-
 fs/f2fs/checkpoint.c                          |  2 +-
 fs/f2fs/data.c                                |  4 ++--
 fs/f2fs/f2fs.h                                |  2 +-
 fs/f2fs/node.c                                |  2 +-
 fs/fuse/dev.c                                 |  2 +-
 fs/fuse/file.c                                |  4 ++--
 fs/fuse/inode.c                               |  4 ++--
 fs/fuse/virtio_fs.c                           |  4 ++--
 fs/gfs2/meta_io.c                             |  2 +-
 fs/gfs2/rgrp.c                                |  6 ++---
 fs/gfs2/trans.c                               |  2 +-
 fs/iomap/buffered-io.c                        |  2 +-
 fs/jbd2/journal.c                             |  4 ++--
 fs/jbd2/revoke.c                              |  2 +-
 fs/jbd2/transaction.c                         |  6 ++---
 fs/notify/fanotify/fanotify.c                 |  2 +-
 fs/reiserfs/journal.c                         |  2 +-
 fs/udf/directory.c                            |  2 +-
 fs/xfs/libxfs/xfs_alloc.c                     |  2 +-
 fs/xfs/libxfs/xfs_attr_leaf.c                 |  8 +++----
 fs/xfs/libxfs/xfs_bmap.c                      |  2 +-
 fs/xfs/libxfs/xfs_btree.h                     |  2 +-
 fs/xfs/libxfs/xfs_btree_staging.c             |  2 +-
 fs/xfs/libxfs/xfs_da_btree.c                  |  8 +++----
 fs/xfs/libxfs/xfs_defer.c                     |  4 ++--
 fs/xfs/libxfs/xfs_dir2.c                      | 10 ++++----
 fs/xfs/libxfs/xfs_dir2_block.c                |  2 +-
 fs/xfs/libxfs/xfs_dir2_sf.c                   |  8 +++----
 fs/xfs/libxfs/xfs_exchmaps.c                  |  4 ++--
 fs/xfs/libxfs/xfs_iext_tree.c                 |  4 ++--
 fs/xfs/libxfs/xfs_inode_fork.c                | 14 +++++------
 fs/xfs/libxfs/xfs_refcount.c                  |  4 ++--
 fs/xfs/libxfs/xfs_rmap.c                      |  2 +-
 fs/xfs/xfs_attr_item.c                        |  8 +++----
 fs/xfs/xfs_attr_list.c                        |  2 +-
 fs/xfs/xfs_bmap_item.c                        |  6 ++---
 fs/xfs/xfs_buf.c                              |  8 +++----
 fs/xfs/xfs_buf_item.c                         |  4 ++--
 fs/xfs/xfs_buf_item_recover.c                 |  2 +-
 fs/xfs/xfs_dquot.c                            |  2 +-
 fs/xfs/xfs_exchmaps_item.c                    |  4 ++--
 fs/xfs/xfs_extent_busy.c                      |  2 +-
 fs/xfs/xfs_extfree_item.c                     | 10 ++++----
 fs/xfs/xfs_icache.c                           |  2 +-
 fs/xfs/xfs_icreate_item.c                     |  2 +-
 fs/xfs/xfs_inode_item.c                       |  2 +-
 fs/xfs/xfs_inode_item_recover.c               |  2 +-
 fs/xfs/xfs_iunlink_item.c                     |  2 +-
 fs/xfs/xfs_iwalk.c                            |  2 +-
 fs/xfs/xfs_log.c                              |  2 +-
 fs/xfs/xfs_log_cil.c                          |  2 +-
 fs/xfs/xfs_log_recover.c                      |  6 ++---
 fs/xfs/xfs_mount.c                            |  2 +-
 fs/xfs/xfs_mru_cache.c                        |  4 ++--
 fs/xfs/xfs_qm.c                               |  4 ++--
 fs/xfs/xfs_refcount_item.c                    |  8 +++----
 fs/xfs/xfs_rmap_item.c                        |  8 +++----
 fs/xfs/xfs_rtalloc.c                          |  2 +-
 fs/xfs/xfs_super.c                            |  2 +-
 fs/xfs/xfs_trans.c                            |  4 ++--
 fs/xfs/xfs_trans_dquot.c                      |  2 +-
 include/linux/buffer_head.h                   |  4 ++--
 include/linux/gfp_types.h                     |  7 ++++++
 include/linux/slab.h                          |  4 +++-
 kernel/resource.c                             |  2 +-
 lib/list-test.c                               |  8 +++----
 lib/ref_tracker.c                             |  2 +-
 lib/rhashtable.c                              |  6 ++---
 lib/test_hmm.c                                |  6 ++---
 mm/page_alloc.c                               | 10 ++++----
 mm/util.c                                     |  1 +
 net/ceph/osd_client.c                         |  2 +-
 net/ceph/osdmap.c                             |  4 ++--
 net/core/sock.c                               |  4 ++--
 net/ipv4/inet_connection_sock.c               |  2 +-
 net/ipv4/tcp_output.c                         |  2 +-
 security/smack/smackfs.c                      |  2 +-
 100 files changed, 222 insertions(+), 196 deletions(-)

-- 
2.34.1

