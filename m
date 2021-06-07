Return-Path: <SRS0=jANb=LB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0171C47094
	for <virtualization@archiver.kernel.org>; Mon,  7 Jun 2021 19:55:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92C0E611BD
	for <virtualization@archiver.kernel.org>; Mon,  7 Jun 2021 19:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C0E611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D14882513;
	Mon,  7 Jun 2021 19:55:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xkGDKcnlmVQS; Mon,  7 Jun 2021 19:55:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id DAD1481D34;
	Mon,  7 Jun 2021 19:55:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6029C000E;
	Mon,  7 Jun 2021 19:55:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D425C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 19:54:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B24082513
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 19:54:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IE3q-KES7M2h
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 19:54:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E92A81D34
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 19:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623095697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wn5HEanvq6cV+H/hmppNuHJLR2f/Vr4t/qqBD5o0Vjg=;
 b=AC/xGdA4OYEvDKCwvADGgpuODRGUy+VtnOeNyaPW1UgyjXcLCSVgWp9LPISje+T18H6O8Y
 NxKhh7O5eg7pupmszCdHSVnQCb0H8nKPyrrscY7ot1nwAt5FGCO4e2S8YujnvhVsoaXEy7
 cH6X5fo1z/DZhSTMypQ9K+6yxfIhbzI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-bo-VIC_BPUq9gnm3JgGUOw-1; Mon, 07 Jun 2021 15:54:54 -0400
X-MC-Unique: bo-VIC_BPUq9gnm3JgGUOw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EDB73FE4;
 Mon,  7 Jun 2021 19:54:52 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-9.ams2.redhat.com [10.36.112.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D856A10013C1;
 Mon,  7 Jun 2021 19:54:47 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 02/12] mm: track present early pages per zone
Date: Mon,  7 Jun 2021 21:54:20 +0200
Message-Id: <20210607195430.48228-3-david@redhat.com>
In-Reply-To: <20210607195430.48228-1-david@redhat.com>
References: <20210607195430.48228-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
 mm/memory_hotplug.c            | 13 ++++++++++---
 mm/page_alloc.c                |  3 +++
 5 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index d5ffaab3cb61..427323620ce8 100644
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
index 57a8aa463ccb..571734fd95bd 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -107,7 +107,7 @@ static inline void zone_seqlock_init(struct zone *zone)
 extern int zone_grow_free_lists(struct zone *zone, unsigned long new_nr_pages);
 extern int zone_grow_waitqueues(struct zone *zone, unsigned long nr_pages);
 extern int add_one_highpage(struct page *page, int pfn, int bad_ppro);
-extern void adjust_present_page_count(struct zone *zone, long nr_pages);
+extern void adjust_present_page_count(struct page *page, long nr_pages);
 /* VM interface that may be used by firmware interface */
 extern int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
 				     struct zone *zone);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 0d53eba1c383..71621f96077e 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -512,6 +512,10 @@ struct zone {
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
@@ -544,6 +548,9 @@ struct zone {
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
index 4969614d2140..f2646db86190 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -850,10 +850,17 @@ struct zone *zone_for_pfn_range(int online_type, int nid,
  * This function should only be called by memory_block_{online,offline},
  * and {online,offline}_pages.
  */
-void adjust_present_page_count(struct zone *zone, long nr_pages)
+void adjust_present_page_count(struct page *page, long nr_pages)
 {
+	struct zone *zone = page_zone(page);
 	unsigned long flags;
 
+	/*
+	 * We only support onlining/offlining/adding/removing of complete
+	 * memory blocks; therefore, either all is early or hotplugged.
+	 */
+	if (early_section(__pfn_to_section(page_to_pfn(page))))
+		zone->present_early_pages += nr_pages;
 	zone->present_pages += nr_pages;
 	pgdat_resize_lock(zone->zone_pgdat, &flags);
 	zone->zone_pgdat->node_present_pages += nr_pages;
@@ -956,7 +963,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages, struct zone *z
 	}
 
 	online_pages_range(pfn, nr_pages);
-	adjust_present_page_count(zone, nr_pages);
+	adjust_present_page_count(pfn_to_page(pfn), nr_pages);
 
 	node_states_set_node(nid, &arg);
 	if (need_zonelists_rebuild)
@@ -1827,7 +1834,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 
 	/* removal success */
 	adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
-	adjust_present_page_count(zone, -nr_pages);
+	adjust_present_page_count(pfn_to_page(start_pfn), -nr_pages);
 
 	init_per_zone_wmark_min();
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d1f5de1c1283..08f68238882e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7007,6 +7007,9 @@ static void __init calculate_node_totalpages(struct pglist_data *pgdat,
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
