Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D667C47083
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 06:56:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C15161242
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 06:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C15161242
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0BFFE608F2;
	Wed,  2 Jun 2021 06:56:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wqwkAW39CpTR; Wed,  2 Jun 2021 06:56:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84B90608D0;
	Wed,  2 Jun 2021 06:56:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 605F6C0001;
	Wed,  2 Jun 2021 06:56:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDB35C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:56:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C109D403FF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:56:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g94qBz-e9l6Q
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:56:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 99409403EF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=Nt6wErfubiqnYVzweXP3z8/rIFCiMtQahAHnZtmIiWQ=; b=hKOfYl8YkpHQsdsCJlgWZugO4N
 8fA3EUPkn9+TcsNuxwOAiqb3mNj8IytqoaliRlOJGLTV2vKpHMO6rQ1hlUlt0+Mkm+c5R/1hkmkn7
 oTHREX9ZW78opJHrkSMxB5aCt3NEqpb+8QhNRYh4/wvPcfO1Rb2/ZQR+g2Eo/Q/BlHFp+u+PN1zzV
 pUp3mo54MUYKztGaP64TzrsyiDi6S2vcUaJtmVAkviIbIqZRFaDYaSgCXtB5+UEr/Ho31XLAOGGlI
 c+6ImRaQZ98uKF5v5kiT9CbtO1B6knRIsPn1hDSDTVU+kF579t+oYPcuUhzdK5Z+yGE/Xb+qFY58k
 TDv/4cKQ==;
Received: from shol69.static.otenet.gr ([83.235.170.67] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loKn5-0026La-Sd; Wed, 02 Jun 2021 06:55:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 25/30] xen-blkfront: use blk_mq_alloc_disk and blk_cleanup_disk
Date: Wed,  2 Jun 2021 09:53:40 +0300
Message-Id: <20210602065345.355274-26-hch@lst.de>
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

Use blk_mq_alloc_disk and blk_cleanup_disk to simplify the gendisk and
request_queue allocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/xen-blkfront.c | 96 +++++++++++++++---------------------
 1 file changed, 39 insertions(+), 57 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index f2c1aedcdf5a..8d49f8fa98bb 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -968,48 +968,6 @@ static void blkif_set_queue_limits(struct blkfront_info *info)
 	blk_queue_dma_alignment(rq, 511);
 }
 
-static int xlvbd_init_blk_queue(struct gendisk *gd, u16 sector_size,
-				unsigned int physical_sector_size)
-{
-	struct request_queue *rq;
-	struct blkfront_info *info = gd->private_data;
-
-	memset(&info->tag_set, 0, sizeof(info->tag_set));
-	info->tag_set.ops = &blkfront_mq_ops;
-	info->tag_set.nr_hw_queues = info->nr_rings;
-	if (HAS_EXTRA_REQ && info->max_indirect_segments == 0) {
-		/*
-		 * When indirect descriptior is not supported, the I/O request
-		 * will be split between multiple request in the ring.
-		 * To avoid problems when sending the request, divide by
-		 * 2 the depth of the queue.
-		 */
-		info->tag_set.queue_depth =  BLK_RING_SIZE(info) / 2;
-	} else
-		info->tag_set.queue_depth = BLK_RING_SIZE(info);
-	info->tag_set.numa_node = NUMA_NO_NODE;
-	info->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
-	info->tag_set.cmd_size = sizeof(struct blkif_req);
-	info->tag_set.driver_data = info;
-
-	if (blk_mq_alloc_tag_set(&info->tag_set))
-		return -EINVAL;
-	rq = blk_mq_init_queue(&info->tag_set);
-	if (IS_ERR(rq)) {
-		blk_mq_free_tag_set(&info->tag_set);
-		return PTR_ERR(rq);
-	}
-
-	rq->queuedata = info;
-	info->rq = gd->queue = rq;
-	info->gd = gd;
-	info->sector_size = sector_size;
-	info->physical_sector_size = physical_sector_size;
-	blkif_set_queue_limits(info);
-
-	return 0;
-}
-
 static const char *flush_info(struct blkfront_info *info)
 {
 	if (info->feature_flush && info->feature_fua)
@@ -1146,12 +1104,36 @@ static int xlvbd_alloc_gendisk(blkif_sector_t capacity,
 
 	err = xlbd_reserve_minors(minor, nr_minors);
 	if (err)
-		goto out;
+		return err;
 	err = -ENODEV;
 
-	gd = alloc_disk(nr_minors);
-	if (gd == NULL)
-		goto release;
+	memset(&info->tag_set, 0, sizeof(info->tag_set));
+	info->tag_set.ops = &blkfront_mq_ops;
+	info->tag_set.nr_hw_queues = info->nr_rings;
+	if (HAS_EXTRA_REQ && info->max_indirect_segments == 0) {
+		/*
+		 * When indirect descriptior is not supported, the I/O request
+		 * will be split between multiple request in the ring.
+		 * To avoid problems when sending the request, divide by
+		 * 2 the depth of the queue.
+		 */
+		info->tag_set.queue_depth =  BLK_RING_SIZE(info) / 2;
+	} else
+		info->tag_set.queue_depth = BLK_RING_SIZE(info);
+	info->tag_set.numa_node = NUMA_NO_NODE;
+	info->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+	info->tag_set.cmd_size = sizeof(struct blkif_req);
+	info->tag_set.driver_data = info;
+
+	err = blk_mq_alloc_tag_set(&info->tag_set);
+	if (err)
+		goto out_release_minors;
+
+	gd = blk_mq_alloc_disk(&info->tag_set, info);
+	if (IS_ERR(gd)) {
+		err = PTR_ERR(gd);
+		goto out_free_tag_set;
+	}
 
 	strcpy(gd->disk_name, DEV_NAME);
 	ptr = encode_disk_name(gd->disk_name + sizeof(DEV_NAME) - 1, offset);
@@ -1164,14 +1146,16 @@ static int xlvbd_alloc_gendisk(blkif_sector_t capacity,
 
 	gd->major = XENVBD_MAJOR;
 	gd->first_minor = minor;
+	gd->minors = nr_minors;
 	gd->fops = &xlvbd_block_fops;
 	gd->private_data = info;
 	set_capacity(gd, capacity);
 
-	if (xlvbd_init_blk_queue(gd, sector_size, physical_sector_size)) {
-		del_gendisk(gd);
-		goto release;
-	}
+	info->rq = gd->queue;
+	info->gd = gd;
+	info->sector_size = sector_size;
+	info->physical_sector_size = physical_sector_size;
+	blkif_set_queue_limits(info);
 
 	xlvbd_flush(info);
 
@@ -1186,9 +1170,10 @@ static int xlvbd_alloc_gendisk(blkif_sector_t capacity,
 
 	return 0;
 
- release:
+out_free_tag_set:
+	blk_mq_free_tag_set(&info->tag_set);
+out_release_minors:
 	xlbd_release_minors(minor, nr_minors);
- out:
 	return err;
 }
 
@@ -1217,12 +1202,9 @@ static void xlvbd_release_gendisk(struct blkfront_info *info)
 	nr_minors = info->gd->minors;
 	xlbd_release_minors(minor, nr_minors);
 
-	blk_cleanup_queue(info->rq);
-	blk_mq_free_tag_set(&info->tag_set);
-	info->rq = NULL;
-
-	put_disk(info->gd);
+	blk_cleanup_disk(info->gd);
 	info->gd = NULL;
+	blk_mq_free_tag_set(&info->tag_set);
 }
 
 /* Already hold rinfo->ring_lock. */
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
