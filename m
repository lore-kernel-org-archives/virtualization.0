Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B59C433EF
	for <virtualization@archiver.kernel.org>; Wed,  2 Feb 2022 15:57:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1A31416DD;
	Wed,  2 Feb 2022 15:57:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gsGJ6g3obJPr; Wed,  2 Feb 2022 15:57:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 91877416DC;
	Wed,  2 Feb 2022 15:57:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66EC3C0011;
	Wed,  2 Feb 2022 15:57:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8211C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 15:57:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B5DC684022
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 15:57:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CNcjLT7fG-71
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 15:57:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 307E384021
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Feb 2022 15:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=Sw3T8I6YXMWb2jiqB7QUc/okYU5X2+bEkOeoAGfg6Ak=; b=BMexVoq5xuoiPG2lI6P0lGhyYj
 zTa3iwiJpJwjT/yz0eaxXfNumeqM9ruwkrzLm053Jr8vTaU3+8KQ8rLygAjplLm224EVEUMA7onq7
 L1Hvz8CHLUsPXIX16p+wnUPJ+EaA6AY2lxWtazI+fM+KGm4vEzO29DPi2LjGh1NBMJxtjxMohV19n
 SFFW0ZtunsA8WPYQ3Dw7PutON+S4ep9n35bFj3+mURkKPf3UQGhkjSUDPtvOlbfDAxlFX2kjppcqD
 7CaNLH/6ZufjOOaHcrOOgT+bqjhTajMPQTAZtXwyk0a6x7/pgtAYQ9f1bWhFLjutiL/mEYa7zL8DW
 FaXwRgsQ==;
Received: from [2001:4bb8:191:327d:b3e5:1ccd:eaac:6609] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFI0H-00G6Ww-7q; Wed, 02 Feb 2022 15:57:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/5] block: add a ->free_disk method
Date: Wed,  2 Feb 2022 16:56:55 +0100
Message-Id: <20220202155659.107895-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202155659.107895-1-hch@lst.de>
References: <20220202155659.107895-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-mmc@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
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

Add a method to notify the driver that the gendisk is about to be freed.
This allows drivers to tie the lifetime of their private data to that of
the gendisk and thus deal with device removal races without expensive
synchronization and boilerplate code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c          | 4 ++++
 include/linux/blkdev.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 9589d1d59afab..1a650c55d7626 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1119,6 +1119,10 @@ static void disk_release(struct device *dev)
 	xa_destroy(&disk->part_tbl);
 	disk->queue->disk = NULL;
 	blk_put_queue(disk->queue);
+
+	if (disk->fops->free_disk)
+		disk->fops->free_disk(disk);
+
 	iput(disk->part0->bd_inode);	/* frees the disk */
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3bfc75a2a4509..a8f8aa4671037 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1464,6 +1464,7 @@ struct block_device_operations {
 	void (*unlock_native_capacity) (struct gendisk *);
 	int (*getgeo)(struct block_device *, struct hd_geometry *);
 	int (*set_read_only)(struct block_device *bdev, bool ro);
+	void (*free_disk)(struct gendisk *disk);
 	/* this callback is with swap_lock and sometimes page table lock held */
 	void (*swap_slot_free_notify) (struct block_device *, unsigned long);
 	int (*report_zones)(struct gendisk *, sector_t sector,
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
