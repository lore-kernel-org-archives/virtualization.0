Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CC3C433FE
	for <virtualization@archiver.kernel.org>; Sat,  9 Apr 2022 04:51:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2311D424B8;
	Sat,  9 Apr 2022 04:51:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jowTnZ3FnMml; Sat,  9 Apr 2022 04:51:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6496F424B5;
	Sat,  9 Apr 2022 04:51:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B6F4C0033;
	Sat,  9 Apr 2022 04:51:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0CAE1C002C
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Apr 2022 04:51:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DD03A424B5
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Apr 2022 04:51:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WtDq9QECs9zP
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Apr 2022 04:51:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D8E2B41F61
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Apr 2022 04:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=2RG8/4DncVNJBVxiwRZlDWFw3of1TwdfVdHLgkB+Spw=; b=bHToJbTwXX9JeK0n0FFEHck7oK
 nA96qn4tsO9VvTxVN8oChK/ZngVrRM/0RF6G9ra3tv3c4LiSpAW93VdnTUb837bG7nj26lWP035AX
 +oB1LRxVd3o4RNZBzKIPVYYv/AqgqQH13jSTRjPJXLj+fHe3sQ7lQiOs0AqFOPiV0QvmbZSG1K8qh
 9AilEZ6nzAlZEnIp9Du8I20RfuJmhuvcocvyHX9G65n9qxdF8wS5MzRNFD9kn7Nula/Xd3cMLnifm
 ikockttcbAn2ou+cROly75gq/5PqLm1F2FPp9pVf438qn2667h4Aje3z8zrXhBCgwdMkGUyOJsCBu
 B0U5qlrw==;
Received: from 213-147-167-116.nat.highway.webapn.at ([213.147.167.116]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nd34Q-0020zD-BL; Sat, 09 Apr 2022 04:51:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 14/27] block: add a bdev_stable_writes helper
Date: Sat,  9 Apr 2022 06:50:30 +0200
Message-Id: <20220409045043.23593-15-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220409045043.23593-1-hch@lst.de>
References: <20220409045043.23593-1-hch@lst.de>
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
 "Martin K . Petersen" <martin.petersen@oracle.com>, linux-mmc@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
 ntfs3@lists.linux.dev, linux-btrfs@vger.kernel.org
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

Add a helper to check the stable writes flag based on the block_device
instead of having to poke into the block layer internal request_queue.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/md/dm-table.c  | 4 +---
 fs/super.c             | 2 +-
 include/linux/blkdev.h | 6 ++++++
 mm/swapfile.c          | 2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 5e38d0dd009d5..d46839faa0ca5 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1950,9 +1950,7 @@ static int device_requires_stable_pages(struct dm_target *ti,
 					struct dm_dev *dev, sector_t start,
 					sector_t len, void *data)
 {
-	struct request_queue *q = bdev_get_queue(dev->bdev);
-
-	return blk_queue_stable_writes(q);
+	return bdev_stable_writes(dev->bdev);
 }
 
 int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
diff --git a/fs/super.c b/fs/super.c
index f1d4a193602d6..60f57c7bc0a69 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1204,7 +1204,7 @@ static int set_bdev_super(struct super_block *s, void *data)
 	s->s_dev = s->s_bdev->bd_dev;
 	s->s_bdi = bdi_get(s->s_bdev->bd_disk->bdi);
 
-	if (blk_queue_stable_writes(s->s_bdev->bd_disk->queue))
+	if (bdev_stable_writes(s->s_bdev))
 		s->s_iflags |= SB_I_STABLE_WRITES;
 	return 0;
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 075b16d4560e7..a433798c3343e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1330,6 +1330,12 @@ static inline bool bdev_nonrot(struct block_device *bdev)
 	return blk_queue_nonrot(bdev_get_queue(bdev));
 }
 
+static inline bool bdev_stable_writes(struct block_device *bdev)
+{
+	return test_bit(QUEUE_FLAG_STABLE_WRITES,
+			&bdev_get_queue(bdev)->queue_flags);
+}
+
 static inline bool bdev_write_cache(struct block_device *bdev)
 {
 	return test_bit(QUEUE_FLAG_WC, &bdev_get_queue(bdev)->queue_flags);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index d5ab7ec4d92ca..4069f17a82c8e 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3065,7 +3065,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		goto bad_swap_unlock_inode;
 	}
 
-	if (p->bdev && blk_queue_stable_writes(p->bdev->bd_disk->queue))
+	if (p->bdev && bdev_stable_writes(p->bdev))
 		p->flags |= SWP_STABLE_WRITES;
 
 	if (p->bdev && p->bdev->bd_disk->fops->rw_page)
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
