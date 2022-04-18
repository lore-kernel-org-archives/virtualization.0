Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FEA5C433FE
	for <virtualization@archiver.kernel.org>; Mon, 18 Apr 2022 04:54:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F2D7140FFD;
	Mon, 18 Apr 2022 04:54:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4mlALPiaYSs2; Mon, 18 Apr 2022 04:54:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B276340B71;
	Mon, 18 Apr 2022 04:54:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C262C002F;
	Mon, 18 Apr 2022 04:54:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB579C002C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 04:54:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A7F7141DA6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 04:54:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YE7wQbvP2VCE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 04:54:07 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 020E241D7C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 04:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=FtH/TzYq8qAlMP8iMYBlGWDgAyvZ+dC0QKeXw0CO9iY=; b=BUsTo3zH0HXFlc2PINU8GKGh7x
 xOheprcMV4SR/Bv+uFwxwEEXQNbDYNV0dXmpOloJvszTTFIFrVWaZxvzBY3RFcl0N0jCpn4vw3nb4
 mTGNcSlargn2+/9oPzLzWJrWP+vix6g0SW/61Ow0uZFQlb8WOgevrVuktiq9QO8aHLzYorKaOwQBQ
 CfxG3eR2YUokj3T01RV5d+uhBYCjSMPbPfvUkXoiOxJvCqf7RvI027xldIPQkqonm5kkPHmkKj1CY
 TNHlrnSp6mhzujyAzSdQ8dHMYyS7hxSExdUVN15TaHiISjHO2rUQKK97SneL+jfBatao0hyUgCdvx
 1/5nIEmg==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngJOW-00FYuM-S5; Mon, 18 Apr 2022 04:53:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/11] xen-blkback: use bdev_discard_alignment
Date: Mon, 18 Apr 2022 06:53:14 +0200
Message-Id: <20220418045314.360785-12-hch@lst.de>
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

Use bdev_discard_alignment to calculate the correct discard alignment
offset even for partitions instead of just looking at the queue limit.

Also switch to use bdev_discard_granularity to get rid of the last direct
queue reference in xen_blkbk_discard.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/xen-blkback/xenbus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index b21bffc9c50bc..04c90cb8955f6 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -583,14 +583,14 @@ static void xen_blkbk_discard(struct xenbus_transaction xbt, struct backend_info
 	if (bdev_max_discard_sectors(bdev)) {
 		err = xenbus_printf(xbt, dev->nodename,
 			"discard-granularity", "%u",
-			q->limits.discard_granularity);
+			bdev_discard_granularity(bdev));
 		if (err) {
 			dev_warn(&dev->dev, "writing discard-granularity (%d)", err);
 			return;
 		}
 		err = xenbus_printf(xbt, dev->nodename,
 			"discard-alignment", "%u",
-			q->limits.discard_alignment);
+			bdev_discard_alignment(bdev));
 		if (err) {
 			dev_warn(&dev->dev, "writing discard-alignment (%d)", err);
 			return;
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
