Return-Path: <SRS0=XE2Y=MP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9FCC4320E
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 12:54:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D54FF60E53
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 12:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D54FF60E53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3705605A5;
	Fri, 23 Jul 2021 12:54:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q964DLD_EGnY; Fri, 23 Jul 2021 12:53:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E835660664;
	Fri, 23 Jul 2021 12:53:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2384C001A;
	Fri, 23 Jul 2021 12:53:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48A6EC000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 12:53:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 36A804061F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 12:53:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uHM7JRVWOoRp
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 12:53:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0B4AE4061C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 12:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1627044836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O1uVpq3VWXm3ro+I0Xd02UDOD3WHDdV/V+TH3BzpbZU=;
 b=FEUiWJRtKvbjt2XdLZah8aty3R46NDolS7YNchSvHMLW/yoSxaSw9DQANAhMcXqaT1fw8D
 njKcK/QKECSgRBvkqhr/x+k2Rhu+SUyrkJw7C57zCgqBIR+ky01rbpo7CdbOP8UixiREOo
 IlebAR5kMxmwwj+DaG3Ah8LW0gH8DC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-VDEwb_-mPEKyW0t5tLWUXw-1; Fri, 23 Jul 2021 08:53:54 -0400
X-MC-Unique: VDEwb_-mPEKyW0t5tLWUXw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E42987D545;
 Fri, 23 Jul 2021 12:53:52 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-253.ams2.redhat.com [10.36.112.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F16D3AC1;
 Fri, 23 Jul 2021 12:53:45 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] mm/memory_hotplug: improved dynamic memory group aware
 "auto-movable" online policy
Date: Fri, 23 Jul 2021 14:52:10 +0200
Message-Id: <20210723125210.29987-10-david@redhat.com>
In-Reply-To: <20210723125210.29987-1-david@redhat.com>
References: <20210723125210.29987-1-david@redhat.com>
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

Currently, the "auto-movable" online policy does not allow for hotplugged
KERNEL (ZONE_NORMAL) memory to increase the amount of MOVABLE memory we can
have, primarily, because there is no coordiantion across memory devices and
we don't want to create zone-imbalances accidentially when unplugging
memory.

However, within a single memory device it's different. Let's allow for
KERNEL memory within a dynamic memory group to allow for more MOVABLE
within the same memory group. The only thing we have to take care of is
that the managing driver avoids zone imbalances by unplugging MOVABLE
memory first, otherwise there can be corner cases where unplug of memory
could result in (accidential) zone imbalances.

virtio-mem is the only user of dynamic memory groups and recently added
support for prioritizing unplug of ZONE_MOVABLE over ZONE_NORMAL, so we
don't need a new toggle to enable it for dynamic memory groups.

We limit this handling to dynamic memory groups, because:

* We want to keep the runtime overhead for collecting stats when onlining
  a single memory block small. We tend to have only a handful of dynamic
  memory groups, but we can have quite some static memory groups (e.g., 256
  DIMMs).
* It doesn't make too much sense for static memory groups, as we try
  onlining all applicable memory blocks either completely to ZONE_MOVABLE
  or not. In ordinary operation, we won't have a mixture of zones
  within a static memory group.

When adding memory to a dynamic memory group, we'll first online memory to
ZONE_MOVABLE as long as early KERNEL memory allows for it. Then, we'll
online the next unit(s) to ZONE_NORMAL, until we can online the next
unit(s) to ZONE_MOVABLE.

For a simple virtio-mem device with a MOVABLE:KERNEL ratio of 3:1, it
will result in a layout like:

  [M][M][M][M][M][M][M][M][N][M][M][M][N][M][M][M]...
  ^ movable memory due to early kernel memory
			   ^ allows for more movable memory ...
			      ^-----^ ... here
				       ^ allows for more movable memory ...
				          ^-----^ ... here

While the created layout is sub-optimal when it comes to contiguous zones,
it gives us the maximum flexibility when dynamically growing/shrinking a
device; we can grow small VMs really big in small steps, and still
shrink reliably to e.g., 1/4 of the maximum VM size in this example,
removing full memory blocks along with meta data more reliably.

Mark dynamic memory groups in the xarray such that we can efficiently
iterate over them when collecting stats. In usual setups, we have one
virtio-mem device per NUMA node, and usually only a small number of NUMA
nodes.

Note: for now, there seems to be no compelling reason to make this
behavior configurable.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/memory.c  | 25 ++++++++++++++++++
 include/linux/memory.h |  3 +++
 mm/memory_hotplug.c    | 60 +++++++++++++++++++++++++++++++++++++++---
 3 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 1d34f30a9a80..e09084009f3b 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -86,6 +86,7 @@ static DEFINE_XARRAY(memory_blocks);
  * Memory groups, indexed by memory group identification (mgid).
  */
 static DEFINE_XARRAY_FLAGS(memory_groups, XA_FLAGS_ALLOC);
+#define MEMORY_GROUP_MARK_DYNAMIC	XA_MARK_1
 
 static BLOCKING_NOTIFIER_HEAD(memory_chain);
 
@@ -931,6 +932,8 @@ static int register_memory_group(struct memory_group group)
 		       GFP_KERNEL);
 	if (ret)
 		kfree(new_group);
+	else if (group.is_dynamic)
+		xa_set_mark(&memory_groups, mgid, MEMORY_GROUP_MARK_DYNAMIC);
 	return ret ? ret : mgid;
 }
 
@@ -987,3 +990,25 @@ struct memory_group *get_memory_group(int mgid)
 {
 	return xa_load(&memory_groups, mgid);
 }
