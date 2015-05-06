From: Thomas Huth <thuth@redhat.com>
Subject: [PATCH] virtio: Fix typecast of pointer in vring_init()
Date: Wed,  6 May 2015 12:33:59 +0200
Message-ID: <1430908439-32646-1-git-send-email-thuth__12974.7338629842$1430924264$gmane$org@redhat.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
Cc: linux-api@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

The virtio_ring.h header is used in userspace programs (ie. QEMU),
too. Here we can not assume that sizeof(pointer) is the same as
sizeof(long), e.g. when compiling for Windows, so the typecast
in vring_init() should be done with (uintptr_t) instead of
(unsigned long). This fixes a compiler warning when compiling
QEMU with the mingw32 cross-compiler.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/uapi/linux/virtio_ring.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_ring.h b/include/uapi/linux/virtio_ring.h
index 915980a..8682551 100644
--- a/include/uapi/linux/virtio_ring.h
+++ b/include/uapi/linux/virtio_ring.h
@@ -143,7 +143,7 @@ static inline void vring_init(struct vring *vr, unsigned int num, void *p,
 	vr->num = num;
 	vr->desc = p;
 	vr->avail = p + num*sizeof(struct vring_desc);
-	vr->used = (void *)(((unsigned long)&vr->avail->ring[num] + sizeof(__virtio16)
+	vr->used = (void *)(((uintptr_t)&vr->avail->ring[num] + sizeof(__virtio16)
 		+ align-1) & ~(align - 1));
 }
 
-- 
1.8.3.1
