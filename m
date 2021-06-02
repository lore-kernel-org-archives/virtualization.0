Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C2BC47093
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 06:55:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A208B613BD
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 06:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A208B613BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72A3D83753;
	Wed,  2 Jun 2021 06:55:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wEqTdy5Sc18Y; Wed,  2 Jun 2021 06:55:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16242836E1;
	Wed,  2 Jun 2021 06:55:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00B86C000E;
	Wed,  2 Jun 2021 06:55:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57955C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:55:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 46A82607E9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:55:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g3LAfAlxkR1Z
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:55:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6047E6079E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=+VW3u/9XCdDTbtqEZvujMXwGJbXBwfM20yjCH8e5d3E=; b=GwQP6IERGYi9h/w11aM5Gv7Bak
 KwC96m3PPXGkoyZYwi/kNvLQSakOJo8KyQC+PaSGnzJZtxZtj+EAf1YdIWxyGh1h3/ItGALtuAyht
 Zb0UCagxGAtcH3yWBInWzJjMPdgOtlr0aVxDJradU0LlW4CU0UoZ9uFlxXZ9MaFs9QpR6rJJqNKpM
 Lp+TbCyqXP0eixAsJNjUJ38MR0l0b3AJnHt9CihDHSmpFaOitPKX0HSMzdaVcLJGEB+8v4t2ImMr4
 1mz3v9UKvRtkqRqwAqZX0MDPtIqhunVVCv1zjkY4f5TbIaxRb9R62pOguo/krhQJ2ETMPxpLnqyY0
 E1fIMYVA==;
Received: from shol69.static.otenet.gr ([83.235.170.67] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loKme-0025w6-S0; Wed, 02 Jun 2021 06:55:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 19/30] nbd: use blk_mq_alloc_disk and blk_cleanup_disk
Date: Wed,  2 Jun 2021 09:53:34 +0300
Message-Id: <20210602065345.355274-20-hch@lst.de>
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
 drivers/block/nbd.c | 53 ++++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 32 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 45d2c28c8fc8..614d82e7fae4 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -219,15 +219,11 @@ static const struct device_attribute pid_attr = {
 static void nbd_dev_remove(struct nbd_device *nbd)
 {
 	struct gendisk *disk = nbd->disk;
-	struct request_queue *q;
 
 	if (disk) {
-		q = disk->queue;
 		del_gendisk(disk);
-		blk_cleanup_queue(q);
 		blk_mq_free_tag_set(&nbd->tag_set);
-		disk->private_data = NULL;
-		put_disk(disk);
+		blk_cleanup_disk(disk);
 	}
 
 	/*
@@ -1646,15 +1642,24 @@ static int nbd_dev_add(int index)
 {
 	struct nbd_device *nbd;
 	struct gendisk *disk;
-	struct request_queue *q;
 	int err = -ENOMEM;
 
 	nbd = kzalloc(sizeof(struct nbd_device), GFP_KERNEL);
 	if (!nbd)
 		goto out;
 
-	disk = alloc_disk(1 << part_shift);
-	if (!disk)
+	nbd->tag_set.ops = &nbd_mq_ops;
+	nbd->tag_set.nr_hw_queues = 1;
+	nbd->tag_set.queue_depth = 128;
+	nbd->tag_set.numa_node = NUMA_NO_NODE;
+	nbd->tag_set.cmd_size = sizeof(struct nbd_cmd);
+	nbd->tag_set.flags = BLK_MQ_F_SHOULD_MERGE |
+		BLK_MQ_F_BLOCKING;
+	nbd->tag_set.driver_data = nbd;
+	nbd->destroy_complete = NULL;
+
+	err = blk_mq_alloc_tag_set(&nbd->tag_set);
+	if (err)
 		goto out_free_nbd;
 
 	if (index >= 0) {
@@ -1668,30 +1673,15 @@ static int nbd_dev_add(int index)
 			index = err;
 	}
 	if (err < 0)
-		goto out_free_disk;
-
+		goto out_free_tags;
 	nbd->index = index;
-	nbd->disk = disk;
-	nbd->tag_set.ops = &nbd_mq_ops;
-	nbd->tag_set.nr_hw_queues = 1;
-	nbd->tag_set.queue_depth = 128;
-	nbd->tag_set.numa_node = NUMA_NO_NODE;
-	nbd->tag_set.cmd_size = sizeof(struct nbd_cmd);
-	nbd->tag_set.flags = BLK_MQ_F_SHOULD_MERGE |
-		BLK_MQ_F_BLOCKING;
-	nbd->tag_set.driver_data = nbd;
-	nbd->destroy_complete = NULL;
 
-	err = blk_mq_alloc_tag_set(&nbd->tag_set);
-	if (err)
+	disk = blk_mq_alloc_disk(&nbd->tag_set, NULL);
+	if (IS_ERR(disk)) {
+		err = PTR_ERR(disk);
 		goto out_free_idr;
-
-	q = blk_mq_init_queue(&nbd->tag_set);
-	if (IS_ERR(q)) {
-		err = PTR_ERR(q);
-		goto out_free_tags;
 	}
-	disk->queue = q;
+	nbd->disk = disk;
 
 	/*
 	 * Tell the block layer that we are not a rotational device
@@ -1712,6 +1702,7 @@ static int nbd_dev_add(int index)
 	INIT_LIST_HEAD(&nbd->list);
 	disk->major = NBD_MAJOR;
 	disk->first_minor = index << part_shift;
+	disk->minors = 1 << part_shift;
 	disk->fops = &nbd_fops;
 	disk->private_data = nbd;
 	sprintf(disk->disk_name, "nbd%d", index);
@@ -1719,12 +1710,10 @@ static int nbd_dev_add(int index)
 	nbd_total_devices++;
 	return index;
 
-out_free_tags:
-	blk_mq_free_tag_set(&nbd->tag_set);
 out_free_idr:
 	idr_remove(&nbd_index_idr, index);
-out_free_disk:
-	put_disk(disk);
+out_free_tags:
+	blk_mq_free_tag_set(&nbd->tag_set);
 out_free_nbd:
 	kfree(nbd);
 out:
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