+
+int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
+			       struct memory_group *excluded, void *arg)
+{
+	struct memory_group *group;
+	unsigned long index;
+	int ret = 0;
+
+	xa_for_each_marked(&memory_groups, index, group,
+			   MEMORY_GROUP_MARK_DYNAMIC) {
+		if (group == excluded)
+			continue;
+#ifdef CONFIG_NUMA
+		if (nid != NUMA_NO_NODE && group->nid != nid)
+			continue;
+#endif /* CONFIG_NUMA */
+		ret = func(group, arg);
+		if (ret)
+			break;
+	}
+	return ret;
+}
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 0eceb8467d9a..c56260853caf 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -142,6 +142,9 @@ extern int register_static_memory_group(int nid, unsigned long max_pages);
 extern int register_dynamic_memory_group(int nid, unsigned long unit_pages);
 extern int unregister_memory_group(int mgid);
 struct memory_group *get_memory_group(int mgid);
+typedef int (*walk_memory_groups_func_t)(struct memory_group *, void *);
+int walk_dynamic_memory_groups(int nid, walk_memory_groups_func_t func,
+			       struct memory_group *excluded, void *arg);
 
 #define CONFIG_MEM_BLOCK_SIZE	(PAGES_PER_SECTION<<PAGE_SHIFT)
 #endif /* CONFIG_MEMORY_HOTPLUG_SPARSE */
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 93fb89efdc80..bfdaa28eb86f 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -750,11 +750,44 @@ static void auto_movable_stats_account_zone(struct auto_movable_stats *stats,
 		stats->kernel_early_pages -= zone->cma_pages;
 	}
 }
+struct auto_movable_group_stats {
+	unsigned long movable_pages;
+	unsigned long req_kernel_early_pages;
+};
 
-static bool auto_movable_can_online_movable(int nid, unsigned long nr_pages)
+static int auto_movable_stats_account_group(struct memory_group *group,
+					   void *arg)
+{
+	const int ratio = READ_ONCE(auto_movable_ratio);
+	struct auto_movable_group_stats *stats = arg;
+	long pages;
+
+	/*
+	 * We don't support modifying the config while the auto-movable online
+	 * mode is already enabled. Just avoid the division by zero below.
+	 */
+	if (!ratio)
+		return 0;
+
+	/*
+	 * Calculate how many early kernel pages this group requires to
+	 * satisfy the configured zone ratio.
+	 */
+	pages = group->present_movable_pages * 100 / ratio;
+	pages -= group->present_kernel_pages;
+
+	if (pages > 0)
+		stats->req_kernel_early_pages += pages;
+	stats->movable_pages += group->present_movable_pages;
+	return 0;
+}
+
+static bool auto_movable_can_online_movable(int nid, struct memory_group *group,
+					    unsigned long nr_pages)
 {
-	struct auto_movable_stats stats = {};
 	unsigned long kernel_early_pages, movable_pages;
+	struct auto_movable_group_stats group_stats = {};
+	struct auto_movable_stats stats = {};
 	pg_data_t *pgdat = NODE_DATA(nid);
 	struct zone *zone;
 	int i;
@@ -775,6 +808,21 @@ static bool auto_movable_can_online_movable(int nid, unsigned long nr_pages)
 	kernel_early_pages = stats.kernel_early_pages;
 	movable_pages = stats.movable_pages;
 
+	/*
+	 * Kernel memory inside dynamic memory group allows for more MOVABLE
+	 * memory within the same group. Remove the effect of all but the
+	 * current group from the stats.
+	 */
+	walk_dynamic_memory_groups(nid, auto_movable_stats_account_group,
+				   group, &group_stats);
+	if (kernel_early_pages <= group_stats.req_kernel_early_pages)
+		return false;
+	kernel_early_pages -= group_stats.req_kernel_early_pages;
+	movable_pages -= group_stats.movable_pages;
+
+	if (group && group->is_dynamic)
+		kernel_early_pages += group->present_kernel_pages;
+
 	/*
 	 * Test if we could online the given number of pages to ZONE_MOVABLE
 	 * and still stay in the configured ratio.
@@ -832,6 +880,10 @@ static struct zone *default_kernel_zone_for_pfn(int nid, unsigned long start_pfn
  *    with unmovable allocations). While there are corner cases where it might
  *    still work, it is barely relevant in practice.
  *
+ * Exceptions are dynamic memory groups, which allow for more MOVABLE
+ * memory within the same memory group -- because in that case, there is
+ * coordination within the single memory device managed by a single driver.
+ *
  * We rely on "present pages" instead of "managed pages", as the latter is
  * highly unreliable and dynamic in virtualized environments, and does not
  * consider boot time allocations. For example, memory ballooning adjusts the
@@ -897,12 +949,12 @@ static struct zone *auto_movable_zone_for_pfn(int nid,
 	 * nobody interferes, all will be MOVABLE if possible.
 	 */
 	nr_pages = max_pages - online_pages;
-	if (!auto_movable_can_online_movable(NUMA_NO_NODE, nr_pages))
+	if (!auto_movable_can_online_movable(NUMA_NO_NODE, group, nr_pages))
 		goto kernel_zone;
 
 #ifdef CONFIG_NUMA
 	if (auto_movable_numa_aware &&
-	    !auto_movable_can_online_movable(nid, nr_pages))
+	    !auto_movable_can_online_movable(nid, group, nr_pages))
 		goto kernel_zone;
 #endif /* CONFIG_NUMA */
 
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
