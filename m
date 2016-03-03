From: Liang Li <liang.z.li@intel.com>
Subject: [RFC qemu 3/4] migration: not set migration bitmap in setup stage
Date: Thu,  3 Mar 2016 18:44:27 +0800
Message-ID: <1457001868-15949-4-git-send-email-liang.z.li__1277.74553043327$1457019642$gmane$org@intel.com>
References: <1457001868-15949-1-git-send-email-liang.z.li@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1457001868-15949-1-git-send-email-liang.z.li@intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: quintela@redhat.com, amit.shah@redhat.com, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, mst@redhat.com, Liang Li <liang.z.li@intel.com>, dgilbert@redhat.com, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, pbonzini@redhat.com, akpm@linux-foundation.org, rth@twiddle.net
List-Id: virtualization@lists.linuxfoundation.org

Set ram_list.dirty_memory instead of migration bitmap, the migration
bitmap will be update when doing migration_bitmap_sync().
Set migration_dirty_pages to 0 and it will be updated by
migration_dirty_pages() too.

The following patch is based on this change.

Signed-off-by: Liang Li <liang.z.li@intel.com>
---
 migration/ram.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 704f6a9..ee2547d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1931,19 +1931,19 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     ram_bitmap_pages = last_ram_offset() >> TARGET_PAGE_BITS;
     migration_bitmap_rcu = g_new0(struct BitmapRcu, 1);
     migration_bitmap_rcu->bmap = bitmap_new(ram_bitmap_pages);
-    bitmap_set(migration_bitmap_rcu->bmap, 0, ram_bitmap_pages);
 
     if (migrate_postcopy_ram()) {
         migration_bitmap_rcu->unsentmap = bitmap_new(ram_bitmap_pages);
         bitmap_set(migration_bitmap_rcu->unsentmap, 0, ram_bitmap_pages);
     }
 
-    /*
-     * Count the total number of pages used by ram blocks not including any
-     * gaps due to alignment or unplugs.
-     */
-    migration_dirty_pages = ram_bytes_total() >> TARGET_PAGE_BITS;
+    migration_dirty_pages = 0;
 
+    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
+        cpu_physical_memory_set_dirty_range(block->offset,
+                                            block->used_length,
+                                            DIRTY_MEMORY_MIGRATION);
+    }
     memory_global_dirty_log_start();
     migration_bitmap_sync();
     qemu_mutex_unlock_ramlist();
-- 
1.8.3.1
