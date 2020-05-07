From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 13/15] virtio-mem: Unplug subblocks right-to-left
Date: Thu,  7 May 2020 12:31:17 +0200
Message-ID: <20200507103119.11219-14-david@redhat.com>
References: <20200507103119.11219-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200507103119.11219-1-david@redhat.com>
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
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.linux-foundation.org
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
