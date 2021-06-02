Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D35BC47099
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 06:55:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 019F76135D
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 06:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 019F76135D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D624660889;
	Wed,  2 Jun 2021 06:55:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KGMv8vA-YOS0; Wed,  2 Jun 2021 06:55:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 782D9607BA;
	Wed,  2 Jun 2021 06:55:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54D44C000E;
	Wed,  2 Jun 2021 06:55:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1510FC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:55:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 11A6E836A7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:55:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JVa0hvVnNJmb
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:55:29 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3E10B83753
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=JLPBr5a4Ln5tpVtARufaz5Rx9DFRvnAc8JDCRXj5CBM=; b=FBI391AmGpCGer8nPkf12dCy+o
 eIEdbU42pvJv3rPD9dFUDNG20907L9ASE2fIQkUHxjUoIi8PgAItnVYsfQZ6hIztO2P1/v5yAnQCY
 AEIEL8vqjQuYY/yLZNb4GnSP5PvUwFzpizHw+fRWs4gY52j0aZwRyeKYcxL1PkeJAHD+Jt16XML9Y
 6k/bwePGimCyBX6ZWlmiXus1eyEpeartBYIhWxPwfdF5ffOhB85DbtrRd+aBJwu9lstkJ64aPi30u
 wP4A8hbv0iVNdk/AGNcCWJHaTuex2I57tAI1/KazjM7mVhow4NChmgEaGqXE5WnMhD7z0Peh8k1rH
 SZflGEZA==;
Received: from shol69.static.otenet.gr ([83.235.170.67] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loKmR-0025lm-Ax; Wed, 02 Jun 2021 06:55:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 16/30] aoe: use blk_mq_alloc_disk and blk_cleanup_disk
Date: Wed,  2 Jun 2021 09:53:31 +0300
Message-Id: <20210602065345.355274-17-hch@lst.de>
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
 drivers/block/aoe/aoeblk.c | 33 ++++++++++++---------------------
 drivers/block/aoe/aoedev.c |  3 +--
 2 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index c34e71b0c4a9..06b360f7123a 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -338,14 +338,13 @@ static const struct blk_mq_ops aoeblk_mq_ops = {
 	.queue_rq	= aoeblk_queue_rq,
 };
 
-/* alloc_disk and add_disk can sleep */
+/* blk_mq_alloc_disk and add_disk can sleep */
 void
 aoeblk_gdalloc(void *vp)
 {
 	struct aoedev *d = vp;
 	struct gendisk *gd;
 	mempool_t *mp;
-	struct request_queue *q;
 	struct blk_mq_tag_set *set;
 	ulong flags;
 	int late = 0;
@@ -362,19 +361,12 @@ aoeblk_gdalloc(void *vp)
 	if (late)
 		return;
 
-	gd = alloc_disk(AOE_PARTITIONS);
-	if (gd == NULL) {
-		pr_err("aoe: cannot allocate disk structure for %ld.%d\n",
-			d->aoemajor, d->aoeminor);
-		goto err;
-	}
-
 	mp = mempool_create(MIN_BUFS, mempool_alloc_slab, mempool_free_slab,
 		buf_pool_cache);
 	if (mp == NULL) {
 		printk(KERN_ERR "aoe: cannot allocate bufpool for %ld.%d\n",
 			d->aoemajor, d->aoeminor);
-		goto err_disk;
+		goto err;
 	}
 
 	set = &d->tag_set;
@@ -391,12 +383,11 @@ aoeblk_gdalloc(void *vp)
 		goto err_mempool;
 	}
 
-	q = blk_mq_init_queue(set);
-	if (IS_ERR(q)) {
+	gd = blk_mq_alloc_disk(set, d);
+	if (IS_ERR(gd)) {
 		pr_err("aoe: cannot allocate block queue for %ld.%d\n",
 			d->aoemajor, d->aoeminor);
-		blk_mq_free_tag_set(set);
-		goto err_mempool;
+		goto err_tagset;
 	}
 
 	spin_lock_irqsave(&d->lock, flags);
@@ -405,16 +396,16 @@ aoeblk_gdalloc(void *vp)
 	WARN_ON(d->flags & DEVFL_TKILL);
 	WARN_ON(d->gd);
 	WARN_ON(d->flags & DEVFL_UP);
-	blk_queue_max_hw_sectors(q, BLK_DEF_MAX_SECTORS);
-	blk_queue_io_opt(q, SZ_2M);
+	blk_queue_max_hw_sectors(gd->queue, BLK_DEF_MAX_SECTORS);
+	blk_queue_io_opt(gd->queue, SZ_2M);
 	d->bufpool = mp;
-	d->blkq = gd->queue = q;
-	q->queuedata = d;
+	d->blkq = gd->queue;
 	d->gd = gd;
 	if (aoe_maxsectors)
-		blk_queue_max_hw_sectors(q, aoe_maxsectors);
+		blk_queue_max_hw_sectors(gd->queue, aoe_maxsectors);
 	gd->major = AOE_MAJOR;
 	gd->first_minor = d->sysminor;
+	gd->minors = AOE_PARTITIONS;
 	gd->fops = &aoe_bdops;
 	gd->private_data = d;
 	set_capacity(gd, d->ssize);
@@ -435,10 +426,10 @@ aoeblk_gdalloc(void *vp)
 	spin_unlock_irqrestore(&d->lock, flags);
 	return;
 
+err_tagset:
+	blk_mq_free_tag_set(set);
 err_mempool:
 	mempool_destroy(mp);
-err_disk:
-	put_disk(gd);
 err:
 	spin_lock_irqsave(&d->lock, flags);
 	d->flags &= ~DEVFL_GD_NOW;
diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index e2ea2356da06..c5753c6bfe80 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -277,9 +277,8 @@ freedev(struct aoedev *d)
 	if (d->gd) {
 		aoedisk_rm_debugfs(d);
 		del_gendisk(d->gd);
-		put_disk(d->gd);
+		blk_cleanup_disk(d->gd);
 		blk_mq_free_tag_set(&d->tag_set);
-		blk_cleanup_queue(d->blkq);
 	}
 	t = d->targets;
 	e = t + d->ntargets;
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
