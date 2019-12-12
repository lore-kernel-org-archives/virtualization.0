From: David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC v4 11/13] mm/vmscan: Move count_vm_event(DROP_SLAB) into
 drop_slab()
Date: Thu, 12 Dec 2019 18:11:35 +0100
Message-ID: <20191212171137.13872-12-david__20523.0934823462$1576170818$gmane$org@redhat.com>
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
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Let's count within the function itself, so every invocation (of future
users) will be counted.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 fs/drop_caches.c | 4 +---
 mm/vmscan.c      | 1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index d31b6c72b476..a042da782fcd 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -61,10 +61,8 @@ int drop_caches_sysctl_handler(struct ctl_table *table, int write,
 			iterate_supers(drop_pagecache_sb, NULL);
 			count_vm_event(DROP_PAGECACHE);
 		}
-		if (sysctl_drop_caches & 2) {
+		if (sysctl_drop_caches & 2)
 			drop_slab();
-			count_vm_event(DROP_SLAB);
-		}
 		if (!stfu) {
 			pr_info("%s (%d): drop_caches: %d\n",
 				current->comm, task_pid_nr(current),
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5a6445e86328..c3e53502a84a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -726,6 +726,7 @@ void drop_slab(void)
 
 	for_each_online_node(nid)
 		drop_slab_node(nid);
+	count_vm_event(DROP_SLAB);
 }
 
 static inline int is_page_cache_freeable(struct page *page)
-- 
2.23.0
