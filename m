Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C708FC47092
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 06:54:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 769196135D
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 06:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769196135D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35FE96086C;
	Wed,  2 Jun 2021 06:54:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nEdwgPsjOQHr; Wed,  2 Jun 2021 06:54:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF6EB6071D;
	Wed,  2 Jun 2021 06:54:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56DE4C000E;
	Wed,  2 Jun 2021 06:54:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 191B1C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 072A240112
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:54:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7D5y9IBzzCSw
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:54:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 366EF400F6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=SnRF2RasuO3TzWzCcWD7psRmahwH4O2DjzNGyzgJCxM=; b=RfiXqx1buYxjqGM6Ru6s2uXbtK
 szP8Lp35KdwoBLpRViL7iCBQHBOTXZ4Qu5LJOvN43OaaHCTJwbYuBSl2SqXNEe3Ty441iVm62zV/q
 FK7bqtRTYnR/sNzxWhxA2AWxTTSYR0R47li/OgrbNqJ/z/C247XNi+vyVCBUJz2HWLNRhHDg9jROf
 W37wVhanz0woIFa4DI1Hiypd6xGuMEzMDW+t6oSvgQDur5ioE4KQTAUXWM04CshX1rW4l4k5bAsYt
 fMWsLaqDTkxSQegnpPyUc9dgQ8DJelIKHSJsddjUREuKapJzcCJM+AP8gSr/w6bRFlEnBsoDVPXvd
 WWIbvGOQ==;
Received: from shol69.static.otenet.gr ([83.235.170.67] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loKlG-0025Fb-J7; Wed, 02 Jun 2021 06:53:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/30] blk-mq: factor out a blk_mq_alloc_sq_tag_set helper
Date: Wed,  2 Jun 2021 09:53:16 +0300
Message-Id: <20210602065345.355274-2-hch@lst.de>
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

Factour out a helper to initialize a simple single hw queue tag_set from
blk_mq_init_sq_queue.  This will allow to phase out blk_mq_init_sq_queue
in favor of a more symmetric and general API.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c         | 32 ++++++++++++++++++--------------
 include/linux/blk-mq.h |  3 +++
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f11d4018ce2e..eaacfa963a73 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3152,24 +3152,12 @@ struct request_queue *blk_mq_init_sq_queue(struct blk_mq_tag_set *set,
 	struct request_queue *q;
 	int ret;
 
-	memset(set, 0, sizeof(*set));
-	set->ops = ops;
-	set->nr_hw_queues = 1;
-	set->nr_maps = 1;
-	set->queue_depth = queue_depth;
-	set->numa_node = NUMA_NO_NODE;
-	set->flags = set_flags;
-
-	ret = blk_mq_alloc_tag_set(set);
+	ret = blk_mq_alloc_sq_tag_set(set, ops, queue_depth, set_flags);
 	if (ret)
 		return ERR_PTR(ret);
-
 	q = blk_mq_init_queue(set);
-	if (IS_ERR(q)) {
+	if (IS_ERR(q))
 		blk_mq_free_tag_set(set);
-		return q;
-	}
-
 	return q;
 }
 EXPORT_SYMBOL(blk_mq_init_sq_queue);
@@ -3589,6 +3577,22 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 }
 EXPORT_SYMBOL(blk_mq_alloc_tag_set);
 
+/* allocate and initialize a tagset for a simple single-queue device */
+int blk_mq_alloc_sq_tag_set(struct blk_mq_tag_set *set,
+		const struct blk_mq_ops *ops, unsigned int queue_depth,
+		unsigned int set_flags)
+{
+	memset(set, 0, sizeof(*set));
+	set->ops = ops;
+	set->nr_hw_queues = 1;
+	set->nr_maps = 1;
+	set->queue_depth = queue_depth;
+	set->numa_node = NUMA_NO_NODE;
+	set->flags = set_flags;
+	return blk_mq_alloc_tag_set(set);
+}
+EXPORT_SYMBOL_GPL(blk_mq_alloc_sq_tag_set);
+
 void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 {
 	int i, j;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 359486940fa0..bb950fc669ef 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -439,6 +439,9 @@ struct request_queue *blk_mq_init_sq_queue(struct blk_mq_tag_set *set,
 void blk_mq_unregister_dev(struct device *, struct request_queue *);
 
 int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set);
+int blk_mq_alloc_sq_tag_set(struct blk_mq_tag_set *set,
+		const struct blk_mq_ops *ops, unsigned int queue_depth,
+		unsigned int set_flags);
 void blk_mq_free_tag_set(struct blk_mq_tag_set *set);
 
 void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule);
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
