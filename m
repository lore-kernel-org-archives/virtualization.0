From: Minchan Kim <minchan@kernel.org>
Subject: [PATCH v1 00/19] Support non-lru page migration
Date: Fri, 11 Mar 2016 16:30:04 +0900
Message-ID: <1457681423-26664-1-git-send-email-minchan__47600.1808340245$1457682308$gmane$org@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Rik van Riel <riel@redhat.com>, aquini@redhat.com, rknize@motorola.com, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, bfields@fieldses.org, linux-mm@kvack.org, Gioh Kim <gurugio@hanmail.net>, koct9i@gmail.com, jlayton@poochiereds.net, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

Recently, I got many reports about perfermance degradation
in embedded system(Android mobile phone, webOS TV and so on)
and failed to fork easily.

The problem was fragmentation caused by zram and GPU driver
pages. Their pages cannot be migrated so compaction cannot
work well, either so reclaimer ends up shrinking all of working
set pages. It made system very slow and even to fail to fork
easily.

Other pain point is that they cannot work with CMA.
Most of CMA memory space could be idle(ie, it could be used
for movable pages unless driver is using) but if driver(i.e.,
zram) cannot migrate his page, that memory space could be
wasted. In our product which has big CMA memory, it reclaims
zones too exccessively although there are lots of free space
in CMA so system was very slow easily.

To solve these problem, this patch try to add facility to
migrate non-lru pages via introducing new friend functions
of migratepage in address_space_operation and new page flags.

	(isolate_page, putback_page)
	(PG_movable, PG_isolated)

For details, please read description in
"mm/compaction: support non-lru movable page migration".

Originally, Gioh Kim tried to support this feature but he moved
so I took over the work. But I took many code from his work and
changed a little bit.
Thanks, Gioh!

And I should mention Konstantin Khlebnikov. He really heped Gioh
at that time so he should deserve to have many credit, too.
Thanks, Konstantin!

This patchset consists of three parts

1. add non-lru page migration feature

  mm: use put_page to free page instead of putback_lru_page
  fs/anon_inodes: new interface to create new inode
  mm/compaction: support non-lru movable page migration

2. rework KVM memory-ballooning

  mm/balloon: use general movable page feature into balloon

3. rework zsmalloc

  zsmalloc: use first_page rather than page
  zsmalloc: clean up many BUG_ON
  zsmalloc: reordering function parameter
  zsmalloc: remove unused pool param in obj_free
  zsmalloc: keep max_object in size_class
  zsmalloc: squeeze inuse into page->mapping
  zsmalloc: squeeze freelist into page->mapping
  zsmalloc: move struct zs_meta from mapping to freelist
  zsmalloc: factor page chain functionality out
  zsmalloc: separate free_zspage from putback_zspage
  zsmalloc: zs_compact refactoring
  zsmalloc: migrate head page of zspage
  zsmalloc: use single linked list for page chain
  zsmalloc: migrate tail pages in zspage
  zram: use __GFP_MOVABLE for memory allocation

Gioh Kim (1):
  fs/anon_inodes: new interface to create new inode

Minchan Kim (18):
  mm: use put_page to free page instead of putback_lru_page
  mm/compaction: support non-lru movable page migration
  mm/balloon: use general movable page feature into balloon
  zsmalloc: use first_page rather than page
  zsmalloc: clean up many BUG_ON
  zsmalloc: reordering function parameter
  zsmalloc: remove unused pool param in obj_free
  zsmalloc: keep max_object in size_class
  zsmalloc: squeeze inuse into page->mapping
  zsmalloc: squeeze freelist into page->mapping
  zsmalloc: move struct zs_meta from mapping to freelist
  zsmalloc: factor page chain functionality out
  zsmalloc: separate free_zspage from putback_zspage
  zsmalloc: zs_compact refactoring
  zsmalloc: migrate head page of zspage
  zsmalloc: use single linked list for page chain
  zsmalloc: migrate tail pages in zspage
  zram: use __GFP_MOVABLE for memory allocation

 Documentation/filesystems/Locking      |    4 +
 Documentation/filesystems/vfs.txt      |    5 +
 drivers/block/zram/zram_drv.c          |    3 +-
 drivers/virtio/virtio_balloon.c        |    4 +
 fs/anon_inodes.c                       |    6 +
 fs/proc/page.c                         |    3 +
 include/linux/anon_inodes.h            |    1 +
 include/linux/balloon_compaction.h     |   47 +-
 include/linux/compaction.h             |    8 +
 include/linux/fs.h                     |    2 +
 include/linux/migrate.h                |    2 +
 include/linux/page-flags.h             |   42 +-
 include/uapi/linux/kernel-page-flags.h |    1 +
 mm/balloon_compaction.c                |  101 +--
 mm/compaction.c                        |   15 +-
 mm/migrate.c                           |  197 +++--
 mm/vmscan.c                            |    2 +-
 mm/zsmalloc.c                          | 1295 +++++++++++++++++++++++---------
 18 files changed, 1219 insertions(+), 519 deletions(-)

-- 
1.9.1
