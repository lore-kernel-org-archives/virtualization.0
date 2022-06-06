Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13026CCA48C
	for <virtualization@archiver.kernel.org>; Mon,  6 Jun 2022 20:41:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F73841C11;
	Mon,  6 Jun 2022 20:41:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x_xAzVtrRy2x; Mon,  6 Jun 2022 20:41:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DDFE2410A2;
	Mon,  6 Jun 2022 20:41:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B514DC007F;
	Mon,  6 Jun 2022 20:41:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0693BC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 20:41:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5640260DFF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 20:41:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CUHtjfCLdveX
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 20:41:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 48AC161196
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 20:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=jUHtPvxpwYn/CbCKtCO4gIDrDPVTvyaQoVGtIQShqV8=; b=jSXisP6LX46D6Mw+iXYFF/5dHQ
 Cq+5Fi0773+cVC4U9ukK6uPnYuWIfkHADg3G9SiZaN1QWdL8Bw8OwfYPT7xfddEiqh5OKP81yWVIY
 qERnKHNvRO9zfbKpGHImXAVxsBisgmn/CxiCns5EQmSUyg3J6K8R2kkkIDgNoaevsqaLFhC5Wxh52
 Z38Ws7TQ5Dp7rpDRe4MO4DakZ/+co05qxKtyfgyK3bXqUiSNs9vH9ETqmdeoiAv+unUA3cgwymN9t
 pq0eOgOppmxZCcU/ekIrK65xO/nlqiG9Pvvr5StvpmfjnqBIWv5xh9xJykbFL+Cw79+wHE0k8kIBA
 U9JkUfCw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nyJWx-00B19e-EV; Mon, 06 Jun 2022 20:40:55 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/20] ubifs: Convert to filemap_migrate_folio()
Date: Mon,  6 Jun 2022 21:40:41 +0100
Message-Id: <20220606204050.2625949-12-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220606204050.2625949-1-willy@infradead.org>
References: <20220606204050.2625949-1-willy@infradead.org>
MIME-Version: 1.0
Cc: linux-aio@kvack.org, linux-nfs@vger.kernel.org, cluster-devel@redhat.com,
 linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com,
 linux-ext4@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
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

filemap_migrate_folio() is a little more general than ubifs really needs,
but it's better to share the code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ubifs/file.c | 29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 04ced154960f..f2353dd676ef 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1461,29 +1461,6 @@ static bool ubifs_dirty_folio(struct address_space *mapping,
 	return ret;
 }
 
-#ifdef CONFIG_MIGRATION
-static int ubifs_migrate_page(struct address_space *mapping,
-		struct page *newpage, struct page *page, enum migrate_mode mode)
-{
-	int rc;
-
-	rc = migrate_page_move_mapping(mapping, newpage, page, 0);
-	if (rc != MIGRATEPAGE_SUCCESS)
-		return rc;
-
-	if (PagePrivate(page)) {
-		detach_page_private(page);
-		attach_page_private(newpage, (void *)1);
-	}
-
-	if (mode != MIGRATE_SYNC_NO_COPY)
-		migrate_page_copy(newpage, page);
-	else
-		migrate_page_states(newpage, page);
-	return MIGRATEPAGE_SUCCESS;
-}
-#endif
-
 static bool ubifs_release_folio(struct folio *folio, gfp_t unused_gfp_flags)
 {
 	struct inode *inode = folio->mapping->host;
@@ -1649,10 +1626,8 @@ const struct address_space_operations ubifs_file_address_operations = {
 	.write_end      = ubifs_write_end,
 	.invalidate_folio = ubifs_invalidate_folio,
 	.dirty_folio	= ubifs_dirty_folio,
-#ifdef CONFIG_MIGRATION
-	.migratepage	= ubifs_migrate_page,
-#endif
-	.release_folio    = ubifs_release_folio,
+	.migrate_folio	= filemap_migrate_folio,
+	.release_folio	= ubifs_release_folio,
 };
 
 const struct inode_operations ubifs_file_inode_operations = {
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
