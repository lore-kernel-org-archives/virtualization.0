Return-Path: <SRS0=+DIW=J2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D7AC43460
	for <virtualization@archiver.kernel.org>; Thu, 29 Apr 2021 12:25:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 438E3613C8
	for <virtualization@archiver.kernel.org>; Thu, 29 Apr 2021 12:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438E3613C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D41EB41961;
	Thu, 29 Apr 2021 12:25:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IpImH8mB809C; Thu, 29 Apr 2021 12:25:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35A6641942;
	Thu, 29 Apr 2021 12:25:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DE39C000F;
	Thu, 29 Apr 2021 12:25:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02224C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 12:25:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E57DB845FE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 12:25:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dvBDCVYIUXzz
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 12:25:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 03CA0845F0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 12:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619699150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9yW4OuKyN35nF4beRa4G0zG5E1KxLWubZR1ZjeP0KtI=;
 b=YfE4oZdXNKlICUEPNXNRa/7MhrKt/zOHHL43XtfnMZQIKy4EUhw41LPH4evd/Sq7+SFGQf
 7uzLLZQT9d2cfE4xAJpZwUWZWTGOtA+8IViaLuu0i+KTUrho3jeJ0Jeu4PlfvBZC5+P0M5
 4491uSgVq8tefpjyqZ7RyKHm8OhatLg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-yxYYYYlMNcONjLFEyhJ5IQ-1; Thu, 29 Apr 2021 08:25:46 -0400
X-MC-Unique: yxYYYYlMNcONjLFEyhJ5IQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B20248042A6;
 Thu, 29 Apr 2021 12:25:43 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-50.ams2.redhat.com [10.36.114.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C08A18796;
 Thu, 29 Apr 2021 12:25:38 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/7] mm: rename and move page_is_poisoned()
Date: Thu, 29 Apr 2021 14:25:15 +0200
Message-Id: <20210429122519.15183-4-david@redhat.com>
In-Reply-To: <20210429122519.15183-1-david@redhat.com>
References: <20210429122519.15183-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Aili Yao <yaoaili@kingsoft.com>, Michal Hocko <mhocko@suse.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 Wei Liu <wei.liu@kernel.org>, Alex Shi <alex.shi@linux.alibaba.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 Steven Price <steven.price@arm.com>, Alexey Dobriyan <adobriyan@gmail.com>,
 Jiri Bohac <jbohac@suse.cz>, Haiyang Zhang <haiyangz@microsoft.com>,
 Oscar Salvador <osalvador@suse.de>, Naoya Horiguchi <naoya.horiguchi@nec.com>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <guro@fb.com>, Mike Rapoport <rppt@kernel.org>,
 Mike Kravetz <mike.kravetz@oracle.com>
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

Commit d3378e86d182 ("mm/gup: check page posion status for coredump.")
introduced page_is_poisoned(), however, v5 [1] of the patch used
"page_is_hwpoison()" and something went wrong while upstreaming. Rename the
function and move it to page-flags.h, from where it can be used in other
-- kcore -- context.

Move the comment to the place where it belongs and simplify.

[1] https://lkml.kernel.org/r/20210322193318.377c9ce9@alex-virtual-machine

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h |  7 +++++++
 mm/gup.c                   |  6 +++++-
 mm/internal.h              | 20 --------------------
 3 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 04a34c08e0a6..b8c56672a588 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -694,6 +694,13 @@ PAGEFLAG_FALSE(DoubleMap)
 	TESTSCFLAG_FALSE(DoubleMap)
 #endif
 
+static inline bool is_page_hwpoison(struct page *page)
+{
+	if (PageHWPoison(page))
+		return true;
+	return PageHuge(page) && PageHWPoison(compound_head(page));
+}
+
 /*
  * For pages that are never mapped to userspace (and aren't PageSlab),
  * page_type may be used.  Because it is initialised to -1, we invert the
diff --git a/mm/gup.c b/mm/gup.c
index ef7d2da9f03f..000f3303e7f2 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1536,7 +1536,11 @@ struct page *get_dump_page(unsigned long addr)
 	if (locked)
 		mmap_read_unlock(mm);
 
-	if (ret == 1 && is_page_poisoned(page))
+	/*
+	 * We might have hwpoisoned pages still mapped into user space. Don't
+	 * read these pages when creating a coredump, access could be fatal.
+	 */
+	if (ret == 1 && is_page_hwpoison(page))
 		return NULL;
 
 	return (ret == 1) ? page : NULL;
diff --git a/mm/internal.h b/mm/internal.h
index cb3c5e0a7799..1432feec62df 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -97,26 +97,6 @@ static inline void set_page_refcounted(struct page *page)
 	set_page_count(page, 1);
 }
 
-/*
- * When kernel touch the user page, the user page may be have been marked
- * poison but still mapped in user space, if without this page, the kernel
- * can guarantee the data integrity and operation success, the kernel is
- * better to check the posion status and avoid touching it, be good not to
- * panic, coredump for process fatal signal is a sample case matching this
- * scenario. Or if kernel can't guarantee the data integrity, it's better
- * not to call this function, let kernel touch the poison page and get to
- * panic.
- */
-static inline bool is_page_poisoned(struct page *page)
-{
-	if (PageHWPoison(page))
-		return true;
-	else if (PageHuge(page) && PageHWPoison(compound_head(page)))
-		return true;
-
-	return false;
-}
-
 extern unsigned long highest_memmap_pfn;
 
 /*
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
