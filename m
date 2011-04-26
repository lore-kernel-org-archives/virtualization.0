From: Liu Yuan <namei.unix@gmail.com>
Subject: [PATCH] virtio, ring: Use ALIGN macros in virtio_ring.h
Date: Tue, 26 Apr 2011 12:11:10 +0800
Message-ID: <1303791070-15196-1-git-send-email-namei.unix__16884.4270673164$1303791144$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Liu Yuan <tailai.ly@taobao.com>


Signed-off-by: Liu Yuan <tailai.ly@taobao.com>
---
 include/linux/virtio_ring.h |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index e4d144b..6299050 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -99,15 +99,13 @@ static inline void vring_init(struct vring *vr, unsigned int num, void *p,
 	vr->num = num;
 	vr->desc = p;
 	vr->avail = p + num*sizeof(struct vring_desc);
-	vr->used = (void *)(((unsigned long)&vr->avail->ring[num] + align-1)
-			    & ~(align - 1));
+	vr->used = (void *)PTR_ALIGN(&vr->avail->ring[num], align);
 }
 
 static inline unsigned vring_size(unsigned int num, unsigned long align)
 {
-	return ((sizeof(struct vring_desc) * num + sizeof(__u16) * (2 + num)
-		 + align - 1) & ~(align - 1))
-		+ sizeof(__u16) * 2 + sizeof(struct vring_used_elem) * num;
+	return ((sizeof(struct vring_desc) * num + ALIGN(sizeof(__u16) * (2 + num), align))
+		+ sizeof(__u16) * 2 + sizeof(struct vring_used_elem) * num);
 }
 
 #ifdef __KERNEL__
-- 
1.7.1
