From: Minchan Kim <minchan@kernel.org>
Subject: [PATCH v3 00/16] Support non-lru page migration
Date: Wed, 30 Mar 2016 16:11:59 +0900
Message-ID: <1459321935-3655-1-git-send-email-minchan__32187.9922332757$1459321862$gmane$org@kernel.org>
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
Cc: Rik van Riel <riel@redhat.com>, YiPing Xu <xuyiping@hisilicon.com>, aquini@redhat.com, rknize@motorola.com, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Chan Gyun Jeong <chan.jeong@lge.com>, Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>, virtualization@lists.linux-foundation.org, bfields@fieldses.org, linux-mm@kvack.org, Gioh Kim <gi-oh.kim@profitbricks.com>, koct9i@gmail.com, Sangseok Lee <sangseok.lee@lge.com>, jlayton@poochiereds.net, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>
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

This patchset consists of five parts.

1. clean up migration
  mm: use put_page to free page instead of putback_lru_page

2. add non-lru page migration feature
  mm/compaction: support non-lru movable page migration
  mm: add non-lru movable page support document

3. rework KVM memory-ballooning
  mm/balloon: use general movable page feature into balloon

4. zsmalloc clean-up for preparing page migration
  zsmalloc: keep max_object in size_class
  zsmalloc: squeeze inuse into page->mapping
  zsmalloc: remove page_mapcount_reset
  zsmalloc: squeeze freelist into page->mapping
  zsmalloc: move struct zs_meta from mapping to freelist
  zsmalloc: factor page chain functionality out
  zsmalloc: separate free_zspage from putback_zspage
  zsmalloc: zs_compact refactoring

5. add zsmalloc page migration
  zsmalloc: migrate head page of zspage
  zsmalloc: use single linked list for page chain
  zsmalloc: migrate tail pages in zspage
  zram: use __GFP_MOVABLE for memory allocation

* From v2
  * rebase on mmotm-2016-03-29-15-54-16
  * check PageMovable before lock_page - Joonsoo
  * check PageMovable before PageIsolated checking - Joonsoo
  * add more description about rule

* From v1
  * rebase on v4.5-mmotm-2016-03-17-15-04
  * reordering patches to merge clean-up patches first
  * add Acked-by/Reviewed-by from Vlastimil and Sergey
  * use each own mount model instead of reusing anon_inode_fs - Al Viro
  * small changes - YiPing, Gioh


Minchan Kim (16):
  mm: use put_page to free page instead of putback_lru_page
  mm/compaction: support non-lru movable page migration
  mm: add non-lru movable page support document
  mm/balloon: use general movable page feature into balloon
  zsmalloc: keep max_object in size_class
  zsmalloc: squeeze inuse into page->mapping
  zsmalloc: remove page_mapcount_reset
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
 Documentation/filesystems/vfs.txt      |   16 +-
 Documentation/vm/page_migration        |   69 +-
 drivers/block/zram/zram_drv.c          |    3 +-
 drivers/virtio/virtio_balloon.c        |   53 +-
 fs/proc/page.c                         |    3 +
 include/linux/balloon_compaction.h     |   49 +-
 include/linux/fs.h                     |    2 +
 include/linux/migrate.h                |    2 +
 include/linux/page-flags.h             |   47 +-
 include/uapi/linux/kernel-page-flags.h |    1 +
 include/uapi/linux/magic.h             |    2 +
 mm/balloon_compaction.c                |  101 +--
 mm/compaction.c                        |   15 +-
 mm/migrate.c                           |  238 ++++--
 mm/vmscan.c                            |    2 +-
 mm/zsmalloc.c                          | 1253 ++++++++++++++++++++++++--------
 17 files changed, 1368 insertions(+), 492 deletions(-)

-- 
1.9.1
