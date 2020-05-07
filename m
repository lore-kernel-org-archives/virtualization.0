From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 13/15] virtio-mem: Unplug subblocks right-to-left
Date: Thu,  7 May 2020 16:01:37 +0200
Message-ID: <20200507140139.17083-14-david@redhat.com>
References: <20200507140139.17083-1-david@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200507140139.17083-1-david@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

We unplug blocks right-to-left, let's also unplug subblocks within a block
right-to-left.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 38 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 8dd57b61b09b..a719e1a04ac7 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -353,18 +353,6 @@ static bool virtio_mem_mb_test_sb_unplugged(struct virtio_mem *vm,
 	return find_next_bit(vm->sb_bitmap, bit + count, bit) >= bit + count;
 }
 
-/*
- * Find the first plugged subblock. Returns vm->nb_sb_per_mb in case there is
- * none.
- */
-static int virtio_mem_mb_first_plugged_sb(struct virtio_mem *vm,
-					  unsigned long mb_id)
-{
-	const int bit = (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb;
-
-	return find_next_bit(vm->sb_bitmap, bit + vm->nb_sb_per_mb, bit) - bit;
-}
-
 /*
  * Find the first unplugged subblock. Returns vm->nb_sb_per_mb in case there is
  * none.
@@ -1016,21 +1004,27 @@ static int virtio_mem_mb_unplug_any_sb(struct virtio_mem *vm,
 	int sb_id, count;
 	int rc;
 
+	sb_id = vm->nb_sb_per_mb - 1;
 	while (*nb_sb) {
-		sb_id = virtio_mem_mb_first_plugged_sb(vm, mb_id);
-		if (sb_id >= vm->nb_sb_per_mb)
+		/* Find the next candidate subblock */
+		while (sb_id >= 0 &&
+		       virtio_mem_mb_test_sb_unplugged(vm, mb_id, sb_id, 1))
+			sb_id--;
+		if (sb_id < 0)
 			break;
+		/* Try to unplug multiple subblocks at a time */
 		count = 1;
-		while (count < *nb_sb &&
-		       sb_id + count  < vm->nb_sb_per_mb &&
-		       virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id + count,
-						     1))
+		while (count < *nb_sb && sb_id > 0 &&
+		       virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id - 1, 1)) {
 			count++;
+			sb_id--;
+		}
 
 		rc = virtio_mem_mb_unplug_sb(vm, mb_id, sb_id, count);
 		if (rc)
 			return rc;
 		*nb_sb -= count;
+		sb_id--;
 	}
 
 	return 0;
@@ -1337,12 +1331,12 @@ static int virtio_mem_mb_unplug_any_sb_online(struct virtio_mem *vm,
 	 * we should sense via something like is_mem_section_removable()
 	 * first if it makes sense to go ahead any try to allocate.
 	 */
-	for (sb_id = 0; sb_id < vm->nb_sb_per_mb && *nb_sb; sb_id++) {
+	for (sb_id = vm->nb_sb_per_mb - 1; sb_id >= 0 && *nb_sb; sb_id--) {
 		/* Find the next candidate subblock */
-		while (sb_id < vm->nb_sb_per_mb &&
+		while (sb_id >= 0 &&
 		       !virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id, 1))
-			sb_id++;
-		if (sb_id >= vm->nb_sb_per_mb)
+			sb_id--;
+		if (sb_id < 0)
 			break;
 
 		start_pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
-- 
2.25.3
