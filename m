Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25505CCA483
	for <virtualization@archiver.kernel.org>; Mon,  6 Jun 2022 20:41:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C720A410A4;
	Mon,  6 Jun 2022 20:41:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G2y0DMlTwD1H; Mon,  6 Jun 2022 20:41:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 20BC54094B;
	Mon,  6 Jun 2022 20:41:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED70AC0039;
	Mon,  6 Jun 2022 20:41:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2D04C0039
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 20:41:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C2A1E840E6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 20:41:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z6t6Mi80eCPW
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 20:41:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 280CA840D9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 20:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=xi6bfdZ9kew/Ht/n6wJe844q1fNiFHAUuQwBybhvWV8=; b=SPlA9TQH81xoMoIY10n2YxKfFT
 FsYePoVkMqprqpv6ZpSb8LgcBJlPTx6ZiQnv9+DpcX1C8BhCoh731GzGv3vwXqOhVgpjWqAcZ9x5Q
 yXSG40C4z1zTwsHq25TqavEFM/aIkrZ74keXov/lJSFAeAlVFO92OjNCITHAZeey74UYtElj1IkQ9
 igzOLTZbXbr/H/xrC6wuD1gd2dEhozUsRpbKST11t4x3padiQWXP0MH6RjFWVF6lx2GnIIN77FMNF
 eqfhiP3IbavqdfjHnrPmIl/jNgL2ME2jYU2bFfEUdA0P2115AUzGiBLzXrUZQ116ZbPHL/l6z5/G3
 D9YuFHRg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nyJWx-00B19m-P8; Mon, 06 Jun 2022 20:40:55 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH 15/20] balloon: Convert to migrate_folio
Date: Mon,  6 Jun 2022 21:40:45 +0100
Message-Id: <20220606204050.2625949-16-willy@infradead.org>
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

This is little more than changing the types over; there's no real work
being done in this function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/balloon_compaction.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 4b8eab4b3f45..3f75b876ad76 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -230,11 +230,10 @@ static void balloon_page_putback(struct page *page)
 
 
 /* move_to_new_page() counterpart for a ballooned page */
-static int balloon_page_migrate(struct address_space *mapping,
-		struct page *newpage, struct page *page,
-		enum migrate_mode mode)
+static int balloon_migrate_folio(struct address_space *mapping,
+		struct folio *dst, struct folio *src, enum migrate_mode mode)
 {
-	struct balloon_dev_info *balloon = balloon_page_device(page);
+	struct balloon_dev_info *balloon = balloon_page_device(&src->page);
 
 	/*
 	 * We can not easily support the no copy case here so ignore it as it
@@ -244,14 +243,14 @@ static int balloon_page_migrate(struct address_space *mapping,
 	if (mode == MIGRATE_SYNC_NO_COPY)
 		return -EINVAL;
 
-	VM_BUG_ON_PAGE(!PageLocked(page), page);
-	VM_BUG_ON_PAGE(!PageLocked(newpage), newpage);
+	VM_BUG_ON_FOLIO(!folio_test_locked(src), src);
+	VM_BUG_ON_FOLIO(!folio_test_locked(dst), dst);
 
-	return balloon->migratepage(balloon, newpage, page, mode);
+	return balloon->migratepage(balloon, &dst->page, &src->page, mode);
 }
 
 const struct address_space_operations balloon_aops = {
-	.migratepage = balloon_page_migrate,
+	.migrate_folio = balloon_migrate_folio,
 	.isolate_page = balloon_page_isolate,
 	.putback_page = balloon_page_putback,
 };
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
