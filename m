Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E719C433F5
	for <virtualization@archiver.kernel.org>; Mon, 18 Apr 2022 04:53:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5557E40FF0;
	Mon, 18 Apr 2022 04:53:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VszwIY7Kq5ek; Mon, 18 Apr 2022 04:53:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EB7B341003;
	Mon, 18 Apr 2022 04:53:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B900EC002F;
	Mon, 18 Apr 2022 04:53:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 514C6C002F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 04:53:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3DC5A41D75
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 04:53:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9yeuYop_Eqb5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 04:53:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3CE5C41CDC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 04:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=rEun4CykQNh9XCzIn07hcf266lJSo8SoQFV5h3aZDN4=; b=Iyi59rQ8jx9ZFvYgDjqU1HKgI3
 3ER3HIO6el0yfwsbhwUqMaebwGQMLJp2Ty8pfApDcdy/dox4NBRD0zlAwgVZHz3C//ttRe2EpMMpE
 TlYo85CuBa66xfYMYNTFqP97nYG9E4UMoh/+mq+XldHcgyiYn8t88j0p38CFlHyG1WnflGfc9N6IQ
 ALupyQSKl6Do9NriswZQgpSbmVhWvg3qZzOpBx8BeEjzA/SfHSRhmM03Xd44QDRw6m5kWouXbMQLj
 EsfQEvQ7/s2jVpOeH9ws1tRZrnKNo3KfR2dNjEk6WSbmEVrg/W3E52Bl0bOqmREpLbkSwxlK3mr9T
 SboayqTg==;
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngJOK-00FYlu-W5; Mon, 18 Apr 2022 04:53:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/11] dasd: don't set the discard_alignment queue limit
Date: Mon, 18 Apr 2022 06:53:10 +0200
Message-Id: <20220418045314.360785-8-hch@lst.de>
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
Setting it to PAGE_SIZE while the discard granularity is the block size
that is smaller or the same as PAGE_SIZE as done by dasd is mostly
harmless but also useless.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/s390/block/dasd_fba.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index 8bd5665db9198..60be7f7bf2d16 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -782,7 +782,6 @@ static void dasd_fba_setup_blk_queue(struct dasd_block *block)
 	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
 
 	q->limits.discard_granularity = logical_block_size;
-	q->limits.discard_alignment = PAGE_SIZE;
 
 	/* Calculate max_discard_sectors and make it PAGE aligned */
 	max_bytes = USHRT_MAX * logical_block_size;
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
