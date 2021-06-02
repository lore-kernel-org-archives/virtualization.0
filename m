Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA7DC47092
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 06:55:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC5766108C
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 06:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5766108C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9432A4035E;
	Wed,  2 Jun 2021 06:55:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dAr-dN9WcDH4; Wed,  2 Jun 2021 06:55:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6C2C40324;
	Wed,  2 Jun 2021 06:55:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BFE56C000E;
	Wed,  2 Jun 2021 06:55:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E9F8C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:55:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6C1D440324
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:55:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6TVFiVYkPgFe
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:55:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 75E1E40343
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=VKYFJ4i2fp8TEWNMfgNX8wUyWWT+i6aWdBUPvxl8r/8=; b=Kje0bT6cmZTfkyQxEo++Euls2J
 q9bXO5jBawfI5ZZjRGS03IawDLbrxJhUhzTvnTagkSofonFcJnjtZC0dS+BvJRy6582P7WupPFtDf
 YeiiT9xlBwIlX3HIpr7KUTIHfDr8j72sUD7rZUU1oNkALcPDkDl0X1EYUDita2YrN3DmOI90nfQUA
 gBWdA9G+j1xkdZAZ9F+vJTeuzyM+QXgQvwA/7khxUkXj7qUfyZB13p4qh8JGRf1c0Rpcy0rETNuYn
 ceg4VbVFwo5MAMklt15SLCAQymtkaL4oCoEvsKTQbGlTwFmOXo2sfzTaSyLUMXNv/EYWRrCaCG51D
 BG4zCUxQ==;
Received: from shol69.static.otenet.gr ([83.235.170.67] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loKly-0025TX-SP; Wed, 02 Jun 2021 06:54:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/30] mtd_blkdevs: use blk_mq_alloc_disk
Date: Wed,  2 Jun 2021 09:53:24 +0300
Message-Id: <20210602065345.355274-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210602065345.355274-1-hch@lst.de>
References: <20210602065345.355274-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Justin Sanders <justin@coraid.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Mike Snitzer <snitzer@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, dm-devel@redhat.com,
 "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Jack Wang <jinpu.wang@ionos.com>,
 Tim Waugh <tim@cyberelk.net>, linux-s390@vger.kernel.org,
 Alex Dubov <oakad@yahoo.com>, Richard Weinberger <richard@nod.at>,
 Christian Borntraeger <borntraeger@de.ibm.com>, xen-devel@lists.xenproject.org,
 Ilya Dryomov <idryomov@gmail.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Heiko Carstens <hca@linux.ibm.com>, Josef Bacik <josef@toxicpanda.com>,
 Denis Efremov <efremov@linux.com>, nbd@other.debian.org,
 linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
 Maxim Levitsky <maximlevitsky@gmail.com>, Geoff Levand <geoff@infradead.org>,
 linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
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

Use the blk_mq_alloc_disk API to simplify the gendisk and request_queue
allocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mtd/mtd_blkdevs.c | 48 ++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index fb8e12d590a1..5dc4c966ea73 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -30,11 +30,9 @@ static void blktrans_dev_release(struct kref *kref)
 	struct mtd_blktrans_dev *dev =
 		container_of(kref, struct mtd_blktrans_dev, ref);
 
-	dev->disk->private_data = NULL;
-	blk_cleanup_queue(dev->rq);
+	blk_cleanup_disk(dev->disk);
 	blk_mq_free_tag_set(dev->tag_set);
 	kfree(dev->tag_set);
-	put_disk(dev->disk);
 	list_del(&dev->list);
 	kfree(dev);
 }
@@ -354,7 +352,7 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 	if (new->devnum > (MINORMASK >> tr->part_bits) ||
 	    (tr->part_bits && new->devnum >= 27 * 26)) {
 		mutex_unlock(&blktrans_ref_mutex);
-		goto error1;
+		return ret;
 	}
 
 	list_add_tail(&new->list, &tr->devs);
@@ -366,17 +364,28 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 	if (!tr->writesect)
 		new->readonly = 1;
 
-	/* Create gendisk */
 	ret = -ENOMEM;
-	gd = alloc_disk(1 << tr->part_bits);
+	new->tag_set = kzalloc(sizeof(*new->tag_set), GFP_KERNEL);
+	if (!new->tag_set)
+		goto out_list_del;
 
-	if (!gd)
-		goto error2;
+	ret = blk_mq_alloc_sq_tag_set(new->tag_set, &mtd_mq_ops, 2,
+			BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING);
+	if (ret)
+		goto out_kfree_tag_set;
+
+	/* Create gendisk */
+	gd = blk_mq_alloc_disk(new->tag_set, new);
+	if (IS_ERR(gd)) {
+		ret = PTR_ERR(gd);
+		goto out_free_tag_set;
+	}
 
 	new->disk = gd;
 	gd->private_data = new;
 	gd->major = tr->major;
 	gd->first_minor = (new->devnum) << tr->part_bits;
+	gd->minors = 1 << tr->part_bits;
 	gd->fops = &mtd_block_ops;
 
 	if (tr->part_bits)
@@ -398,22 +407,9 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 	spin_lock_init(&new->queue_lock);
 	INIT_LIST_HEAD(&new->rq_list);
 
-	new->tag_set = kzalloc(sizeof(*new->tag_set), GFP_KERNEL);
-	if (!new->tag_set)
-		goto error3;
-
-	new->rq = blk_mq_init_sq_queue(new->tag_set, &mtd_mq_ops, 2,
-				BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING);
-	if (IS_ERR(new->rq)) {
-		ret = PTR_ERR(new->rq);
-		new->rq = NULL;
-		goto error4;
-	}
-
 	if (tr->flush)
 		blk_queue_write_cache(new->rq, true, false);
 
-	new->rq->queuedata = new;
 	blk_queue_logical_block_size(new->rq, tr->blksize);
 
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, new->rq);
@@ -437,13 +433,13 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
 		WARN_ON(ret);
 	}
 	return 0;
-error4:
+
+out_free_tag_set:
+	blk_mq_free_tag_set(new->tag_set);
+out_kfree_tag_set:
 	kfree(new->tag_set);
-error3:
-	put_disk(new->disk);
-error2:
+out_list_del:
 	list_del(&new->list);
-error1:
 	return ret;
 }
 
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
