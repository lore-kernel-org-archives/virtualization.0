Return-Path: <SRS0=epgR=M5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DA0C432BE
	for <virtualization@archiver.kernel.org>; Fri,  6 Aug 2021 12:48:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4773611C3
	for <virtualization@archiver.kernel.org>; Fri,  6 Aug 2021 12:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E4773611C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AD99740376;
	Fri,  6 Aug 2021 12:48:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hXQaXtebZXpP; Fri,  6 Aug 2021 12:48:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D2C3A4021C;
	Fri,  6 Aug 2021 12:48:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB171C001A;
	Fri,  6 Aug 2021 12:48:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 818ABC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 12:48:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7100C40607
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 12:48:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lczFBUafXHGM
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 12:48:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9BB3B405F5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 Aug 2021 12:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628254085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IWMcou/EYbkIXX6QDjQhxWRbupJGFMicUk0ngfPPMvc=;
 b=MLNHDOKrrhliAZqRNaPhANrh+R0V4WRuoKl+KsMVsVPPKpjmv5WiiGYZPJtYjylIKAgwjU
 wfkbDURZjH/VGon8WaUPJbR3elpNWOxWWb/H03xQ2n9WRxchKLx2VAgoaU58clfb2xLhvB
 ti0jDQPEJxoAPfipfNFsBeq3VUEG5t0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-zyKaVMu5OIaNvHudAHck5Q-1; Fri, 06 Aug 2021 08:48:04 -0400
X-MC-Unique: zyKaVMu5OIaNvHudAHck5Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 452B494DC1;
 Fri,  6 Aug 2021 12:48:02 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.224])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E4DE5D6A1;
 Fri,  6 Aug 2021 12:47:53 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/9] mm/memory_hotplug: track present pages in memory groups
Date: Fri,  6 Aug 2021 14:47:10 +0200
Message-Id: <20210806124715.17090-5-david@redhat.com>
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

