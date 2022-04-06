Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA0DC433EF
	for <virtualization@archiver.kernel.org>; Wed,  6 Apr 2022 06:05:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E6C0540556;
	Wed,  6 Apr 2022 06:05:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yECDXMI8tA9C; Wed,  6 Apr 2022 06:05:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 69F1840126;
	Wed,  6 Apr 2022 06:05:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3888CC002C;
	Wed,  6 Apr 2022 06:05:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3975CC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 06:05:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 284F5818C2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 06:05:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kPHQac8WtXuO
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 06:05:28 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A4D3818BE
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 06:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=eIMQeXXWWkWx5FDwNbE0TlkL2lmBU9S9LJMrY9Onkc8=; b=VZ+7ypRmFaBJu2hWoqIAVoWmYj
 4xuOKPhldWs90pyh7ymg8zDgtPiY3fUX65YZt7O8odlZK2biQektgi2RBU0M6b67r5qzYVAWooKMG
 RUcSTyL9JbVdK+NxQGE8XxOqcy/ecJseZVyWJSGGYU9geNZke8bWZ+0hwzP7GapHHPs8RfgfuSXJe
 Y6P+Puu3Utc5OgunETt6hMAarqS36XMC4GrXZMgHCqwyaBIKi8AV3Se7oh/6MaZCw/a19Dt2QCcAQ
 3dQhNCC9soJ3UjvoF59FChYkHOkYI2VJYBUrVQVE7FpoCLMPp5lZq0dB9zF2n/zhNS+Ksy6vRUvVU
 mD8TTxXw==;
