From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] ptr_ring: fix build
Date: Tue, 20 Mar 2018 02:41:45 +0200
Message-ID: <1521506496-455194-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Fixes after recent use of kvmalloc

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/ringtest/ptr_ring.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/virtio/ringtest/ptr_ring.c b/tools/virtio/ringtest/ptr_ring.c
index 477899c..2d566fb 100644
--- a/tools/virtio/ringtest/ptr_ring.c
+++ b/tools/virtio/ringtest/ptr_ring.c
@@ -17,6 +17,8 @@
 #define likely(x)    (__builtin_expect(!!(x), 1))
 #define ALIGN(x, a) (((x) + (a) - 1) / (a) * (a))
 #define SIZE_MAX        (~(size_t)0)
+#define KMALLOC_MAX_SIZE SIZE_MAX
+#define BUG_ON(x) assert(x)
 
 typedef pthread_spinlock_t  spinlock_t;
 
@@ -57,6 +59,9 @@ static void kfree(void *p)
 		free(p);
 }
 
+#define kvmalloc_array kmalloc_array
+#define kvfree kfree
+
 static void spin_lock_init(spinlock_t *lock)
 {
 	int r = pthread_spin_init(lock, 0);
-- 
MST
