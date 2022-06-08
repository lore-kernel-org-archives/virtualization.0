Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC515CCA487
	for <virtualization@archiver.kernel.org>; Wed,  8 Jun 2022 15:03:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 975F261435;
	Wed,  8 Jun 2022 15:03:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8GRXrccYO5PC; Wed,  8 Jun 2022 15:03:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 50ADF60E76;
	Wed,  8 Jun 2022 15:03:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 292ECC0081;
	Wed,  8 Jun 2022 15:03:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80FE5C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 15:03:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5CC6A40B24
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 15:03:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JRgOLm7hv38U
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 15:03:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9C18D4097E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 15:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=C8q0R+e/rBy0+WV0269yeWJ3JYLa6mvxcMU049tzAMQ=; b=CS/ArOOFgUazhgBuVIhXoz92Iz
 tLP1+UzjBKtIQ7Dy/5NVLgAnvWWvYfAukTChPBXBJHel7m/rRcIG1jTO3m2SVgS4dQ2RCnrpnI/2B
 9iKrigIdgG1UysTmv8VlwqX324N8NrztRT9jaBzDbk+mLDdYbNW5pr4mZOlj2VneHAgPoio17IYwj
 m/4vzv2MBPDQc303p8MvgJU+5ViW9y/S2mis6sPjvcMV3XgTzYLKOwdVsPPuf7dw1p/zkAkFsZwEO
 lx/oyhsuVa0FzBkMKs3shdhPr6iBtAans8vQe+2EUQiQ7GyfqEuQkKrwSdQNjedKZMBZwIoJM8JrF
 UgeRmSEA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nyxCt-00CjFE-KF; Wed, 08 Jun 2022 15:02:51 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 00/19] Convert aops->migratepage to aops->migrate_folio
Date: Wed,  8 Jun 2022 16:02:30 +0100
Message-Id: <20220608150249.3033815-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Cc: linux-aio@kvack.org, linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
 linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com,
 linux-ext4@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
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

We're getting to the last aops that take a struct page.  The only
remaining ones are ->writepage, ->write_begin, ->write_end and
->error_remove_page.

Changes from v1:
 - Remove ->isolate_page from secretmem
 - Split the movable_operations from address_space_operations
 - Drop the conversions of balloon, zsmalloc and z3fold
 - Fix the build errors with hugetlbfs
 - Fix the kerneldoc errors
 - Fix the ;; typo

Matthew Wilcox (Oracle) (19):
  secretmem: Remove isolate_page
  mm: Convert all PageMovable users to movable_operations
  fs: Add aops->migrate_folio
  mm/migrate: Convert fallback_migrate_page() to
    fallback_migrate_folio()
  mm/migrate: Convert writeout() to take a folio
  mm/migrate: Convert buffer_migrate_page() to buffer_migrate_folio()
  mm/migrate: Convert expected_page_refs() to folio_expected_refs()
  btrfs: Convert btree_migratepage to migrate_folio
  nfs: Convert to migrate_folio
  mm/migrate: Convert migrate_page() to migrate_folio()
  mm/migrate: Add filemap_migrate_folio()
  btrfs: Convert btrfs_migratepage to migrate_folio
  ubifs: Convert to filemap_migrate_folio()
  f2fs: Convert to filemap_migrate_folio()
  aio: Convert to migrate_folio
  hugetlb: Convert to migrate_folio
  secretmem: Convert to migrate_folio
  fs: Remove aops->migratepage()
  mm/folio-compat: Remove migration compatibility functions

 Documentation/filesystems/locking.rst       |   5 +-
 Documentation/filesystems/vfs.rst           |  13 +-
 Documentation/vm/page_migration.rst         |  33 +--
 arch/powerpc/platforms/pseries/cmm.c        |  60 +----
 block/fops.c                                |   2 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c |   4 +-
 drivers/misc/vmw_balloon.c                  |  61 +----
 drivers/virtio/virtio_balloon.c             |  47 +---
 fs/aio.c                                    |  36 +--
 fs/btrfs/disk-io.c                          |  22 +-
 fs/btrfs/inode.c                            |  26 +--
 fs/ext2/inode.c                             |   4 +-
 fs/ext4/inode.c                             |   4 +-
 fs/f2fs/checkpoint.c                        |   4 +-
 fs/f2fs/data.c                              |  40 +---
 fs/f2fs/f2fs.h                              |   4 -
 fs/f2fs/node.c                              |   4 +-
 fs/gfs2/aops.c                              |   2 +-
 fs/hugetlbfs/inode.c                        |  23 +-
 fs/iomap/buffered-io.c                      |  25 --
 fs/nfs/file.c                               |   4 +-
 fs/nfs/internal.h                           |   6 +-
 fs/nfs/write.c                              |  16 +-
 fs/ntfs/aops.c                              |   6 +-
 fs/ocfs2/aops.c                             |   2 +-
 fs/ubifs/file.c                             |  29 +--
 fs/xfs/xfs_aops.c                           |   2 +-
 fs/zonefs/super.c                           |   2 +-
 include/linux/balloon_compaction.h          |   6 +-
 include/linux/buffer_head.h                 |  10 +
 include/linux/fs.h                          |  20 +-
 include/linux/iomap.h                       |   6 -
 include/linux/migrate.h                     |  48 ++--
 include/linux/page-flags.h                  |   2 +-
 include/linux/pagemap.h                     |   6 +
 include/uapi/linux/magic.h                  |   4 -
 mm/balloon_compaction.c                     |  10 +-
 mm/compaction.c                             |  34 ++-
 mm/folio-compat.c                           |  22 --
 mm/ksm.c                                    |   2 +-
 mm/migrate.c                                | 238 ++++++++++++--------
 mm/migrate_device.c                         |   3 +-
 mm/secretmem.c                              |  13 +-
 mm/shmem.c                                  |   2 +-
 mm/swap_state.c                             |   2 +-
 mm/util.c                                   |   4 +-
 mm/z3fold.c                                 |  82 +------
 mm/zsmalloc.c                               | 102 ++-------
 48 files changed, 367 insertions(+), 735 deletions(-)

-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
