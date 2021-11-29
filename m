Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7A5C433EF
	for <virtualization@archiver.kernel.org>; Mon, 29 Nov 2021 10:22:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42FA2404E6;
	Mon, 29 Nov 2021 10:22:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KoOezWLAtM0e; Mon, 29 Nov 2021 10:22:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CEA1340128;
	Mon, 29 Nov 2021 10:22:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4E26C001C;
	Mon, 29 Nov 2021 10:22:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 145ADC000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 10:22:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 03B5B83211
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 10:22:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7JFNWMmL93rv
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 10:22:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 44B98830E6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 10:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=XHcqPgm0fqvLtphqxdmDNoSl5+oSPu60OAGnlh9s0gw=; b=WJ8o63EsFNjjp1GQdMNazwT11E
 BfTT9E4uR8M+3tv7Gdk5oW0tQ8C5YJDHw4GvZsPXZMnLzttEuf5o8MdWEURf0bKUJE3l3tupFz3nw
 rDlE1/aIniKf+/L4SrJ7PkPlV0VLcEBfVdv0NYRIulVDlfGv38ZX2H94c+lDTkw4ksU4LMPJnVJ4n
 WPC6wAiFzJR0XbLJoPV8Z33juoA6+NpLpjkLeFzYSPGYhMDw6EQVb0dAu+CldT2SxWVIBta6mSr+8
 FGb7NRs7WMHuk4kqVtfuZLJElwegfPt0Om3fGt5SxxmcoTfG481+WNghGsqvuMpx5BpQ6ftenMSsl
 p63Ed1vg==;
Received: from [2001:4bb8:184:4a23:724a:c057:c7bf:4643] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrdo1-0073YT-9F; Mon, 29 Nov 2021 10:22:42 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 27/29] dax: fix up some of the block device related ifdefs
Date: Mon, 29 Nov 2021 11:22:01 +0100
Message-Id: <20211129102203.2243509-28-hch@lst.de>
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

The DAX device <-> block device association is only enabled if
CONFIG_BLOCK is enabled.  Update dax.h to account for that and use
the right conditions for the fs_put_dax stub as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 include/linux/dax.h | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/include/linux/dax.h b/include/linux/dax.h
index f6f353382cc90..87ae4c9b1d65b 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -108,24 +108,15 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
 #endif
 
 struct writeback_control;
-#if IS_ENABLED(CONFIG_FS_DAX)
+#if defined(CONFIG_BLOCK) && defined(CONFIG_FS_DAX)
 int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk);
 void dax_remove_host(struct gendisk *disk);
-
+struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev,
+		u64 *start_off);
 static inline void fs_put_dax(struct dax_device *dax_dev)
 {
 	put_dax(dax_dev);
 }
-
-struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev,
-		u64 *start_off);
-int dax_writeback_mapping_range(struct address_space *mapping,
-		struct dax_device *dax_dev, struct writeback_control *wbc);
-
-struct page *dax_layout_busy_page(struct address_space *mapping);
-struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
-dax_entry_t dax_lock_page(struct page *page);
-void dax_unlock_page(struct page *page, dax_entry_t cookie);
 #else
 static inline int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk)
 {
@@ -134,17 +125,25 @@ static inline int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk)
 static inline void dax_remove_host(struct gendisk *disk)
 {
 }
-
-static inline void fs_put_dax(struct dax_device *dax_dev)
-{
-}
-
 static inline struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev,
 		u64 *start_off)
 {
 	return NULL;
 }
+static inline void fs_put_dax(struct dax_device *dax_dev)
+{
+}
+#endif /* CONFIG_BLOCK && CONFIG_FS_DAX */
 
+#if IS_ENABLED(CONFIG_FS_DAX)
+int dax_writeback_mapping_range(struct address_space *mapping,
+		struct dax_device *dax_dev, struct writeback_control *wbc);
+
+struct page *dax_layout_busy_page(struct address_space *mapping);
+struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
+dax_entry_t dax_lock_page(struct page *page);
+void dax_unlock_page(struct page *page, dax_entry_t cookie);
+#else
 static inline struct page *dax_layout_busy_page(struct address_space *mapping)
 {
 	return NULL;
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
