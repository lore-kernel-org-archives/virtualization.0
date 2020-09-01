Return-Path: <SRS0=JuYR=CK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63917C43461
	for <virtualization@archiver.kernel.org>; Tue,  1 Sep 2020 15:58:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33A78206EB
	for <virtualization@archiver.kernel.org>; Tue,  1 Sep 2020 15:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TsLN4Ki5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A78206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 554BA86440;
	Tue,  1 Sep 2020 15:58:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QuRqOWa-bmgd; Tue,  1 Sep 2020 15:58:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 92C3D863E0;
	Tue,  1 Sep 2020 15:58:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7872FC089E;
	Tue,  1 Sep 2020 15:58:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BE7CC0895
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 15:58:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 73AC4861C7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 15:58:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KPpLcWBFav_s
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 15:58:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E2DE786194
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 15:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=JssZ/9cfFlKY9nXiXN1eWHNYfq2IqPkVO48PJ0G1HVM=; b=TsLN4Ki5H6wDqMT7EkDDmICR5s
 2ikY9tR6e67GKJEqjuS9L66bSUIo+pu5PYEAc9ljO3uyf6oMcNiepE5rzwUxhjE+/vnTmCPgENmda
 C0OeAfERJgyA7K8KeFysVlBHyF0BPeIG7el80V9O61CNCYuSKhfujxSQgjXJOjMOSEy03HwmPQuPh
 RJCdiSoEUrRAJIJ7z0BaLS8JSw/BmFlWFm/qiMtciExAsNyJHCr7Vvb8RIEQV1UW0Wnk6ZMFBndz3
 +EuD/g9pjFt/AGKn2OUIwLAq2rE5vGf6lWordEqx3jg+9VI6y7EPXjBeepMY6Nus8DQ6cZOSE4OGn
 R3KU2Xqg==;
Received: from [2001:4bb8:18c:45ba:2f95:e5:ca6b:9b4a] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kD8fR-0004Op-3n; Tue, 01 Sep 2020 15:57:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/9] block: don't clear bd_invalidated in
 check_disk_size_change
Date: Tue,  1 Sep 2020 17:57:41 +0200
Message-Id: <20200901155748.2884-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901155748.2884-1-hch@lst.de>
References: <20200901155748.2884-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-fsdevel@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, nbd@other.debian.org,
 virtualization@lists.linux-foundation.org, ceph-devel@vger.kernel.org
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

bd_invalidated is set by check_disk_change or in add_disk to initiate a
partition scan.  Move it from check_disk_size_change which is called
from both revalidate_disk() and bdev_disk_changed() to only the latter,
as that is what is called from the block device open code (and nbd) to
deal with the bd_invalidated event.  revalidate_disk() on the other hand
is mostly used to propagate a size update from the gendisk to the block
device, which is entirely unrelated.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 08158bb2e76c85..2760292045c082 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1302,7 +1302,6 @@ static void check_disk_size_change(struct gendisk *disk,
 		}
 		i_size_write(bdev->bd_inode, disk_size);
 	}
-	bdev->bd_invalidated = 0;
 	spin_unlock(&bdev->bd_size_lock);
 
 	if (bdev_size > disk_size) {
@@ -1391,6 +1390,8 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 
 	lockdep_assert_held(&bdev->bd_mutex);
 
+	bdev->bd_invalidated = 0;
+
 rescan:
 	ret = blk_drop_partitions(bdev);
 	if (ret)
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
