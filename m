Return-Path: <SRS0=+sHN=K4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B994C4708F
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 06:55:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE2D96135D
	for <virtualization@archiver.kernel.org>; Wed,  2 Jun 2021 06:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2D96135D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A2B99402D2;
	Wed,  2 Jun 2021 06:55:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HW5IevlCxfBn; Wed,  2 Jun 2021 06:55:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 481C04017C;
	Wed,  2 Jun 2021 06:55:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23D65C0026;
	Wed,  2 Jun 2021 06:55:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFF0FC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:55:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AB0D740349
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:55:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0hmV86D6Aiza
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:55:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B3562402C8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Jun 2021 06:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=yxB3CToEvB1AGII3Fhuj66pLyS4oXdc/Ax4ufYJhDmU=; b=2Ev1PQ3iAXTcAu7Nm/w91IlhBi
 XlySTC28St0acrPx9XgYMlbiWgHgwnXpAO7fssa+3RO6s6w1gNt/L0bRJxPAncGQ3wVJ/bZBHhsGL
 uVoo++YnZjLmVwV7/fA+A/a3WTVeZ7Iox3GoTmd7i9BvdmfF+QzgThe8cp3OM151RtbpSjuGYv1qk
 Z49auwfLnjtdi4znRE+V/2lHNnnW9JmtU9bmCTyqdsOZLGP/YzUu+pzLr8O4OJgs++QcKu78dpSPH
 xBu4qqzNSfKG6LxxIT8EjfGs2NvFuwBi/8BGzrjd39Z06zSSm1tbNqLwSjr7IrytRt6ttKelR32cD
 obDFH8eg==;
Received: from shol69.static.otenet.gr ([83.235.170.67] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loKmM-0025j3-HR; Wed, 02 Jun 2021 06:55:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 15/30] blk-mq: remove blk_mq_init_sq_queue
Date: Wed,  2 Jun 2021 09:53:30 +0300
Message-Id: <20210602065345.355274-16-hch@lst.de>
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

All users are gone now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c         | 22 ----------------------
 include/linux/blk-mq.h |  4 ----
 2 files changed, 26 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1e6036e6fd66..25e25177c2b1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3156,28 +3156,6 @@ struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set, void *queuedata)
 }
 EXPORT_SYMBOL(__blk_mq_alloc_disk);
 
-/*
- * Helper for setting up a queue with mq ops, given queue depth, and
- * the passed in mq ops flags.
- */
-struct request_queue *blk_mq_init_sq_queue(struct blk_mq_tag_set *set,
-					   const struct blk_mq_ops *ops,
-					   unsigned int queue_depth,
-					   unsigned int set_flags)
-{
-	struct request_queue *q;
-	int ret;
-
-	ret = blk_mq_alloc_sq_tag_set(set, ops, queue_depth, set_flags);
-	if (ret)
-		return ERR_PTR(ret);
-	q = blk_mq_init_queue(set);
-	if (IS_ERR(q))
-		blk_mq_free_tag_set(set);
-	return q;
-}
-EXPORT_SYMBOL(blk_mq_init_sq_queue);
-
 static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
 		struct blk_mq_tag_set *set, struct request_queue *q,
 		int hctx_idx, int node)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index f496c6c5b5d2..02a4aab0aeac 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -443,10 +443,6 @@ struct request_queue *blk_mq_init_queue_data(struct blk_mq_tag_set *set,
 		void *queuedata);
 int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 		struct request_queue *q);
-struct request_queue *blk_mq_init_sq_queue(struct blk_mq_tag_set *set,
-						const struct blk_mq_ops *ops,
-						unsigned int queue_depth,
-						unsigned int set_flags);
 void blk_mq_unregister_dev(struct device *, struct request_queue *);
 
 int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set);
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
