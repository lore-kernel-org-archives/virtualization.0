Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2CFC433F5
	for <virtualization@archiver.kernel.org>; Wed,  6 Apr 2022 06:06:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7AD5781B14;
	Wed,  6 Apr 2022 06:06:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pqP5-hYQa3KL; Wed,  6 Apr 2022 06:06:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2621081AD7;
	Wed,  6 Apr 2022 06:06:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C3ACC002C;
	Wed,  6 Apr 2022 06:06:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2AC5EC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 06:06:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 19F6A81AEA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 06:06:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xf6mv7TS6jRO
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 06:06:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 74E0881AD7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 06:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=P8BTzfbZzMhTwk+O/5Q9S2IjdA/Er5Nl5Yd1FdZzPNs=; b=jmLLAFsmpP/kGZ+yrDJsbaGT90
 3PwfbbG3wYKmDjHmMy+UJOFVGL4TGDhECV3MOyV3UV8eSqcB0oTUed5n8oqNZktxd33ScowUP7QGh
 zbHFLMbrLKGeYKPMV8S63E/RRGEzhJrhrEAo36bmKxr9IL3fiqhq4h4HV/PV2BMnFoSisR8vXTGSe
 pm93ugKsrwSXqQ5J/PUF18cWu1plS4ueu1I2pDS3596vDa7E3hJWQLYJIHPBT5CXRTFQ5Q3FfKMQJ
 gbNfl56sQdKYZDUFA7Rmbrh+TTmjlhI2tnHxRO3P8MOrLI7+hAjFr/PXAnmPHqK5dQh0zlvNaSpaR
 rj8Pm/Qw==;
Received: from 213-225-3-188.nat.highway.a1.net ([213.225.3.188]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbyo2-003vK1-1x; Wed, 06 Apr 2022 06:06:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 14/27] block: add a bdev_max_zone_append_sectors helper
Date: Wed,  6 Apr 2022 08:05:03 +0200
Message-Id: <20220406060516.409838-15-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220406060516.409838-1-hch@lst.de>
References: <20220406060516.409838-1-hch@lst.de>
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

Add a helper to check the max supported sectors for zone append based on
the block_device instead of having to poke into the block layer internal
request_queue.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/zns.c | 3 +--
 fs/zonefs/super.c         | 3 +--
 include/linux/blkdev.h    | 6 ++++++
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index e34718b095504..82b61acf7a72b 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -34,8 +34,7 @@ static int validate_conv_zones_cb(struct blk_zone *z,
 
 bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
 {
-	struct request_queue *q = ns->bdev->bd_disk->queue;
-	u8 zasl = nvmet_zasl(queue_max_zone_append_sectors(q));
+	u8 zasl = nvmet_zasl(bdev_max_zone_append_sectors(ns->bdev));
 	struct gendisk *bd_disk = ns->bdev->bd_disk;
 	int ret;
 
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 3614c7834007d..7a63807b736c4 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -678,13 +678,12 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = file_inode(iocb->ki_filp);
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	struct block_device *bdev = inode->i_sb->s_bdev;
-	unsigned int max;
+	unsigned int max = bdev_max_zone_append_sectors(bdev);
 	struct bio *bio;
 	ssize_t size;
 	int nr_pages;
 	ssize_t ret;
 
-	max = queue_max_zone_append_sectors(bdev_get_queue(bdev));
 	max = ALIGN_DOWN(max << SECTOR_SHIFT, inode->i_sb->s_blocksize);
 	iov_iter_truncate(from, max);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a433798c3343e..f8c50b77543eb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1188,6 +1188,12 @@ static inline unsigned int queue_max_zone_append_sectors(const struct request_qu
 	return min(l->max_zone_append_sectors, l->max_sectors);
 }
 
+static inline unsigned int
+bdev_max_zone_append_sectors(struct block_device *bdev)
+{
+	return queue_max_zone_append_sectors(bdev_get_queue(bdev));
+}
+
 static inline unsigned queue_logical_block_size(const struct request_queue *q)
 {
 	int retval = 512;
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
