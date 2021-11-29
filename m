Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFAEC43219
	for <virtualization@archiver.kernel.org>; Mon, 29 Nov 2021 10:22:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B9E760A82;
	Mon, 29 Nov 2021 10:22:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pF06Ms5huy1Y; Mon, 29 Nov 2021 10:22:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 61EF660A4A;
	Mon, 29 Nov 2021 10:22:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A03D1C0049;
	Mon, 29 Nov 2021 10:22:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0B0DC001C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 10:22:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8A60A60A4A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 10:22:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nF8ohqK-KT-V
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 10:22:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9446760A72
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 10:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=SFLYg18cvij6fU/3A8zFWrjXsu/Zx4DYVn4elv8lvPs=; b=uB944Rw+yKwWNNyIUgm2y7f92e
 nNzmWSGyjlKa1IN1nAvs4ne0Kq2Je3alGtGlu7CyfQckv73HtbRv78vo0UbB4VQ4kH0bGG/7TrSQl
 lF5vs7LCw65hs31wWSArmMuopqBCYmTmPm0Mc/4zraDKVFzFN0hShN6O+rZOWU1WVRq2kc3kT8AOb
 Kxm/r6DwhK6yetiqjs02YbQail0yT68daR+d6LLKvj8Ln9M3K/R41h23aSDikFSwt7HUJy8JzBTMC
 +gUWf24Ik0bwO/HMS9mSAmHzTn7FHgcEkqbIM0mF3ttEnHkPf0HTn6znk9hCSSPyBMxNI8m3Yfx9C
 pVDFv2AA==;
Received: from [2001:4bb8:184:4a23:724a:c057:c7bf:4643] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrdnm-0073Qh-SZ; Mon, 29 Nov 2021 10:22:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 17/29] fsdax: factor out a dax_memzero helper
Date: Mon, 29 Nov 2021 11:21:51 +0100
Message-Id: <20211129102203.2243509-18-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211129102203.2243509-1-hch@lst.de>
References: <20211129102203.2243509-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: nvdimm@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-s390@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
 dm-devel@redhat.com, "Darrick J . Wong" <djwong@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
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
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/dax.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index d7a923d152240..d5db1297a0bb6 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1121,34 +1121,36 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 }
 #endif /* CONFIG_FS_DAX_PMD */
 
+static int dax_memzero(struct dax_device *dax_dev, pgoff_t pgoff,
+		unsigned int offset, size_t size)
+{
+	void *kaddr;
+	long ret;
+
+	ret = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
+	if (ret > 0) {
+		memset(kaddr + offset, 0, size);
+		dax_flush(dax_dev, kaddr + offset, size);
+	}
+	return ret;
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
