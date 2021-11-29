Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F4EC433FE
	for <virtualization@archiver.kernel.org>; Mon, 29 Nov 2021 10:22:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C559340630;
	Mon, 29 Nov 2021 10:22:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cmwyUEreDITH; Mon, 29 Nov 2021 10:22:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 29528400A3;
	Mon, 29 Nov 2021 10:22:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F8E1C0042;
	Mon, 29 Nov 2021 10:22:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB986C000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 10:22:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A71C7403DF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 10:22:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5T7GXAhBjop8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 10:22:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6732A403F0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 10:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=mfRFhwIhVg2zPZROlsUurf8sjhIS8PFnhvuo/zgvKNc=; b=flj0yeai0nDNXu5WeUXJTEwJgU
 Il/4BTSdXvm2VwvMTB+FDRD1ZCpxX17CRtgL3/YX/0U5yT/hac+mk/GIdT4U/SqlnDqo8GJ/6YhpV
 tqgpqNpo03WPlDirevdh8jsIzKYPh1fDIUU5M5avRn1ATfRzgZ7JOcxcEfVjXzJuPrVZQtW1CI3Fh
 S+bZulnZXwicPa7JM/UstE1SAApWMbIBCpe9VnCH25Kp82B6h8VYSvdo8ETJLFuhpPHrAdAYQDdPY
 jcl1r3gXd0PYvb6qu2ltCrCLSiq+wrV00moHXDAeG11GX8x5LURk6LutZj1he4AS5UCKB56TnH9rl
 vEIw79Ew==;
Received: from [2001:4bb8:184:4a23:724a:c057:c7bf:4643] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrdny-0073Wt-FD; Mon, 29 Nov 2021 10:22:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 25/29] dax: return the partition offset from fs_dax_get_by_bdev
Date: Mon, 29 Nov 2021 11:21:59 +0100
Message-Id: <20211129102203.2243509-26-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211129102203.2243509-1-hch@lst.de>
References: <20211129102203.2243509-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: nvdimm@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-s390@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
 dm-devel@redhat.com, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>
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

Prepare for the removal of the block_device from the DAX I/O path by
returning the partition offset from fs_dax_get_by_bdev so that the file
systems have it at hand for use during I/O.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/super.c | 9 ++++++---
 drivers/md/dm.c     | 4 ++--
 fs/erofs/internal.h | 2 ++
 fs/erofs/super.c    | 4 ++--
 fs/ext2/ext2.h      | 1 +
 fs/ext2/super.c     | 2 +-
 fs/ext4/ext4.h      | 1 +
 fs/ext4/super.c     | 2 +-
 fs/xfs/xfs_buf.c    | 2 +-
 fs/xfs/xfs_buf.h    | 1 +
 include/linux/dax.h | 6 ++++--
 11 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 45d931aefd063..e7152a6c4cc40 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -69,17 +69,20 @@ EXPORT_SYMBOL_GPL(dax_remove_host);
 /**
  * fs_dax_get_by_bdev() - temporary lookup mechanism for filesystem-dax
  * @bdev: block device to find a dax_device for
+ * @start_off: returns the byte offset into the dax_device that @bdev starts
  */
-struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
+struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev, u64 *start_off)
 {
 	struct dax_device *dax_dev;
+	u64 part_size;
 	int id;
 
 	if (!blk_queue_dax(bdev->bd_disk->queue))
 		return NULL;
 
-	if ((get_start_sect(bdev) * SECTOR_SIZE) % PAGE_SIZE ||
-	    (bdev_nr_sectors(bdev) * SECTOR_SIZE) % PAGE_SIZE) {
+	*start_off = get_start_sect(bdev) * SECTOR_SIZE;
+	part_size = bdev_nr_sectors(bdev) * SECTOR_SIZE;
+	if (*start_off % PAGE_SIZE || part_size % PAGE_SIZE) {
 		pr_info("%pg: error: unaligned partition for dax\n", bdev);
 		return NULL;
 	}
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 4eba27e75c230..4e997c02bb0a0 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -637,7 +637,7 @@ static int open_table_device(struct table_device *td, dev_t dev,
 			     struct mapped_device *md)
 {
 	struct block_device *bdev;
-
+	u64 part_off;
 	int r;
 
 	BUG_ON(td->dm_dev.bdev);
@@ -653,7 +653,7 @@ static int open_table_device(struct table_device *td, dev_t dev,
 	}
 
 	td->dm_dev.bdev = bdev;
-	td->dm_dev.dax_dev = fs_dax_get_by_bdev(bdev);
+	td->dm_dev.dax_dev = fs_dax_get_by_bdev(bdev, &part_off);
 	return 0;
 }
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 3265688af7f9f..c1e65346e9f15 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -51,6 +51,7 @@ struct erofs_device_info {
 	char *path;
 	struct block_device *bdev;
 	struct dax_device *dax_dev;
+	u64 dax_part_off;
 
 	u32 blocks;
 	u32 mapped_blkaddr;
@@ -109,6 +110,7 @@ struct erofs_sb_info {
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	struct erofs_dev_context *devs;
 	struct dax_device *dax_dev;
+	u64 dax_part_off;
 	u64 total_blocks;
 	u32 primarydevice_blocks;
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 0aed886473c8d..71efce16024d9 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -312,7 +312,7 @@ static int erofs_init_devices(struct super_block *sb,
 			goto err_out;
 		}
 		dif->bdev = bdev;
-		dif->dax_dev = fs_dax_get_by_bdev(bdev);
+		dif->dax_dev = fs_dax_get_by_bdev(bdev, &dif->dax_part_off);
 		dif->blocks = le32_to_cpu(dis->blocks);
 		dif->mapped_blkaddr = le32_to_cpu(dis->mapped_blkaddr);
 		sbi->total_blocks += dif->blocks;
@@ -644,7 +644,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	sb->s_fs_info = sbi;
 	sbi->opt = ctx->opt;
-	sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev);
+	sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->dax_part_off);
 	sbi->devs = ctx->devs;
 	ctx->devs = NULL;
 
diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 3be9dd6412b78..d4f306aa5aceb 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -118,6 +118,7 @@ struct ext2_sb_info {
 	spinlock_t s_lock;
 	struct mb_cache *s_ea_block_cache;
 	struct dax_device *s_daxdev;
+	u64 s_dax_part_off;
 };
 
 static inline spinlock_t *
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 7e23482862e69..94f1fbd7d3ac2 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -831,7 +831,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 	}
 	sb->s_fs_info = sbi;
 	sbi->s_sb_block = sb_block;
-	sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev);
+	sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->s_dax_part_off);
 
 	spin_lock_init(&sbi->s_lock);
 	ret = -EINVAL;
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 404dd50856e5d..9cc55bcda6ba4 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1697,6 +1697,7 @@ struct ext4_sb_info {
 	 */
 	struct percpu_rw_semaphore s_writepages_rwsem;
 	struct dax_device *s_daxdev;
+	u64 s_dax_part_off;
 #ifdef CONFIG_EXT4_DEBUG
 	unsigned long s_simulate_fail;
 #endif
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 8d7e3449c6472..56228e33e52a2 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3913,7 +3913,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	if (!sbi->s_blockgroup_lock)
 		goto out_free_base;
 
-	sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev);
+	sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->s_dax_part_off);
 	sb->s_fs_info = sbi;
 	sbi->s_sb = sb;
 	sbi->s_inode_readahead_blks = EXT4_DEF_INODE_READAHEAD_BLKS;
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 4d4553ffa7050..bbb0fbd34e649 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1945,7 +1945,7 @@ xfs_alloc_buftarg(
 	btp->bt_mount = mp;
 	btp->bt_dev =  bdev->bd_dev;
 	btp->bt_bdev = bdev;
-	btp->bt_daxdev = fs_dax_get_by_bdev(bdev);
+	btp->bt_daxdev = fs_dax_get_by_bdev(bdev, &btp->bt_dax_part_off);
 
 	/*
 	 * Buffer IO error rate limiting. Limit it to no more than 10 messages
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index bd7f709f0d232..edcb6254fa6a8 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -89,6 +89,7 @@ typedef struct xfs_buftarg {
 	dev_t			bt_dev;
 	struct block_device	*bt_bdev;
 	struct dax_device	*bt_daxdev;
+	u64			bt_dax_part_off;
 	struct xfs_mount	*bt_mount;
 	unsigned int		bt_meta_sectorsize;
 	size_t			bt_meta_sectormask;
diff --git a/include/linux/dax.h b/include/linux/dax.h
index b79036743e7fa..f6f353382cc90 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -117,7 +117,8 @@ static inline void fs_put_dax(struct dax_device *dax_dev)
 	put_dax(dax_dev);
 }
 
-struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev);
+struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev,
+		u64 *start_off);
 int dax_writeback_mapping_range(struct address_space *mapping,
 		struct dax_device *dax_dev, struct writeback_control *wbc);
 
@@ -138,7 +139,8 @@ static inline void fs_put_dax(struct dax_device *dax_dev)
 {
 }
 
-static inline struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev)
+static inline struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev,
+		u64 *start_off)
 {
 	return NULL;
 }
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
