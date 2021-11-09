Return-Path: <SRS0=KS98=P4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A91FC433EF
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 08:33:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22CF86115A
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 08:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 22CF86115A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C1552403AA;
	Tue,  9 Nov 2021 08:33:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4tjcUMNztMsT; Tue,  9 Nov 2021 08:33:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 156ED403AD;
	Tue,  9 Nov 2021 08:33:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D4CBC003E;
	Tue,  9 Nov 2021 08:33:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24E1AC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 08:33:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5618D4039A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 08:33:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nkGkYBAG5y3h
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 08:33:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8F27F4039C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 08:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=nsipimcnsyS/B0mUTKc1w7RvYVd94QXif4VmP6OnJ7M=; b=SOG3snbCeJFUNnpml/J+nGIFgP
 11Rn4mb7f2DlhTGj7RN7VChnDm3Kc7nnt3ugFvyLhPzYC/aVMPav+/ZdZnkkV+C8SGkiSuFBPlmiq
 +OlDsroYRkp5Z7qJsqAM9LoUeLZdRih0+vjY/R9LbESTRS/PNy3qme0CF0vll5vxbJ5FnNeetrv00
 LHf4krhOqEKcByFNJMYS7khd2ax5/pWQRsi+oLDfJlcZ8dz6cjDnoSHusXpAyTUsaiFW7nqLLfAsO
 qUqyM7FpXzWRPuISCSoM0P5W1S+i4zpKjfv1bi0L3ZBd8jMPV+SnYd3weWCOI+oK+qZxN2yVl739E
 SR4KAVmg==;
Received: from [2001:4bb8:19a:7ee7:fb46:2fe1:8652:d9d4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkMZN-000s15-PP; Tue, 09 Nov 2021 08:33:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 09/29] dm-linear: add a linear_dax_pgoff helper
Date: Tue,  9 Nov 2021 09:32:49 +0100
Message-Id: <20211109083309.584081-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211109083309.584081-1-hch@lst.de>
References: <20211109083309.584081-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: nvdimm@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-s390@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
 dm-devel@redhat.com, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>
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

Add a helper to perform the entire remapping for DAX accesses.  This
helper open codes bdev_dax_pgoff given that the alignment checks have
already been done by the submitting file system and don't need to be
repeated.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm-linear.c | 49 +++++++++++++-----------------------------
 1 file changed, 15 insertions(+), 34 deletions(-)

diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 0a260c35aeeed..90de42f6743ac 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -163,63 +163,44 @@ static int linear_iterate_devices(struct dm_target *ti,
 }
 
 #if IS_ENABLED(CONFIG_FS_DAX)
+static struct dax_device *linear_dax_pgoff(struct dm_target *ti, pgoff_t *pgoff)
+{
+	struct linear_c *lc = ti->private;
+	sector_t sector = linear_map_sector(ti, *pgoff << PAGE_SECTORS_SHIFT);
+
+	*pgoff = (get_start_sect(lc->dev->bdev) + sector) >> PAGE_SECTORS_SHIFT;
+	return lc->dev->dax_dev;
+}
+
 static long linear_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 		long nr_pages, void **kaddr, pfn_t *pfn)
 {
-	long ret;
-	struct linear_c *lc = ti->private;
-	struct block_device *bdev = lc->dev->bdev;
-	struct dax_device *dax_dev = lc->dev->dax_dev;
-	sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
-
-	dev_sector = linear_map_sector(ti, sector);
-	ret = bdev_dax_pgoff(bdev, dev_sector, nr_pages * PAGE_SIZE, &pgoff);
-	if (ret)
-		return ret;
+	struct dax_device *dax_dev = linear_dax_pgoff(ti, &pgoff);
+
 	return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
 }
 
 static size_t linear_dax_copy_from_iter(struct dm_target *ti, pgoff_t pgoff,
 		void *addr, size_t bytes, struct iov_iter *i)
 {
-	struct linear_c *lc = ti->private;
-	struct block_device *bdev = lc->dev->bdev;
-	struct dax_device *dax_dev = lc->dev->dax_dev;
-	sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
+	struct dax_device *dax_dev = linear_dax_pgoff(ti, &pgoff);
 
-	dev_sector = linear_map_sector(ti, sector);
-	if (bdev_dax_pgoff(bdev, dev_sector, ALIGN(bytes, PAGE_SIZE), &pgoff))
-		return 0;
 	return dax_copy_from_iter(dax_dev, pgoff, addr, bytes, i);
 }
 
 static size_t linear_dax_copy_to_iter(struct dm_target *ti, pgoff_t pgoff,
 		void *addr, size_t bytes, struct iov_iter *i)
 {
-	struct linear_c *lc = ti->private;
-	struct block_device *bdev = lc->dev->bdev;
-	struct dax_device *dax_dev = lc->dev->dax_dev;
-	sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
+	struct dax_device *dax_dev = linear_dax_pgoff(ti, &pgoff);
 
-	dev_sector = linear_map_sector(ti, sector);
-	if (bdev_dax_pgoff(bdev, dev_sector, ALIGN(bytes, PAGE_SIZE), &pgoff))
-		return 0;
 	return dax_copy_to_iter(dax_dev, pgoff, addr, bytes, i);
 }
 
 static int linear_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
 				      size_t nr_pages)
 {
-	int ret;
-	struct linear_c *lc = ti->private;
-	struct block_device *bdev = lc->dev->bdev;
-	struct dax_device *dax_dev = lc->dev->dax_dev;
-	sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
-
-	dev_sector = linear_map_sector(ti, sector);
-	ret = bdev_dax_pgoff(bdev, dev_sector, nr_pages << PAGE_SHIFT, &pgoff);
-	if (ret)
-		return ret;
+	struct dax_device *dax_dev = linear_dax_pgoff(ti, &pgoff);
+
 	return dax_zero_page_range(dax_dev, pgoff, nr_pages);
 }
 
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
