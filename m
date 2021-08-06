Return-Path: <SRS0=epgR=M5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92231C432BE
	for <virtualization@archiver.kernel.org>; Fri,  6 Aug 2021 12:47:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2280961181
	for <virtualization@archiver.kernel.org>; Fri,  6 Aug 2021 12:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2280961181
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C6AC24032F;
	Fri,  6 Aug 2021 12:47:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IRcBcow4SvTI; Fri,  6 Aug 2021 12:47:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 11BE04021C;
	Fri,  6 Aug 2021 12:47:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEAC7C001A;
	Fri,  6 Aug 2021 12:47:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1EF0FC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 12:47:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B83C40578
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 12:47:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4XLUM8wWcUaT
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 12:47:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 507A040556
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 12:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628254059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nO3dK2/IY5f3RAqKjpHPbvCRmXr/tzTHjBq63r/u5So=;
 b=WEgfCt5/j/NqAjdjibjfd4N0GPx5JEvnYwQdyGVLOXju0ZszBE6RLiAed7qU37dZrKlMO3
 YMJE527YqD/HCKYwhL5e4pzi76QYA0OKQ0U2jIVwdUWWAUYrm4SSnsL3uTLGWaarWXNRpS
 +dpNpmDeid9MJnu6x/LN27ZLomR95pI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-S-5eTB5nNweSl1t3fCyD8w-1; Fri, 06 Aug 2021 08:47:38 -0400
X-MC-Unique: S-5eTB5nNweSl1t3fCyD8w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A28C9801AE7;
 Fri,  6 Aug 2021 12:47:35 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.224])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 594185D6B1;
 Fri,  6 Aug 2021 12:47:30 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/9] mm: track present early pages per zone
Date: Fri,  6 Aug 2021 14:47:07 +0200
Message-Id: <20210806124715.17090-2-david@redhat.com>
In-Reply-To: <20210806124715.17090-1-david@redhat.com>
References: <20210806124715.17090-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
 Pavel Tatashin <pasha.tatashin@soleen.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Dan Williams <dan.j.williams@intel.com>, Michal Hocko <mhocko@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hui Zhu <teawater@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Marek Kedzierski <mkedzier@redhat.com>, Mike Rapoport <rppt@kernel.org>
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

For implementing a new memory onlining policy, which determines when to
online memory blocks to ZONE_MOVABLE semi-automatically, we need the number
of present early (boot) pages -- present pages excluding hotplugged pages.
Let's track these pages per zone.

Pass a page instead of the zone to adjust_present_page_count(), similar
as adjust_managed_page_count() and derive the zone from the page.

It's worth noting that a memory block to be offlined/onlined is either
completely "early" or "not early". add_memory() and friends can only add
complete memory blocks and we only online/offline complete (individual)
memory blocks.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c          | 14 +++++++-------
 include/linux/memory_hotplug.h |  2 +-
 include/linux/mmzone.h         |  7 +++++++
 mm/memory_hotplug.c            | 14 +++++++++++---
 mm/page_alloc.c                |  3 +++
 5 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index aa31a21f33d7..86ec2dc82fc2 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -205,7 +205,8 @@ static int memory_block_online(struct memory_block *mem)
 	 * now already properly populated.
 	 */
 	if (nr_vmemmap_pages)
-		adjust_present_page_count(zone, nr_vmemmap_pages);
+		adjust_present_page_count(pfn_to_page(start_pfn),
+					  nr_vmemmap_pages);
 
 	return ret;
 }
@@ -215,24 +216,23 @@ static int memory_block_offline(struct memory_block *mem)
 	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
 	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
 	unsigned long nr_vmemmap_pages = mem->nr_vmemmap_pages;
-	struct zone *zone;
 	int ret;
 
 	/*
 	 * Unaccount before offlining, such that unpopulated zone and kthreads
 	 * can properly be torn down in offline_pages().
 	 */
