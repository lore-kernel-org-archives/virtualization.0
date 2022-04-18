Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365ADC3527A
	for <virtualization@archiver.kernel.org>; Mon, 18 Apr 2022 04:54:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BD71940117;
	Mon, 18 Apr 2022 04:54:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gVx8VqIm9moG; Mon, 18 Apr 2022 04:54:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5BC9041004;
	Mon, 18 Apr 2022 04:53:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36AC5C002F;
	Mon, 18 Apr 2022 04:53:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20BB7C002C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 04:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0E54141009
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 04:53:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hF4NqFF0SeCF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 04:53:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 747E441008
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 04:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=p9kVzatrYS3rOQLSwSVe7hP5f0rChlSo2rdSBrIcPYE=; b=0FL1fru1SsYGhSt8FM9Hn5xwZJ
 EmQtcyxuckYmdCptFk4+/gbaxge3l3nq3kRFPBP2il/Rof09pxe6Ws2nfts4MKx5OwwmpIZVuaYn4
 QeXpjkKcOgL+kIGAlsZf8TM3L2foTyd4yXmmcS+vpt95vjmJlLA2Izx3NJJBScVt157v41DjhjlqM
 L7UcHqXMheEW+Am7Onu8gXnRyneCudkfEE0daVhQvCm9moV6YBkxEJJ4GpFmY1uJvO31vQEX3ElTE
 DJMzx/mYKMVBU0H0c+NGX3DON4EMSxBXtNngeE5dikTPdCHtE3RUwtmqsEkdAx9DNdwjKW/ddgcK7
 QLRmmVOw==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngJOR-00FYpT-19; Mon, 18 Apr 2022 04:53:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/11] nvme: remove a spurious clear of discard_alignment
Date: Mon, 18 Apr 2022 06:53:12 +0200
Message-Id: <20220418045314.360785-10-hch@lst.de>
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

The nvme driver never sets a discard_alignment, so it also doens't need
to clear it to zero.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b9b0fbde97c80..76a9ccd5d064a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1628,7 +1628,6 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 	BUILD_BUG_ON(PAGE_SIZE / sizeof(struct nvme_dsm_range) <
 			NVME_DSM_MAX_RANGES);
 
-	queue->limits.discard_alignment = 0;
 	queue->limits.discard_granularity = size;
 
 	/* If discard is already enabled, don't reset queue limits */
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
