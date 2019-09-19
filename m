From: David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC v3 4/9] mm: Export alloc_contig_range() /
	free_contig_range()
Date: Thu, 19 Sep 2019 16:22:23 +0200
Message-ID: <20190919142228.5483-5-david__34319.1035020695$1568903023$gmane$org@redhat.com>
References: <20190919142228.5483-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190919142228.5483-1-david@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Andrea Arcangeli <aarcange@redhat.com>, Pavel Tatashin <pavel.tatashin@microsoft.com>, Michal Hocko <mhocko@suse.com>, Alexander Duyck <alexander.h.duyck@linux.intel.com>, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Mel Gorman <mgorman@techsingularity.net>, Dan Williams <dan.j.williams@intel.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

A virtio-mem device wants to allocate memory from the memory region it
manages in order to unplug it in the hypervisor - similar to
a balloon driver. Also, it might want to plug previously unplugged
(allocated) memory and give it back to Linux. alloc_contig_range() /
free_contig_range() seem to be the perfect interface for this task.

In contrast to existing balloon devices, a virtio-mem device operates
on bigger chunks (e.g., 4MB) and only on physical memory it manages. It
tracks which chunks (subblocks) are still plugged, so it can go ahead
and try to alloc_contig_range()+unplug them on unplug request, or
plug+free_contig_range() unplugged chunks on plug requests.

A virtio-mem device will use alloc_contig_range() / free_contig_range()
only on ranges that belong to the same node/zone in at least
MAX(MAX_ORDER - 1, pageblock_order) order granularity - e.g., 4MB on
x86-64. The virtio-mem device added that memory, so the memory
exists and does not contain any holes. virtio-mem will only try to allocate
on ZONE_NORMAL, never on ZONE_MOVABLE, just like when allocating
gigantic pages (we don't put unmovable data into the movable zone).

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Pavel Tatashin <pavel.tatashin@microsoft.com>
Cc: Alexander Potapenko <glider@google.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3334a769eb91..d5d7944954b3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8469,6 +8469,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 				pfn_max_align_up(end), migratetype);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(alloc_contig_range);
 #endif /* CONFIG_CONTIG_ALLOC */
 
 void free_contig_range(unsigned long pfn, unsigned int nr_pages)
@@ -8483,6 +8484,7 @@ void free_contig_range(unsigned long pfn, unsigned int nr_pages)
 	}
 	WARN(count != 0, "%d pages are still in use!\n", count);
 }
+EXPORT_SYMBOL_GPL(free_contig_range);
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 /*
-- 
2.21.0
