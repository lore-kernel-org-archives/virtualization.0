Return-Path: <SRS0=KS98=P4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88754C41535
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 08:34:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5559A611AF
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 08:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5559A611AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 29C8880ED0;
	Tue,  9 Nov 2021 08:34:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GZ4Lnj2A2dtY; Tue,  9 Nov 2021 08:34:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AEE2480ED7;
	Tue,  9 Nov 2021 08:34:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 865E1C0012;
	Tue,  9 Nov 2021 08:34:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DAAAC001F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 08:33:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3774F80ECD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 08:33:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mppOADUugF1y
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 08:33:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 72F8C80ED2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 08:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=SW8Zo8xNPpf5PRQj/yoxD2eK+vSZCdgKjxBBcNAut5E=; b=IAd2z0n4+rSaZjOAQAcHkUiG7e
 AHKwIW3QT0BU34bqCQuvoimP884y7lMTrSi4ev67fFNWoK1dDvk5amFAb1n/57yJ+Cb+3n1zj4Gbe
 YQPgAi5L5rz7YsX4eE0j3hCuAMWPdWSq6kU6krKBw+bSRtv/zYPnHKCRNminIPWP6laGvD1ySu1/T
 onyeNMCfFyCWBxzeP2yuXUxNRqQg/kDKSkylEst+HmEWCXAPXsfje13JJ/FKQNbF/0EmnJ+G2P9v1
 SSDU4goh3tuk4pjnxSDpwGrNlqzT2hYG7o05V7aC4jrXohtehEvjw1MAGEkXVzVVTQXeoF3k/MQXg
 T5uHRctQ==;
Received: from [2001:4bb8:19a:7ee7:fb46:2fe1:8652:d9d4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkMZb-000s5r-P1; Tue, 09 Nov 2021 08:33:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 17/29] fsdax: factor out a dax_memzero helper
Date: Tue,  9 Nov 2021 09:32:57 +0100
Message-Id: <20211109083309.584081-18-hch@lst.de>
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

Factor out a helper for the "manual" zeroing of a DAX range to clean
up dax_iomap_zero a lot.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/dax.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index d7a923d152240..dc9ebeff850ab 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1121,34 +1121,36 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 }
 #endif /* CONFIG_FS_DAX_PMD */
 
+static int dax_memzero(struct dax_device *dax_dev, pgoff_t pgoff,
+		unsigned int offset, size_t size)
+{
+	void *kaddr;
+	long rc;
+
+	rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
+	if (rc >= 0) {
+		memset(kaddr + offset, 0, size);
+		dax_flush(dax_dev, kaddr + offset, size);
+	}
+	return rc;
+}
+
 s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap)
 {
 	pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
 	long rc, id;
-	void *kaddr;
-	bool page_aligned = false;
 	unsigned offset = offset_in_page(pos);
 	unsigned size = min_t(u64, PAGE_SIZE - offset, length);
 
-	if (IS_ALIGNED(pos, PAGE_SIZE) && size == PAGE_SIZE)
-		page_aligned = true;
-
 	id = dax_read_lock();
-
-	if (page_aligned)
+	if (IS_ALIGNED(pos, PAGE_SIZE) && size == PAGE_SIZE)
 		rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
 	else
-		rc = dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL);
-	if (rc < 0) {
-		dax_read_unlock(id);
-		return rc;
-	}
-
-	if (!page_aligned) {
-		memset(kaddr + offset, 0, size);
-		dax_flush(iomap->dax_dev, kaddr + offset, size);
-	}
+		rc = dax_memzero(iomap->dax_dev, pgoff, offset, size);
 	dax_read_unlock(id);
+
+	if (rc < 0)
+		return rc;
 	return size;
 }
 
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
