Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E080DC47096
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 06:56:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A94D961359
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 06:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A94D961359
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CB32403DF;
	Wed,  2 Jun 2021 06:56:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4ZiWHyJVVU1z; Wed,  2 Jun 2021 06:56:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5AEA403B1;
	Wed,  2 Jun 2021 06:56:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2FCEC000E;
	Wed,  2 Jun 2021 06:56:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B1A7C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:56:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 17CF283750
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:56:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bNmwuHltugj1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:55:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 649D083770
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=KHLITrhMPjuz4XYQlvLuyMQ6jhJjT1OoZPVERAs4yN8=; b=njrsDfxSfC2RA5qwJt2Gy1XMn7
 HMViANxKgA+mZa9oqtDL6Zln6j6l+rAT4dPLT9bnUbXsnsTaUQ0Zo+tgVqDNvAGXnfDkphiwKMj5x
 BrmkF9vTV9DOM9uH60akL46TTYkw9d/OlGWdsEyS5dZeuUHVkR/+D5uY8OBMz1zYKkYBE5WpfvDgG
 ycoy1/m6Ju0fMNbnbjt00eVfjn6eWdVzfPHvduRb/7SIu+tbYbfcP19f/+8wnLJPAKrRAtTgm/q9k
 vpFwkdSuotCuwgIKk3p5rYt00HK0RgsfLoLRKB1ml/qrcqSSpKjUq4ZUl1lZoAhTbkjqikESCazL2
 RLfCWW5Q==;
Received: from shol69.static.otenet.gr ([83.235.170.67] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loKms-00269K-Qr; Wed, 02 Jun 2021 06:55:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 22/30] rbd: use blk_mq_alloc_disk and blk_cleanup_disk
Date: Wed,  2 Jun 2021 09:53:37 +0300
Message-Id: <20210602065345.355274-23-hch@lst.de>
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
 drivers/block/rbd.c | 52 ++++++++++++++++-----------------------------
 1 file changed, 18 insertions(+), 34 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index bbb88eb009e0..531d390902dd 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4750,9 +4750,8 @@ static blk_status_t rbd_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 static void rbd_free_disk(struct rbd_device *rbd_dev)
 {
-	blk_cleanup_queue(rbd_dev->disk->queue);
+	blk_cleanup_disk(rbd_dev->disk);
 	blk_mq_free_tag_set(&rbd_dev->tag_set);
-	put_disk(rbd_dev->disk);
 	rbd_dev->disk = NULL;
 }
 
@@ -4922,22 +4921,6 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	    rbd_dev->layout.object_size * rbd_dev->layout.stripe_count;
 	int err;
 
-	/* create gendisk info */
-	disk = alloc_disk(single_major ?
-			  (1 << RBD_SINGLE_MAJOR_PART_SHIFT) :
-			  RBD_MINORS_PER_MAJOR);
-	if (!disk)
-		return -ENOMEM;
-
-	snprintf(disk->disk_name, sizeof(disk->disk_name), RBD_DRV_NAME "%d",
-		 rbd_dev->dev_id);
-	disk->major = rbd_dev->major;
-	disk->first_minor = rbd_dev->minor;
-	if (single_major)
-		disk->flags |= GENHD_FL_EXT_DEVT;
-	disk->fops = &rbd_bd_ops;
-	disk->private_data = rbd_dev;
-
 	memset(&rbd_dev->tag_set, 0, sizeof(rbd_dev->tag_set));
 	rbd_dev->tag_set.ops = &rbd_mq_ops;
 	rbd_dev->tag_set.queue_depth = rbd_dev->opts->queue_depth;
@@ -4948,13 +4931,26 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 
 	err = blk_mq_alloc_tag_set(&rbd_dev->tag_set);
 	if (err)
-		goto out_disk;
+		return err;
 
-	q = blk_mq_init_queue(&rbd_dev->tag_set);
-	if (IS_ERR(q)) {
-		err = PTR_ERR(q);
+	disk = blk_mq_alloc_disk(&rbd_dev->tag_set, rbd_dev);
+	if (IS_ERR(disk)) {
+		err = PTR_ERR(disk);
 		goto out_tag_set;
 	}
+	q = disk->queue;
+
+	snprintf(disk->disk_name, sizeof(disk->disk_name), RBD_DRV_NAME "%d",
+		 rbd_dev->dev_id);
+	disk->major = rbd_dev->major;
+	disk->first_minor = rbd_dev->minor;
+	if (single_major) {
+		disk->minors = (1 << RBD_SINGLE_MAJOR_PART_SHIFT);
+		disk->flags |= GENHD_FL_EXT_DEVT;
+	} else {
+		disk->minors = RBD_MINORS_PER_MAJOR;
+	}
+	disk->fops = &rbd_bd_ops;
 
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
 	/* QUEUE_FLAG_ADD_RANDOM is off by default for blk-mq */
@@ -4976,21 +4972,11 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	if (!ceph_test_opt(rbd_dev->rbd_client->client, NOCRC))
 		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, q);
 
-	/*
-	 * disk_release() expects a queue ref from add_disk() and will
-	 * put it.  Hold an extra ref until add_disk() is called.
-	 */
-	WARN_ON(!blk_get_queue(q));
-	disk->queue = q;
-	q->queuedata = rbd_dev;
-
 	rbd_dev->disk = disk;
 
 	return 0;
 out_tag_set:
 	blk_mq_free_tag_set(&rbd_dev->tag_set);
-out_disk:
-	put_disk(disk);
 	return err;
 }
 
@@ -7088,8 +7074,6 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 		goto err_out_image_lock;
 
 	device_add_disk(&rbd_dev->dev, rbd_dev->disk, NULL);
-	/* see rbd_init_disk() */
-	blk_put_queue(rbd_dev->disk->queue);
 
 	spin_lock(&rbd_dev_list_lock);
 	list_add_tail(&rbd_dev->node, &rbd_dev_list);
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