Received: from 213-225-3-188.nat.highway.a1.net ([213.225.3.188]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbynA-003ukl-9g; Wed, 06 Apr 2022 06:05:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: use block_device based APIs in block layer consumers
Date: Wed,  6 Apr 2022 08:04:49 +0200
Message-Id: <20220406060516.409838-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: jfs-discussion@lists.sourceforge.net, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 dm-devel@redhat.com, target-devel@vger.kernel.org,
 linux-mtd@lists.infradead.org, drbd-dev@lists.linbit.com,
 linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org,
 linux-scsi@vger.kernel.org, cluster-devel@redhat.com,
 xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org,
 linux-um@lists.infradead.org, nbd@other.debian.org,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
 linux-fsdevel@vger.kernel.org, ntfs3@lists.linux.dev,
 linux-btrfs@vger.kernel.org
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

Hi Jens,

this series cleanups up the block layer API so that APIs consumed
by file systems are (almost) only struct block_devic based, so that
file systems don't have to poke into block layer internals like the
request_queue.

I also found a bunch of existing bugs related to partition offsets
and discard so these are fixed while going along.

Diffstat:
 arch/um/drivers/ubd_kern.c           |    2 
 block/blk-core.c                     |    4 -
 block/blk-lib.c                      |  124 ++++++++++++++++++++---------------
 block/blk-mq-debugfs.c               |    2 
 block/blk-settings.c                 |   74 ++++++++++++++++++++
 block/blk.h                          |   14 ---
 block/fops.c                         |    2 
 block/genhd.c                        |    4 -
 block/ioctl.c                        |   48 ++++++++++---
 block/partitions/core.c              |   12 ---
 drivers/block/drbd/drbd_main.c       |   53 +++++++-------
 drivers/block/drbd/drbd_nl.c         |   94 +++++++++++---------------
 drivers/block/drbd/drbd_receiver.c   |   13 +--
 drivers/block/loop.c                 |   15 +---
 drivers/block/nbd.c                  |    3 
 drivers/block/null_blk/main.c        |    1 
 drivers/block/rbd.c                  |    1 
 drivers/block/rnbd/rnbd-clt.c        |    6 -
 drivers/block/rnbd/rnbd-srv-dev.h    |    8 --
 drivers/block/rnbd/rnbd-srv.c        |    5 -
 drivers/block/virtio_blk.c           |    2 
 drivers/block/xen-blkback/blkback.c  |   15 ++--
 drivers/block/xen-blkback/xenbus.c   |    9 --
 drivers/block/xen-blkfront.c         |    7 -
 drivers/block/zram/zram_drv.c        |    1 
 drivers/md/bcache/alloc.c            |    2 
 drivers/md/bcache/request.c          |    4 -
 drivers/md/bcache/super.c            |    3 
 drivers/md/bcache/sysfs.c            |    2 
 drivers/md/dm-cache-target.c         |    9 --
 drivers/md/dm-clone-target.c         |    9 --
 drivers/md/dm-io.c                   |    2 
 drivers/md/dm-log-writes.c           |    3 
 drivers/md/dm-raid.c                 |    9 --
 drivers/md/dm-table.c                |   25 +------
 drivers/md/dm-thin.c                 |   15 ----
 drivers/md/dm.c                      |    3 
 drivers/md/md-linear.c               |   11 ---
 drivers/md/md.c                      |    5 -
 drivers/md/raid0.c                   |    7 -
 drivers/md/raid1.c                   |   18 -----
 drivers/md/raid10.c                  |   20 -----
 drivers/md/raid5-cache.c             |    8 +-
 drivers/md/raid5.c                   |   14 +--
 drivers/mmc/core/queue.c             |    3 
 drivers/mtd/mtd_blkdevs.c            |    1 
 drivers/nvme/host/core.c             |    6 -
 drivers/nvme/target/io-cmd-bdev.c    |    2 
 drivers/nvme/target/zns.c            |    3 
 drivers/s390/block/dasd_fba.c        |    1 
 drivers/scsi/sd.c                    |    2 
 drivers/target/target_core_device.c  |   19 ++---
 drivers/target/target_core_file.c    |   10 +-
 drivers/target/target_core_iblock.c  |   17 +---
 fs/btrfs/disk-io.c                   |    3 
 fs/btrfs/extent-tree.c               |    8 +-
 fs/btrfs/ioctl.c                     |   12 +--
 fs/btrfs/volumes.c                   |    4 -
 fs/btrfs/zoned.c                     |    3 
 fs/direct-io.c                       |   32 +--------
 fs/exfat/file.c                      |    5 -
 fs/exfat/super.c                     |   10 --
 fs/ext4/ioctl.c                      |   10 --
 fs/ext4/mballoc.c                    |   10 +-
 fs/ext4/super.c                      |   10 --
 fs/f2fs/f2fs.h                       |    3 
 fs/f2fs/file.c                       |   19 ++---
 fs/f2fs/segment.c                    |    8 --
 fs/fat/file.c                        |    5 -
 fs/fat/inode.c                       |   10 --
 fs/gfs2/rgrp.c                       |    7 -
 fs/iomap/direct-io.c                 |    3 
 fs/jbd2/journal.c                    |    9 --
 fs/jfs/ioctl.c                       |    5 -
 fs/jfs/super.c                       |    8 --
 fs/nilfs2/ioctl.c                    |    6 -
 fs/nilfs2/sufile.c                   |    4 -
 fs/nilfs2/the_nilfs.c                |    4 -
 fs/ntfs3/file.c                      |    6 -
 fs/ntfs3/super.c                     |   10 +-
 fs/ocfs2/ioctl.c                     |    5 -
 fs/super.c                           |    2 
 fs/xfs/xfs_discard.c                 |    8 +-
 fs/xfs/xfs_log_cil.c                 |    2 
 fs/xfs/xfs_super.c                   |   12 +--
 fs/zonefs/super.c                    |    3 
 include/linux/blkdev.h               |  112 +++++++++++--------------------
 include/target/target_core_backend.h |    4 -
 mm/swapfile.c                        |   31 ++------
 89 files changed, 493 insertions(+), 652 deletions(-)
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
