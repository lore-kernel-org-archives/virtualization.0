From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 0/6] mm / virtio-mem: support ZONE_MOVABLE
Date: Tue, 30 Jun 2020 16:26:33 +0200
Message-ID: <20200630142639.22770-1-david@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org, linux-mm@kvack.org, David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@suse.com>
List-Id: virtualization@lists.linuxfoundation.org

Currently, virtio-mem does not really support ZONE_MOVABLE. While it allows
to online fully plugged memory blocks to ZONE_MOVABLE, it does not allow
to online partially-plugged memory blocks to ZONE_MOVABLE and will never
consider such memory blocks when unplugging memory. This might be
surprising for users (especially, if onlining suddenly fails).

Let's support partially plugged memory blocks in ZONE_MOVABLE, allowing
partially plugged memory blocks to be online to ZONE_MOVABLE and also
unplugging from such memory blocks.

This is especially helpful for testing, but also paves the way for
virtio-mem optimizations, allowing more memory to get reliably unplugged.

Cleanup has_unmovable_pages() and set_migratetype_isolate(), providing
better documentation of how ZONE_MOVABLE interacts with different kind of
unmovable pages (memory offlining vs. alloc_contig_range()).

David Hildenbrand (6):
  mm/page_alloc: tweak comments in has_unmovable_pages()
  mm/page_isolation: don't dump_page(NULL) in set_migratetype_isolate()
  mm/page_isolation: drop WARN_ON_ONCE() in set_migratetype_isolate()
  mm/page_isolation: cleanup set_migratetype_isolate()
  mm/page_alloc: restrict ZONE_MOVABLE optimization in
    has_unmovable_pages() to memory offlining
  virtio-mem: don't special-case ZONE_MOVABLE

 drivers/virtio/virtio_mem.c | 47 +++++++------------------------------
 mm/page_alloc.c             | 29 +++++++++--------------
 mm/page_isolation.c         | 40 ++++++++++++++-----------------
 3 files changed, 36 insertions(+), 80 deletions(-)

-- 
2.26.2
