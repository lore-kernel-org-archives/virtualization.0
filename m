Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B283C38A06
	for <virtualization@archiver.kernel.org>; Fri, 15 Apr 2022 04:54:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D917F40439;
	Fri, 15 Apr 2022 04:54:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MFTsnlTEAXvN; Fri, 15 Apr 2022 04:54:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 86FDA405B3;
	Fri, 15 Apr 2022 04:54:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9972C0086;
	Fri, 15 Apr 2022 04:54:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21069C002C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 04:54:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F191340439
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 04:54:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8V7yzTrm7Yrm
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 04:54:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 660F3405B3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 04:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=J+DlKJplDF1Q+uvJsRC9/x84m39e7OAPqS6lbIf59go=; b=SEeH/79eKPqdW8SzrNl3V2nOHl
 ZWhXxUOKMmxbomD4h47qxDHhmZR1AcrilsdsHynv3whZecHSbjPQD1q9d/FU6+E8K/5xf+VTFPZEC
 yjptUXDEOozEKnhNef4pA/iH+U6X5UT2a4kDQV1dcB4OMBiR7EqjwvZGUpUqzaw/ctS1BK7jfj0ET
 6bEbZ634DG1jUBSD4gMSefXlbHX9s1oVYHaM3eb8uWhP4KXYOa4yPkTPaEVS3k17D/+asg++w51Tw
 tL9Bw3UnRO/ROF9NNLI3S4GrxiqTSBVA9Nyw52Y9tkIfGW9lfoR4Uoz9tWbp7jnXJX8faoVQRTg4x
 Z/Iw+o9w==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nfDy6-008PUJ-Fn; Fri, 15 Apr 2022 04:54:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 19/27] block: remove queue_discard_alignment
Date: Fri, 15 Apr 2022 06:52:50 +0200
Message-Id: <20220415045258.199825-20-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220415045258.199825-1-hch@lst.de>
References: <20220415045258.199825-1-hch@lst.de>
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

Just use bdev_alignment_offset in disk_discard_alignment_show instead.
That helpers is the same except for an always false branch that doesn't
matter in this slow path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/genhd.c          | 2 +-
 include/linux/blkdev.h | 8 --------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 712031ce19070..36532b9318419 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1019,7 +1019,7 @@ static ssize_t disk_discard_alignment_show(struct device *dev,
 {
 	struct gendisk *disk = dev_to_disk(dev);
 
-	return sprintf(buf, "%d\n", queue_discard_alignment(disk->queue));
+	return sprintf(buf, "%d\n", bdev_alignment_offset(disk->part0));
 }
 
 static ssize_t diskseq_show(struct device *dev,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 0a1795ac26275..5a9b7aeda010b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1253,14 +1253,6 @@ bdev_zone_write_granularity(struct block_device *bdev)
 
 int bdev_alignment_offset(struct block_device *bdev);
 
-static inline int queue_discard_alignment(const struct request_queue *q)
-{
-	if (q->limits.discard_misaligned)
-		return -1;
-
-	return q->limits.discard_alignment;
-}
-
 static inline int queue_limit_discard_alignment(struct queue_limits *lim, sector_t sector)
 {
 	unsigned int alignment, granularity, offset;
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
