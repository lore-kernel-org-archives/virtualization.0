From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 29/34] Revert "virtio_ring: Update weak barriers to use
	dma_wmb/rmb"
Date: Wed, 30 Dec 2015 15:26:18 +0200
Message-ID: <1451473761-30019-30-git-send-email-mst__40114.419317297$1451482184$gmane$org@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1451473761-30019-1-git-send-email-mst@redhat.com>
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
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, Alexander Duyck <alexander.duyck@gmail.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This reverts commit 9e1a27ea42691429e31f158cce6fc61bc79bb2e9.

While that commit optimizes !CONFIG_SMP, it mixes
up DMA and SMP concepts, making the code hard
to figure out.

A better way to optimize this is with the new __smp_XXX
barriers.

As a first step, go back to full rmb/wmb barriers
for !SMP.
We switch to __smp_XXX barriers in the next patch.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_ring.h | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 8e50888..67e06fe 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -21,20 +21,19 @@
  * actually quite cheap.
  */
 
+#ifdef CONFIG_SMP
 static inline void virtio_mb(bool weak_barriers)
 {
-#ifdef CONFIG_SMP
 	if (weak_barriers)
 		smp_mb();
 	else
-#endif
 		mb();
 }
 
 static inline void virtio_rmb(bool weak_barriers)
 {
 	if (weak_barriers)
-		dma_rmb();
+		smp_rmb();
 	else
 		rmb();
 }
@@ -42,10 +41,26 @@ static inline void virtio_rmb(bool weak_barriers)
 static inline void virtio_wmb(bool weak_barriers)
 {
 	if (weak_barriers)
-		dma_wmb();
+		smp_wmb();
 	else
 		wmb();
 }
+#else
+static inline void virtio_mb(bool weak_barriers)
+{
+	mb();
+}
+
+static inline void virtio_rmb(bool weak_barriers)
+{
+	rmb();
+}
+
+static inline void virtio_wmb(bool weak_barriers)
+{
+	wmb();
+}
+#endif
 
 struct virtio_device;
 struct virtqueue;
-- 
MST
