Return-Path: <SRS0=JuYR=CK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9146C28E83
	for <virtualization@archiver.kernel.org>; Tue,  1 Sep 2020 15:58:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F66E206EB
	for <virtualization@archiver.kernel.org>; Tue,  1 Sep 2020 15:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a3R6hLNA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F66E206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AD3458644F;
	Tue,  1 Sep 2020 15:58:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3tz5SAxjpLXR; Tue,  1 Sep 2020 15:58:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1F91686341;
	Tue,  1 Sep 2020 15:58:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09B97C07FF;
	Tue,  1 Sep 2020 15:58:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5174DC0051
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 15:58:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4144A870B1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 15:58:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Afedzmvst0JQ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 15:58:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7D8908704F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 15:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=X/wfONNMX9AkocUJrvkgvfoHlYcJ3otMPBdPBvDFSjg=; b=a3R6hLNAfPXw6R8QRXbGznXJl/
 XYw3Qcp5GUZVdLvYz3g7yZTdhLBPVHDMlSfggoOPLUZWWTlpi4VSyTLAeSxeaGxz4415i0HuxYlHn
 Rrzp4jXd9c1wB6Wl3fp75EZkwMR2pMOu0V4GqphS42Sy5cwGMmFOYSTu0f0WbNwh1AsqMoTho9gFC
 RdhXzlE/7Zkah6VP7mUGqtnJKwpPFotBogYpnKN+bSpdkd42Pcgek9fWuBUDFm0apHm4YOMPi1N2y
 tFJ5Kmb07jMbKgTkS/gXIrjXeu0LFRibRlegC43oSpS4bZjr/7ucSGkobwgV+XWFLT35JhGnmQ+r9
 HsMdIZtA==;
Received: from [2001:4bb8:18c:45ba:2f95:e5:ca6b:9b4a] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kD8fX-0004QE-CS; Tue, 01 Sep 2020 15:57:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/9] block: use revalidate_disk_size in
 set_capacity_revalidate_and_notify
Date: Tue,  1 Sep 2020 17:57:44 +0200
Message-Id: <20200901155748.2884-6-hch@lst.de>
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

Only virtio_blk and xen-blkfront set the revalidate argument to true,
and both do not implement the ->revalidate_disk method.  So switch
to the helper that just updates the size instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c         | 7 +++----
 include/linux/genhd.h | 4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index a2c0ec694918e5..431d4081b50ec7 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -50,14 +50,13 @@ static void disk_release_events(struct gendisk *disk);
  * zero and will not be set to zero
  */
 void set_capacity_revalidate_and_notify(struct gendisk *disk, sector_t size,
-					bool revalidate)
+					bool update_bdev)
 {
 	sector_t capacity = get_capacity(disk);
 
 	set_capacity(disk, size);
-
-	if (revalidate)
-		revalidate_disk(disk);
+	if (update_bdev)
+		revalidate_disk_size(disk, true);
 
 	if (capacity != size && capacity != 0 && size != 0) {
 		char *envp[] = { "RESIZE=1", NULL };
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 8e9c9d3a493fae..c340b392452ce6 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -315,8 +315,8 @@ static inline int get_disk_ro(struct gendisk *disk)
 extern void disk_block_events(struct gendisk *disk);
 extern void disk_unblock_events(struct gendisk *disk);
 extern void disk_flush_events(struct gendisk *disk, unsigned int mask);
-extern void set_capacity_revalidate_and_notify(struct gendisk *disk,
-			sector_t size, bool revalidate);
+void set_capacity_revalidate_and_notify(struct gendisk *disk, sector_t size,
+		bool update_bdev);
 extern unsigned int disk_clear_events(struct gendisk *disk, unsigned int mask);
 
 /* drivers/char/random.c */
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
