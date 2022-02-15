Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EDAC3525A
	for <virtualization@archiver.kernel.org>; Tue, 15 Feb 2022 09:45:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3120482C33;
	Tue, 15 Feb 2022 09:45:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tn_sXByuS7Lj; Tue, 15 Feb 2022 09:45:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D1804826C0;
	Tue, 15 Feb 2022 09:45:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB603C0011;
	Tue, 15 Feb 2022 09:45:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 388AFC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 09:45:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2B19F415B3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 09:45:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QIiMxzttGDjG
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 09:45:31 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A2249415AB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 09:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=M/k0M/YRhjeaZRYqG7d2lMZ9R/cEqFwtMhYSGaXiMyo=; b=rjNE9tRjeLvNV+viXnfwqakzHK
 0yyDr6Ea7RXNCCA00xMGq6MPjjMjFZ3b63bPyWlIMpoQga/k/pYqL4gnRgLnqEPLY4sgDiovPhXb9
 lzSu+OVAg6R/O/Ew//V8V3H/sKk7iQ14RsSYuqcHx9GcSqGtuqnhcP7Em8eas/D54uhfjy25lKcRt
 Al5V9hyDNbaFkwB270BYoq8i8na2/GVZqAs34a7LvAaawWiS5BQAUnBGBdFOfb+TtlUQY1y3GWwwb
 ox7DrhHX7DvTJAfeBM0Cuuz5RRqgDhwBSUQ6i5b75sLsNfDUe/gnVQou6uEroDCdl4apPA0ako8vq
 yIBkEvjw==;
Received: from [2001:4bb8:184:543c:6bdf:22f4:7f0a:fe97] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJuOd-00260q-UE; Tue, 15 Feb 2022 09:45:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/5] block: add a ->free_disk method
Date: Tue, 15 Feb 2022 10:45:10 +0100
Message-Id: <20220215094514.3828912-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220215094514.3828912-1-hch@lst.de>
References: <20220215094514.3828912-1-hch@lst.de>
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

A new flag is added so that ->free_disk is only called after a successful
call to add_disk, which significantly simplifies the error handling path
during probing.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c          | 5 +++++
 include/linux/blkdev.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 9589d1d59afab..e351fac41bf25 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -526,6 +526,7 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 
 	disk_update_readahead(disk);
 	disk_add_events(disk);
+	set_bit(GD_ADDED, &disk->state);
 	return 0;
 
 out_unregister_bdi:
@@ -1119,6 +1120,10 @@ static void disk_release(struct device *dev)
 	xa_destroy(&disk->part_tbl);
 	disk->queue->disk = NULL;
 	blk_put_queue(disk->queue);
+
+	if (test_bit(GD_ADDED, &disk->state) && disk->fops->free_disk)
+		disk->fops->free_disk(disk);
+
 	iput(disk->part0->bd_inode);	/* frees the disk */
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3bfc75a2a4509..f757f9c2871f8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -146,6 +146,7 @@ struct gendisk {
 #define GD_READ_ONLY			1
 #define GD_DEAD				2
 #define GD_NATIVE_CAPACITY		3
+#define GD_ADDED			4
 
 	struct mutex open_mutex;	/* open/close mutex */
 	unsigned open_partitions;	/* number of open partitions */
@@ -1464,6 +1465,7 @@ struct block_device_operations {
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