-	if (nr_vmemmap_pages) {
-		zone = page_zone(pfn_to_page(start_pfn));
-		adjust_present_page_count(zone, -nr_vmemmap_pages);
-	}
+	if (nr_vmemmap_pages)
+		adjust_present_page_count(pfn_to_page(start_pfn),
+					  -nr_vmemmap_pages);
 
 	ret = offline_pages(start_pfn + nr_vmemmap_pages,
 			    nr_pages - nr_vmemmap_pages);
 	if (ret) {
 		/* offline_pages() failed. Account back. */
 		if (nr_vmemmap_pages)
-			adjust_present_page_count(zone, nr_vmemmap_pages);
+			adjust_present_page_count(pfn_to_page(start_pfn),
+						  nr_vmemmap_pages);
 		return ret;
 	}
 
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 068e3dcf4690..39b04e99a30e 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -95,7 +95,7 @@ static inline void zone_seqlock_init(struct zone *zone)
 extern int zone_grow_free_lists(struct zone *zone, unsigned long new_nr_pages);
 extern int zone_grow_waitqueues(struct zone *zone, unsigned long nr_pages);
 extern int add_one_highpage(struct page *page, int pfn, int bad_ppro);
-extern void adjust_present_page_count(struct zone *zone, long nr_pages);
+extern void adjust_present_page_count(struct page *page, long nr_pages);
 /* VM interface that may be used by firmware interface */
 extern int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
 				     struct zone *zone);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index fcb535560028..6fbe59702bf2 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -540,6 +540,10 @@ struct zone {
 	 * is calculated as:
 	 *	present_pages = spanned_pages - absent_pages(pages in holes);
 	 *
+	 * present_early_pages is present pages existing within the zone
+	 * located on memory available since early boot, excluding hotplugged
+	 * memory.
+	 *
 	 * managed_pages is present pages managed by the buddy system, which
 	 * is calculated as (reserved_pages includes pages allocated by the
 	 * bootmem allocator):
@@ -572,6 +576,9 @@ struct zone {
 	atomic_long_t		managed_pages;
 	unsigned long		spanned_pages;
 	unsigned long		present_pages;
+#if defined(CONFIG_MEMORY_HOTPLUG)
+	unsigned long		present_early_pages;
+#endif
 #ifdef CONFIG_CMA
 	unsigned long		cma_pages;
 #endif
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 388c8627f17f..65dbb30f81c2 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -724,8 +724,16 @@ struct zone *zone_for_pfn_range(int online_type, int nid,
  * This function should only be called by memory_block_{online,offline},
  * and {online,offline}_pages.
  */
-void adjust_present_page_count(struct zone *zone, long nr_pages)
+void adjust_present_page_count(struct page *page, long nr_pages)
 {
+	struct zone *zone = page_zone(page);
+
+	/*
+	 * We only support onlining/offlining/adding/removing of complete
+	 * memory blocks; therefore, either all is either early or hotplugged.
+	 */
+	if (early_section(__pfn_to_section(page_to_pfn(page))))
+		zone->present_early_pages += nr_pages;
 	zone->present_pages += nr_pages;
 	zone->zone_pgdat->node_present_pages += nr_pages;
 }
@@ -826,7 +834,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages, struct zone *z
 	}
 
 	online_pages_range(pfn, nr_pages);
-	adjust_present_page_count(zone, nr_pages);
+	adjust_present_page_count(pfn_to_page(pfn), nr_pages);
 
 	node_states_set_node(nid, &arg);
 	if (need_zonelists_rebuild)
@@ -1704,7 +1712,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 
 	/* removal success */
 	adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
-	adjust_present_page_count(zone, -nr_pages);
+	adjust_present_page_count(pfn_to_page(start_pfn), -nr_pages);
 
 	/* reinitialise watermarks and update pcp limits */
 	init_per_zone_wmark_min();
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 856b175c15a4..9db6ef14c037 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7258,6 +7258,9 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
 			zone->zone_start_pfn = 0;
 		zone->spanned_pages = size;
 		zone->present_pages = real_size;
+#if defined(CONFIG_MEMORY_HOTPLUG)
+		zone->present_early_pages = real_size;
+#endif
 
 		totalpages += size;
 		realtotalpages += real_size;
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
