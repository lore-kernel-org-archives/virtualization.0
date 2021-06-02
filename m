Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFFBC4708F
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 06:55:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FCC16108C
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 06:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FCC16108C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C3B0608B7;
	Wed,  2 Jun 2021 06:55:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SyPGC5IyMN6w; Wed,  2 Jun 2021 06:55:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD8D8608A6;
	Wed,  2 Jun 2021 06:55:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A794AC000E;
	Wed,  2 Jun 2021 06:55:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C626AC0024
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:55:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B5798608A6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:55:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nic5socSzCbb
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:55:16 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 070AA607E9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=pV41u4G0u0xaNGxoxDb/eyNeH9eLbF/Aei3AXX+HWdY=; b=xynVkbApPKJ1V6SCFnDhqzTRhk
 HG0wUR2lljnrg8jjaBi3fB5wReJl4j8YP38RFTuxGHRPiXc3MvRjlT3pljHnX0XyyZXySOVGvD36r
 Yn+kDsgqGIGCgFW7UzE2sDUrTXFZpZSvReujYSqg/GDnk+jMrGw/l7eQr8EmpYPtyi2dlKoDQZniQ
 A295rgd6IcGuhT/qNWGyPQm803gvicBX9TIVBVODY+wwREKWrX67HS+VcQ/s9Gl/7xUWi6bQoGvGi
 xaTI/gKDuismLjMiDlvwEAfqkBTMh3FXwJk3/FqJCq/s8UQ5jthfbUwng9lkO26oujqiNf9SJQcbE
 JqveapQg==;
Received: from shol69.static.otenet.gr ([83.235.170.67] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loKmD-0025eq-Jk; Wed, 02 Jun 2021 06:54:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 13/30] sunvdc: use blk_mq_alloc_disk
Date: Wed,  2 Jun 2021 09:53:28 +0300
Message-Id: <20210602065345.355274-14-hch@lst.de>
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
 drivers/block/sunvdc.c | 47 ++++++++++++------------------------------
 1 file changed, 13 insertions(+), 34 deletions(-)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 39aeebc6837d..c53b38578bb7 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -780,27 +780,6 @@ static const struct blk_mq_ops vdc_mq_ops = {
 	.queue_rq	= vdc_queue_rq,
 };
 
-static void cleanup_queue(struct request_queue *q)
-{
-	struct vdc_port *port = q->queuedata;
-
-	blk_cleanup_queue(q);
-	blk_mq_free_tag_set(&port->tag_set);
-}
-
-static struct request_queue *init_queue(struct vdc_port *port)
-{
-	struct request_queue *q;
-
-	q = blk_mq_init_sq_queue(&port->tag_set, &vdc_mq_ops, VDC_TX_RING_SIZE,
-					BLK_MQ_F_SHOULD_MERGE);
-	if (IS_ERR(q))
-		return q;
-
-	q->queuedata = port;
-	return q;
-}
-
 static int probe_disk(struct vdc_port *port)
 {
 	struct request_queue *q;
@@ -838,21 +817,21 @@ static int probe_disk(struct vdc_port *port)
 				    (u64)geom.num_sec);
 	}
 
-	q = init_queue(port);
-	if (IS_ERR(q)) {
-		printk(KERN_ERR PFX "%s: Could not allocate queue.\n",
-		       port->vio.name);
-		return PTR_ERR(q);
-	}
-	g = alloc_disk(1 << PARTITION_SHIFT);
-	if (!g) {
+	err = blk_mq_alloc_sq_tag_set(&port->tag_set, &vdc_mq_ops,
+			VDC_TX_RING_SIZE, BLK_MQ_F_SHOULD_MERGE);
+	if (err)
+		return err;
+
+	g = blk_mq_alloc_disk(&port->tag_set, port);
+	if (IS_ERR(g)) {
 		printk(KERN_ERR PFX "%s: Could not allocate gendisk.\n",
 		       port->vio.name);
-		cleanup_queue(q);
-		return -ENOMEM;
+		blk_mq_free_tag_set(&port->tag_set);
+		return PTR_ERR(g);
 	}
 
 	port->disk = g;
+	q = g->queue;
 
 	/* Each segment in a request is up to an aligned page in size. */
 	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
@@ -862,6 +841,7 @@ static int probe_disk(struct vdc_port *port)
 	blk_queue_max_hw_sectors(q, port->max_xfer_size);
 	g->major = vdc_major;
 	g->first_minor = port->vio.vdev->dev_no << PARTITION_SHIFT;
+	g->minors = 1 << PARTITION_SHIFT;
 	strcpy(g->disk_name, port->disk_name);
 
 	g->fops = &vdc_fops;
@@ -1083,9 +1063,8 @@ static int vdc_port_remove(struct vio_dev *vdev)
 		del_timer_sync(&port->vio.timer);
 
 		del_gendisk(port->disk);
-		cleanup_queue(port->disk->queue);
-		put_disk(port->disk);
-		port->disk = NULL;
+		blk_cleanup_disk(port->disk);
+		blk_mq_free_tag_set(&port->tag_set);
 
 		vdc_free_tx_ring(port);
 		vio_ldc_free(&port->vio);
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
