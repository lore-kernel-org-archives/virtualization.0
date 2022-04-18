Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61662C4332F
	for <virtualization@archiver.kernel.org>; Mon, 18 Apr 2022 04:53:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A28561202;
	Mon, 18 Apr 2022 04:53:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BGUQuLO8lTcW; Mon, 18 Apr 2022 04:53:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B18806120E;
	Mon, 18 Apr 2022 04:53:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76308C002C;
	Mon, 18 Apr 2022 04:53:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CE70C0083
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 04:53:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 776BB40FF6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 04:53:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ubc9p9tR9HlQ
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 04:53:49 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E1FD540117
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 04:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=5rcnJ83GrgSSabCav/BawazCovpIiEvHei2b2gmullQ=; b=CjJhpozaz3ZvUqlOlRhUG6HF0e
 L1k08qBdI7FjLxrC+2SHHoNWrKKNNyMlTyF4yTi95nmPu6QjzipSWH9TvaHMjTe8XoTWpzOf49Xwn
 /jTNmyPXW291lu9ai/kVpUcGZy0BEma/a+v71WBQptYeQK53Oa4G3wRCg1iH80jgNCDh+UkonCJTi
 b2hNWpI0YPpjBR+0L2Bg82wVndKnPmP8XXH33hc/RLegnrrgdomyqC3ANZRjwyzqph4yUIcfGGV1b
 13e7GSLfhf8SaHCAofITijpch9zJ9GPiLs40aqk7qM6e7KoHhSnPrPVcNE2jwVOMrxC25OuZ8i44W
 kFZNgihA==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngJOI-00FYkg-0o; Mon, 18 Apr 2022 04:53:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/11] raid5: don't set the discard_alignment queue limit
Date: Mon, 18 Apr 2022 06:53:09 +0200
Message-Id: <20220418045314.360785-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220418045314.360785-1-hch@lst.de>
References: <20220418045314.360785-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org, Song Liu <song@kernel.org>,
 dm-devel@redhat.com, "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Jack Wang <jinpu.wang@ionos.com>, linux-s390@vger.kernel.org,
 Richard Weinberger <richard@nod.at>, xen-devel@lists.xenproject.org,
 linux-um@lists.infradead.org, Mike Snitzer <snitzer@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-block@vger.kernel.org, Stefan Haberland <sth@linux.ibm.com>,
 linux-raid@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Johannes Berg <johannes@sipsolutions.net>,
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

The discard_alignment queue limit is named a bit misleading means the
offset into the block device at which the discard granularity starts.
Setting it to the discard granularity as done by raid5 is mostly
harmless but also useless.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/raid5.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 59f91e392a2ae..39b0afdf40d0a 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7749,7 +7749,6 @@ static int raid5_run(struct mddev *mddev)
 		 */
 		stripe = stripe * PAGE_SIZE;
 		stripe = roundup_pow_of_two(stripe);
-		mddev->queue->limits.discard_alignment = stripe;
 		mddev->queue->limits.discard_granularity = stripe;
 
 		blk_queue_max_write_zeroes_sectors(mddev->queue, 0);
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
