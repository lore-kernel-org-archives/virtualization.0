Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279DDC47092
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 06:55:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5DAD6135D
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 06:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5DAD6135D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4EC883668;
	Wed,  2 Jun 2021 06:55:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n_TfFMZy-XBR; Wed,  2 Jun 2021 06:55:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 69CA283653;
	Wed,  2 Jun 2021 06:55:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44ABEC000E;
	Wed,  2 Jun 2021 06:55:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15811C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:55:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 02BE060889
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:55:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SKCqEWgjNdl5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:55:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 46CF4607E9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=qi7AU80Oz7hj4K5BUy3Hu3UJMfMiprlsOMq1LlDbVww=; b=wfnn0CGP9teCIUigpA0cLAiCEG
 XaYeXRoQvQOrEfJFcuxKu18rxlCj9kAVnqYvA6ffbosWHxomIXQsSArr+ftwbguMp5SU3M9/bmk0L
 bqzQ8XiTRZ6QBfzP4K/UHsKW47GVQnDBFuGf6p23+3crdLQ2ThNz4kvRi6KgNmbzK/nin+yjIgWxz
 6kQGuIL3DvYz9Jv29HP0rZaCMuA/qvMMWQpgEREhwRn38bXZiX53OXpalBkps4hZhmquoC2R0dNpO
 luUD0oRku7pr6gfgS8FYvxXuSkXea92js4/YEKQkinqriGTLqiSIzKawm91/GTGJJNVz/av0Gu21E
 TAsHH4GQ==;
Received: from shol69.static.otenet.gr ([83.235.170.67] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loKm6-0025Ys-7i; Wed, 02 Jun 2021 06:54:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/30] swim3: use blk_mq_alloc_disk
Date: Wed,  2 Jun 2021 09:53:26 +0300
Message-Id: <20210602065345.355274-12-hch@lst.de>
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
 drivers/block/swim3.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index a515d0c1d2cb..965af0a3e95b 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -1202,30 +1202,27 @@ static int swim3_attach(struct macio_dev *mdev,
 			return rc;
 	}
 
-	disk = alloc_disk(1);
-	if (disk == NULL) {
-		rc = -ENOMEM;
-		goto out_unregister;
-	}
-
 	fs = &floppy_states[floppy_count];
 	memset(fs, 0, sizeof(*fs));
 
-	disk->queue = blk_mq_init_sq_queue(&fs->tag_set, &swim3_mq_ops, 2,
-						BLK_MQ_F_SHOULD_MERGE);
-	if (IS_ERR(disk->queue)) {
-		rc = PTR_ERR(disk->queue);
-		disk->queue = NULL;
-		goto out_put_disk;
+	rc = blk_mq_alloc_sq_tag_set(&fs->tag_set, &swim3_mq_ops, 2,
+			BLK_MQ_F_SHOULD_MERGE);
+	if (rc)
+		goto out_unregister;
+
+	disk = blk_mq_alloc_disk(&fs->tag_set, fs);
+	if (IS_ERR(disk)) {
+		rc = PTR_ERR(disk);
+		goto out_free_tag_set;
 	}
-	disk->queue->queuedata = fs;
 
 	rc = swim3_add_device(mdev, floppy_count);
 	if (rc)
-		goto out_cleanup_queue;
+		goto out_cleanup_disk;
 
 	disk->major = FLOPPY_MAJOR;
 	disk->first_minor = floppy_count;
+	disk->minors = 1;
 	disk->fops = &floppy_fops;
 	disk->private_data = fs;
 	disk->events = DISK_EVENT_MEDIA_CHANGE;
@@ -1237,12 +1234,10 @@ static int swim3_attach(struct macio_dev *mdev,
 	disks[floppy_count++] = disk;
 	return 0;
 
-out_cleanup_queue:
-	blk_cleanup_queue(disk->queue);
-	disk->queue = NULL;
+out_cleanup_disk:
+	blk_cleanup_disk(disk);
+out_free_tag_set:
 	blk_mq_free_tag_set(&fs->tag_set);
-out_put_disk:
-	put_disk(disk);
 out_unregister:
 	if (floppy_count == 0)
 		unregister_blkdev(FLOPPY_MAJOR, "fd");
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