Let's track all present pages in each memory group. Especially, track
memory present in ZONE_MOVABLE and memory present in one of the kernel
zones (which really only is ZONE_NORMAL right now as memory groups only
apply to hotplugged memory) separately within a memory group, to prepare
for making smart auto-online decision for individual memory blocks within a
memory group based on group statistics.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c          | 10 +++++-----
 include/linux/memory.h         |  6 ++++++
 include/linux/memory_hotplug.h | 13 +++++++++----
 mm/memory_hotplug.c            | 19 ++++++++++++++-----
 4 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 16f5a3610229..a1082013e10c 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -198,7 +198,7 @@ static int memory_block_online(struct memory_block *mem)
 	}
 
 	ret = online_pages(start_pfn + nr_vmemmap_pages,
-			   nr_pages - nr_vmemmap_pages, zone);
+			   nr_pages - nr_vmemmap_pages, zone, mem->group);
 	if (ret) {
 		if (nr_vmemmap_pages)
 			mhp_deinit_memmap_on_memory(start_pfn, nr_vmemmap_pages);
@@ -210,7 +210,7 @@ static int memory_block_online(struct memory_block *mem)
 	 * now already properly populated.
 	 */
 	if (nr_vmemmap_pages)
-		adjust_present_page_count(pfn_to_page(start_pfn),
+		adjust_present_page_count(pfn_to_page(start_pfn), mem->group,
 					  nr_vmemmap_pages);
 
 	return ret;
@@ -228,16 +228,16 @@ static int memory_block_offline(struct memory_block *mem)
 	 * can properly be torn down in offline_pages().
 	 */
 	if (nr_vmemmap_pages)
-		adjust_present_page_count(pfn_to_page(start_pfn),
+		adjust_present_page_count(pfn_to_page(start_pfn), mem->group,
 					  -nr_vmemmap_pages);
 
 	ret = offline_pages(start_pfn + nr_vmemmap_pages,
-			    nr_pages - nr_vmemmap_pages);
+			    nr_pages - nr_vmemmap_pages, mem->group);
 	if (ret) {
 		/* offline_pages() failed. Account back. */
 		if (nr_vmemmap_pages)
 			adjust_present_page_count(pfn_to_page(start_pfn),
-						  nr_vmemmap_pages);
+						  mem->group, nr_vmemmap_pages);
 		return ret;
 	}
 
diff --git a/include/linux/memory.h b/include/linux/memory.h
index d505c12c5c77..6ffdc1db385f 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -27,6 +27,10 @@
  * struct memory_group - a logical group of memory blocks
  * @nid: The node id for all memory blocks inside the memory group.
  * @blocks: List of all memory blocks belonging to this memory group.
+ * @present_kernel_pages: Present (online) memory outside ZONE_MOVABLE of this
+ *			  memory group.
+ * @present_movable_pages: Present (online) memory in ZONE_MOVABLE of this
+ *			   memory group.
  * @is_dynamic: The memory group type: static vs. dynamic
  * @s.max_pages: Valid with &memory_group.is_dynamic == false. The maximum
  *		 number of pages we'll have in this static memory group.
@@ -48,6 +52,8 @@
 struct memory_group {
 	int nid;
 	struct list_head memory_blocks;
+	unsigned long present_kernel_pages;
+	unsigned long present_movable_pages;
 	bool is_dynamic;
 	union {
 		struct {
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 5d341978b4bc..cf3f423c8a74 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -12,6 +12,7 @@ struct zone;
 struct pglist_data;
 struct mem_section;
 struct memory_block;
+struct memory_group;
 struct resource;
 struct vmem_altmap;
 
@@ -100,13 +101,15 @@ static inline void zone_seqlock_init(struct zone *zone)
 extern int zone_grow_free_lists(struct zone *zone, unsigned long new_nr_pages);
 extern int zone_grow_waitqueues(struct zone *zone, unsigned long nr_pages);
 extern int add_one_highpage(struct page *page, int pfn, int bad_ppro);
-extern void adjust_present_page_count(struct page *page, long nr_pages);
+extern void adjust_present_page_count(struct page *page,
+				      struct memory_group *group,
+				      long nr_pages);
 /* VM interface that may be used by firmware interface */
 extern int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
 				     struct zone *zone);
 extern void mhp_deinit_memmap_on_memory(unsigned long pfn, unsigned long nr_pages);
 extern int online_pages(unsigned long pfn, unsigned long nr_pages,
-			struct zone *zone);
+			struct zone *zone, struct memory_group *group);
 extern struct zone *test_pages_in_a_zone(unsigned long start_pfn,
 					 unsigned long end_pfn);
 extern void __offline_isolated_pages(unsigned long start_pfn,
@@ -296,7 +299,8 @@ static inline void pgdat_resize_init(struct pglist_data *pgdat) {}
 #ifdef CONFIG_MEMORY_HOTREMOVE
 
 extern void try_offline_node(int nid);
-extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
+extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
+			 struct memory_group *group);
 extern int remove_memory(u64 start, u64 size);
 extern void __remove_memory(u64 start, u64 size);
 extern int offline_and_remove_memory(u64 start, u64 size);
@@ -304,7 +308,8 @@ extern int offline_and_remove_memory(u64 start, u64 size);
 #else
 static inline void try_offline_node(int nid) {}
 
-static inline int offline_pages(unsigned long start_pfn, unsigned long nr_pages)
+static inline int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
+				struct memory_group *group)
 {
 	return -EINVAL;
 }
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index f7017d8eb576..24feccfa7859 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -915,9 +915,11 @@ struct zone *zone_for_pfn_range(int online_type, int nid,
  * This function should only be called by memory_block_{online,offline},
  * and {online,offline}_pages.
  */
-void adjust_present_page_count(struct page *page, long nr_pages)
+void adjust_present_page_count(struct page *page, struct memory_group *group,
+			       long nr_pages)
 {
 	struct zone *zone = page_zone(page);
+	const bool movable = zone_idx(zone) == ZONE_MOVABLE;
 
 	/*
 	 * We only support onlining/offlining/adding/removing of complete
@@ -927,6 +929,11 @@ void adjust_present_page_count(struct page *page, long nr_pages)
 		zone->present_early_pages += nr_pages;
 	zone->present_pages += nr_pages;
 	zone->zone_pgdat->node_present_pages += nr_pages;
+
+	if (group && movable)
+		group->present_movable_pages += nr_pages;
+	else if (group && !movable)
+		group->present_kernel_pages += nr_pages;
 }
 
 int mhp_init_memmap_on_memory(unsigned long pfn, unsigned long nr_pages,
@@ -972,7 +979,8 @@ void mhp_deinit_memmap_on_memory(unsigned long pfn, unsigned long nr_pages)
 	kasan_remove_zero_shadow(__va(PFN_PHYS(pfn)), PFN_PHYS(nr_pages));
 }
 
-int __ref online_pages(unsigned long pfn, unsigned long nr_pages, struct zone *zone)
+int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
+		       struct zone *zone, struct memory_group *group)
 {
 	unsigned long flags;
 	int need_zonelists_rebuild = 0;
@@ -1025,7 +1033,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages, struct zone *z
 	}
 
 	online_pages_range(pfn, nr_pages);
-	adjust_present_page_count(pfn_to_page(pfn), nr_pages);
+	adjust_present_page_count(pfn_to_page(pfn), group, nr_pages);
 
 	node_states_set_node(nid, &arg);
 	if (need_zonelists_rebuild)
@@ -1776,7 +1784,8 @@ static int count_system_ram_pages_cb(unsigned long start_pfn,
 	return 0;
 }
 
-int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
+int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
+			struct memory_group *group)
 {
 	const unsigned long end_pfn = start_pfn + nr_pages;
 	unsigned long pfn, system_ram_pages = 0;
@@ -1912,7 +1921,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 
 	/* removal success */
 	adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
-	adjust_present_page_count(pfn_to_page(start_pfn), -nr_pages);
+	adjust_present_page_count(pfn_to_page(start_pfn), group, -nr_pages);
 
 	/* reinitialise watermarks and update pcp limits */
 	init_per_zone_wmark_min();
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
