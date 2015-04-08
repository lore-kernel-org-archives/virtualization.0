From: Alexander Duyck <alexander.h.duyck@redhat.com>
Subject: [PATCH] virtio_ring: Update weak barriers to use dma_wmb/rmb
Date: Tue, 07 Apr 2015 17:47:42 -0700
Message-ID: <20150408004742.2112.25484.stgit__21722.0559985892$1428454188$gmane$org@ahduyck-vm-fedora22>
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
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

This change makes it so that instead of using smp_wmb/rmb which varies
depending on the kernel configuration we can can use dma_wmb/rmb which for
most architectures should be equal to or slightly more strict than
smp_wmb/rmb.

The advantage to this is that these barriers are available to uniprocessor
builds as well so the performance should improve under such a
configuration.

Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>
---
 include/linux/virtio_ring.h |   23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 67e06fe18c03..8e50888a6d59 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -21,19 +21,20 @@
  * actually quite cheap.
  */
 
-#ifdef CONFIG_SMP
 static inline void virtio_mb(bool weak_barriers)
 {
+#ifdef CONFIG_SMP
 	if (weak_barriers)
 		smp_mb();
 	else
+#endif
 		mb();
 }
 
 static inline void virtio_rmb(bool weak_barriers)
 {
 	if (weak_barriers)
-		smp_rmb();
+		dma_rmb();
 	else
 		rmb();
 }
@@ -41,26 +42,10 @@ static inline void virtio_rmb(bool weak_barriers)
 static inline void virtio_wmb(bool weak_barriers)
 {
 	if (weak_barriers)
-		smp_wmb();
+		dma_wmb();
 	else
 		wmb();
 }
-#else
-static inline void virtio_mb(bool weak_barriers)
-{
-	mb();
-}
-
-static inline void virtio_rmb(bool weak_barriers)
-{
-	rmb();
-}
-
-static inline void virtio_wmb(bool weak_barriers)
-{
-	wmb();
-}
-#endif
 
 struct virtio_device;
 struct virtqueue;
