Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2703CC4708F
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 06:56:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1306108C
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 06:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1306108C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AFADE403D7;
	Wed,  2 Jun 2021 06:56:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t5yk3FNGAhfM; Wed,  2 Jun 2021 06:56:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 066F34034B;
	Wed,  2 Jun 2021 06:56:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D65A2C000E;
	Wed,  2 Jun 2021 06:56:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05477C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:56:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D991C608D0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:56:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e1qq5ieOtLkS
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:56:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 22A59608EF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=5mJAZZeO1CtG3mn2Yuq3t9OP/z6HiPXlonifU+Xv8uk=; b=tt3BlzEvyR33jB2X0kDiZ5TSxB
 csELHSnmlT8T6KUWOPDXdz45J2xQyFQU19xaezbdVZgeUVrTi9u9ZPTPO6fqT1nm0qE2v7SVLycE9
 /MOWrjDcC/xYy6qBU13Znm79Ch9jRwtBbUtbfzUmR+I9pRspaNFEvyOXmYvNfXgWZsh0TdBvJLp4s
 /Fr3RVYTz9uY0FffL4ddTLGXqxR4LHnzHncqok0pz2PtYl2ZKi5VfjzMdqvx8SDrYpymOwhWqr6QX
 Z9xSFfPHVSbsRQooQMBqPIpILAv/Gx+wWjK7rLtRMYAMdC9wtpz/a7ziP04g4HcPFPbwAdib7nnbG
 Ptr9BkmA==;
Received: from shol69.static.otenet.gr ([83.235.170.67] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loKmx-0026Co-6G; Wed, 02 Jun 2021 06:55:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 23/30] rnbd: use blk_mq_alloc_disk and blk_cleanup_disk
Date: Wed,  2 Jun 2021 09:53:38 +0300
Message-Id: <20210602065345.355274-24-hch@lst.de>
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
 drivers/block/rnbd/rnbd-clt.c | 35 ++++++++---------------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index c604a402cd5c..f4fa45d24c0b 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1353,18 +1353,6 @@ static void rnbd_init_mq_hw_queues(struct rnbd_clt_dev *dev)
 	}
 }
 
-static int setup_mq_dev(struct rnbd_clt_dev *dev)
-{
-	dev->queue = blk_mq_init_queue(&dev->sess->tag_set);
-	if (IS_ERR(dev->queue)) {
-		rnbd_clt_err(dev, "Initializing multiqueue queue failed, err: %ld\n",
-			      PTR_ERR(dev->queue));
-		return PTR_ERR(dev->queue);
-	}
-	rnbd_init_mq_hw_queues(dev);
-	return 0;
-}
-
 static void setup_request_queue(struct rnbd_clt_dev *dev)
 {
 	blk_queue_logical_block_size(dev->queue, dev->logical_block_size);
@@ -1393,13 +1381,13 @@ static void setup_request_queue(struct rnbd_clt_dev *dev)
 	blk_queue_io_opt(dev->queue, dev->sess->max_io_size);
 	blk_queue_virt_boundary(dev->queue, SZ_4K - 1);
 	blk_queue_write_cache(dev->queue, dev->wc, dev->fua);
-	dev->queue->queuedata = dev;
 }
 
 static void rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev, int idx)
 {
 	dev->gd->major		= rnbd_client_major;
 	dev->gd->first_minor	= idx << RNBD_PART_BITS;
+	dev->gd->minors		= 1 << RNBD_PART_BITS;
 	dev->gd->fops		= &rnbd_client_ops;
 	dev->gd->queue		= dev->queue;
 	dev->gd->private_data	= dev;
@@ -1426,24 +1414,18 @@ static void rnbd_clt_setup_gen_disk(struct rnbd_clt_dev *dev, int idx)
 
 static int rnbd_client_setup_device(struct rnbd_clt_dev *dev)
 {
-	int err, idx = dev->clt_device_id;
+	int idx = dev->clt_device_id;
 
 	dev->size = dev->nsectors * dev->logical_block_size;
 
-	err = setup_mq_dev(dev);
-	if (err)
-		return err;
+	dev->gd = blk_mq_alloc_disk(&dev->sess->tag_set, dev);
+	if (IS_ERR(dev->gd))
+		return PTR_ERR(dev->gd);
+	dev->queue = dev->gd->queue;
+	rnbd_init_mq_hw_queues(dev);
 
 	setup_request_queue(dev);
-
-	dev->gd = alloc_disk_node(1 << RNBD_PART_BITS,	NUMA_NO_NODE);
-	if (!dev->gd) {
-		blk_cleanup_queue(dev->queue);
-		return -ENOMEM;
-	}
-
 	rnbd_clt_setup_gen_disk(dev, idx);
-
 	return 0;
 }
 
@@ -1650,8 +1632,7 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 static void destroy_gen_disk(struct rnbd_clt_dev *dev)
 {
 	del_gendisk(dev->gd);
-	blk_cleanup_queue(dev->queue);
-	put_disk(dev->gd);
+	blk_cleanup_disk(dev->gd);
 }
 
 static void destroy_sysfs(struct rnbd_clt_dev *dev,
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
