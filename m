Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB73C47083
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 06:55:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9107261242
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 06:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9107261242
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D180608D5;
	Wed,  2 Jun 2021 06:55:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7WgARTgscFX3; Wed,  2 Jun 2021 06:55:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id EEAE2607BA;
	Wed,  2 Jun 2021 06:55:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D846DC000E;
	Wed,  2 Jun 2021 06:55:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B89DC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:55:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1CA3C836A7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:55:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AyXcCtgtQtBc
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:55:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6064182D75
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=uZ7id5h0Y8eTodjolim75Nh4xqN5GmxeKJFIibiB+SQ=; b=Y+ZIEpYOA2iHCs2T6tZeqlhwn4
 2PZNnbXaohXgLYFyDB1Km2Bu2wyT0psxnFom5uMCa1WL63p08XIPFssnnwdwOWXz6S+f1NQhfrJgw
 DT/OnKnomp1fr4hlxHzl1uRlbcM58luxBJNmSQR1ISWEmb6j+xDelW/EPSueMH5qVJqvrMzGOnsJB
 1yLmbxBIjZuZM4gaGqkWw/56tktEZ+pXt7zHVQEX0324IpvUKx/kGJ0wdmf5QkCuJQDan3LvZi1gh
 v7Tu3lvr/4iTt31gmsoCM89vROF9iZm4xBhs773hy5MvLL57mXmlU4k/Fy9BEGPPXaP9XwV6nM+1f
 cFvfrZKA==;
Received: from shol69.static.otenet.gr ([83.235.170.67] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loKmI-0025hI-AR; Wed, 02 Jun 2021 06:54:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 14/30] gdrom: use blk_mq_alloc_disk
Date: Wed,  2 Jun 2021 09:53:29 +0300
Message-Id: <20210602065345.355274-15-hch@lst.de>
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
 drivers/cdrom/gdrom.c | 45 ++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index c6d8c0f59722..8e1fe75af93f 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -772,53 +772,50 @@ static int probe_gdrom(struct platform_device *devptr)
 		goto probe_fail_no_mem;
 	}
 	probe_gdrom_setupcd();
-	gd.disk = alloc_disk(1);
-	if (!gd.disk) {
-		err = -ENODEV;
-		goto probe_fail_no_disk;
+
+	err = blk_mq_alloc_sq_tag_set(&gd.tag_set, &gdrom_mq_ops, 1,
+				BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING);
+	if (err)
+		goto probe_fail_free_cd_info;
+
+	gd.disk = blk_mq_alloc_disk(&gd.tag_set, NULL);
+	if (IS_ERR(gd.disk)) {
+		err = PTR_ERR(gd.disk);
+		goto probe_fail_free_tag_set;
 	}
+	gd.gdrom_rq = gd.disk->queue;
 	probe_gdrom_setupdisk();
 	if (register_cdrom(gd.disk, gd.cd_info)) {
 		err = -ENODEV;
-		goto probe_fail_cdrom_register;
+		goto probe_fail_cleanup_disk;
 	}
 	gd.disk->fops = &gdrom_bdops;
 	gd.disk->events = DISK_EVENT_MEDIA_CHANGE;
 	/* latch on to the interrupt */
 	err = gdrom_set_interrupt_handlers();
 	if (err)
-		goto probe_fail_cmdirq_register;
-
-	gd.gdrom_rq = blk_mq_init_sq_queue(&gd.tag_set, &gdrom_mq_ops, 1,
-				BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING);
-	if (IS_ERR(gd.gdrom_rq)) {
-		err = PTR_ERR(gd.gdrom_rq);
-		gd.gdrom_rq = NULL;
-		goto probe_fail_requestq;
-	}
+		goto probe_fail_cleanup_disk;
 
 	err = probe_gdrom_setupqueue();
 	if (err)
-		goto probe_fail_toc;
+		goto probe_fail_free_irqs;
 
 	gd.toc = kzalloc(sizeof(struct gdromtoc), GFP_KERNEL);
 	if (!gd.toc) {
 		err = -ENOMEM;
-		goto probe_fail_toc;
+		goto probe_fail_free_irqs;
 	}
 	add_disk(gd.disk);
 	return 0;
 
-probe_fail_toc:
-	blk_cleanup_queue(gd.gdrom_rq);
-	blk_mq_free_tag_set(&gd.tag_set);
-probe_fail_requestq:
+probe_fail_free_irqs:
 	free_irq(HW_EVENT_GDROM_DMA, &gd);
 	free_irq(HW_EVENT_GDROM_CMD, &gd);
-probe_fail_cmdirq_register:
-probe_fail_cdrom_register:
-	del_gendisk(gd.disk);
-probe_fail_no_disk:
+probe_fail_cleanup_disk:
+	blk_cleanup_disk(gd.disk);
+probe_fail_free_tag_set:
+	blk_mq_free_tag_set(&gd.tag_set);
+probe_fail_free_cd_info:
 	kfree(gd.cd_info);
 probe_fail_no_mem:
 	unregister_blkdev(gdrom_major, GDROM_DEV_NAME);
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
