Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D13CCA473
	for <virtualization@archiver.kernel.org>; Mon,  6 Jun 2022 20:41:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BECB8408C;
	Mon,  6 Jun 2022 20:41:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ckkTDpFT8rWx; Mon,  6 Jun 2022 20:41:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1898F830B8;
	Mon,  6 Jun 2022 20:41:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0B58C0039;
	Mon,  6 Jun 2022 20:41:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8118BC0039
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 20:41:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4EF0A830B8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 20:41:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WRx6DQKlmfGK
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 20:41:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 48DE78308D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Jun 2022 20:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=NFScYX57GEbw0yH/d1QXpe8YFpfaQsvuaQCT3ii6ess=; b=mDp4J3wn+JfgTBMvZgEUqjDjOc
 MdvHmectsbLkZvfTk8nG6ytXS1+4dBHiC4pMAhcy3dH+w+BngrUwTH364Opf+ULDH9RffR6xS8W1s
 NvNCsPvgWsTpdK5si++BB7gskVwFgeJKaRz9oSkBMT/tvUH1htLz8dXlAm4tajf1oQVpZT/iQpp3Z
 3qvjBqAGoN/HgsaNXSczCYJXunICX2cMGKbV8nqWYAZ1dFtuqgFYtfMpTC7xMxk50hUBGd3mZWqxV
 6hlTudv8DYvIDVhKEtAVCLpJUOSZgQOHlnJd6eZoWquUE4SD1aKFk5s64qg6Qy5XVFt9b2QyPeQP8
 VdadEfOg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nyJWy-00B19s-0v; Mon, 06 Jun 2022 20:40:56 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Subject: [PATCH 18/20] zsmalloc: Convert to migrate_folio
Date: Mon,  6 Jun 2022 21:40:48 +0100
Message-Id: <20220606204050.2625949-19-willy@infradead.org>
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

zsmalloc doesn't really use folios, but it needs to be called like this
in order to migrate an individual page.  Convert from a folio back to
a page until we decide how to handle migration better for zsmalloc.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/zsmalloc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 5d5fc04385b8..8ed79121195a 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1865,9 +1865,11 @@ static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
 	return true;
 }
 
-static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
-		struct page *page, enum migrate_mode mode)
+static int zs_migrate_folio(struct address_space *mapping,
+		struct folio *dst, struct folio *src, enum migrate_mode mode)
 {
+	struct page *newpage = &dst->page;
+	struct page *page = &src->page;
 	struct zs_pool *pool;
 	struct size_class *class;
 	struct zspage *zspage;
@@ -1966,7 +1968,7 @@ static void zs_page_putback(struct page *page)
 
 static const struct address_space_operations zsmalloc_aops = {
 	.isolate_page = zs_page_isolate,
-	.migratepage = zs_page_migrate,
+	.migrate_folio = zs_migrate_folio,
 	.putback_page = zs_page_putback,
 };
 
-- 
2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
