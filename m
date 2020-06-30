From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 5/6] mm/page_alloc: restrict ZONE_MOVABLE optimization in has_unmovable_pages() to memory offlining
Date: Tue, 30 Jun 2020 16:26:38 +0200
Message-ID: <20200630142639.22770-6-david@redhat.com>
References: <20200630142639.22770-1-david@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200630142639.22770-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, linux-mm@kvack.org, David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, "Michael S . Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

We can already have pages that can be offlined but not allocated in
ZONE_MOVABLE - PageHWPoison pages. While these pages can be skipped when
offlining ("moving them to /dev/null"), we cannot move them when
allocating.

virtio-mem managed memory is similar. The logical memory holes
corresponding to unplug memory ranges can be skipped when offlining,
however, the pages cannot be moved. Currently, virtio-mem special-cases
ZONE_MOVABLE, such that:
- partially plugged memory blocks it added to Linux cannot be onlined to
  ZONE_MOVABLE
- when unplugging memory, it will never consider memory blocks that were
  onlined to ZONE_MOVABLE

We also want to support ZONE_MOVABLE in virtio-mem for both cases. Note
that virtio-mem does not blindly try to unplug random pages within its
managed memory region. It always plugs memory left-to-right and tries to
unplug memory right-to-left - in roughly MAX_ORDER - 1 granularity. In
theory, the movable ZONE part would only shrink when unplugging memory
from ZONE_MOVABLE.

Let's perform the ZONE_MOVABLE optimization only for memory offlining,
such that we reduce the number of false positives from
has_unmovable_pages() in case of alloc_contig_range() on ZONE_MOVABLE.

Note: We currently don't seem to have any user of alloc_contig_range()
that actually uses ZONE_MOVABLE. This change is mostly valuable for the
documentation.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bd3ebf08f09b9..45077d74d975d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8237,9 +8237,12 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 		/*
 		 * If the zone is movable and we have ruled out all reserved
 		 * pages then it should be reasonably safe to assume the rest
-		 * is movable.
+		 * is movable. As we can have some pages in the movable zone
+		 * that are only considered movable for memory offlining (esp.,
+		 * PageHWPoison and PageOffline that will be skipped), we
+		 * perform this optimization only for memory offlining.
 		 */
-		if (zone_idx(zone) == ZONE_MOVABLE)
+		if ((flags & MEMORY_OFFLINE) && zone_idx(zone) == ZONE_MOVABLE)
 			continue;
 
 		/*
-- 
2.26.2
