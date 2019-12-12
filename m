From: David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC v4 12/13] mm/vmscan: Export drop_slab() and
 drop_slab_node()
Date: Thu, 12 Dec 2019 18:11:36 +0100
Message-ID: <20191212171137.13872-13-david__31730.9402556688$1576170831$gmane$org@redhat.com>
References: <20191212171137.13872-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191212171137.13872-1-david@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: linux-kernel@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

We already have a way to trigger reclaiming of all reclaimable slab objects
from user space (echo 2 > /proc/sys/vm/drop_caches). Let's allow drivers
to also trigger this when they really want to make progress and know what
they are doing.

virtio-mem wants to use these functions when it failed to unplug memory
for quite some time (e.g., after 30 minutes). It will then try to
free up reclaimable objects by dropping the slab caches every now and
then (e.g., every 30 minutes) as long as necessary. There will be a way to
disable this feature and info messages will be logged.

In the future, we want to have a drop_slab_range() functionality
instead. Memory offlining code has similar demands and also other
alloc_contig_range() users (e.g., gigantic pages) could make good use of
this feature. Adding it, however, requires more work/thought.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 4 ++--
 mm/vmscan.c        | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 64799c5cb39f..483300f58be8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2706,8 +2706,8 @@ int drop_caches_sysctl_handler(struct ctl_table *, int,
 					void __user *, size_t *, loff_t *);
 #endif
 
-void drop_slab(void);
-void drop_slab_node(int nid);
+extern void drop_slab(void);
+extern void drop_slab_node(int nid);
 
 #ifndef CONFIG_MMU
 #define randomize_va_space 0
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c3e53502a84a..4e1cdaaec5e6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -719,6 +719,7 @@ void drop_slab_node(int nid)
 		} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
 	} while (freed > 10);
 }
+EXPORT_SYMBOL(drop_slab_node);
 
 void drop_slab(void)
 {
@@ -728,6 +729,7 @@ void drop_slab(void)
 		drop_slab_node(nid);
 	count_vm_event(DROP_SLAB);
 }
+EXPORT_SYMBOL(drop_slab);
 
 static inline int is_page_cache_freeable(struct page *page)
 {
-- 
2.23.0
