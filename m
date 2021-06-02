Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A782C4709C
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 06:56:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 309B060200
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 06:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309B060200
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A33340421;
	Wed,  2 Jun 2021 06:56:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PbXad0AnPdjA; Wed,  2 Jun 2021 06:56:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 70E1E4034B;
	Wed,  2 Jun 2021 06:56:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D945C000E;
	Wed,  2 Jun 2021 06:56:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9A9A4C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:56:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 884A4608EF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:56:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ddNFrx71zzYP
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:56:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E33F1608D4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=ZrMEf0Ls9F+Osx12fthB6jYFp7YA2RuOfcMRudkR5eo=; b=RmhbmeEgAua7D4yc0CN6m+daMw
 ggu55W3yOtqsYbnSz5c1dfLFQJ9ncvb9hc3nNvkXY6f0gcSGMOhLStwUwb0UQrJ1aG7h0ZSUng/WX
 es/ejunr+apwEHWPUWRQDfPQvgeX1hrHlUl4NOb5oItwm7czJQwirbV+FChfRP7dM0qxLnCRqVmgI
 bA1/+LYF3tWUOd/53KL9zns/VStS5lpZkIiq55Ah7xS6m/8ryTxd0+2JtSdNyv1ovCOilXcKoWuJr
 8KfLwtubqhZXD6/OkB2mdwrFmz8NTFBmkmZB+9B1+iGvFIgntGiUljL/AChzeEhq1iCnrHX8J/lkd
 xKgRqjOg==;
Received: from shol69.static.otenet.gr ([83.235.170.67] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loKnR-0026ec-A8; Wed, 02 Jun 2021 06:56:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 30/30] z2ram: use blk_mq_alloc_disk and blk_cleanup_disk
Date: Wed,  2 Jun 2021 09:53:45 +0300
Message-Id: <20210602065345.355274-31-hch@lst.de>
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
 drivers/block/z2ram.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index c1d20818e649..a8968d9e759b 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -323,27 +323,20 @@ static const struct blk_mq_ops z2_mq_ops = {
 
 static int z2ram_register_disk(int minor)
 {
-	struct request_queue *q;
 	struct gendisk *disk;
 
-	disk = alloc_disk(1);
-	if (!disk)
-		return -ENOMEM;
-
-	q = blk_mq_init_queue(&tag_set);
-	if (IS_ERR(q)) {
-		put_disk(disk);
-		return PTR_ERR(q);
-	}
+	disk = blk_mq_alloc_disk(&tag_set, NULL);
+	if (IS_ERR(disk))
+		return PTR_ERR(disk);
 
 	disk->major = Z2RAM_MAJOR;
 	disk->first_minor = minor;
+	disk->minors = 1;
 	disk->fops = &z2_fops;
 	if (minor)
 		sprintf(disk->disk_name, "z2ram%d", minor);
 	else
 		sprintf(disk->disk_name, "z2ram");
-	disk->queue = q;
 
 	z2ram_gendisk[minor] = disk;
 	add_disk(disk);
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
