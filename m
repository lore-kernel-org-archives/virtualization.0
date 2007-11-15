From: Anthony Liguori <aliguori@us.ibm.com>
Subject: [PATCH] Fix vring_init/vring_size to take unsigned long
Date: Thu, 15 Nov 2007 14:59:28 -0600
Message-ID: <11951603682689-git-send-email-aliguori@us.ibm.com>
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
To: Rusty Russell <rusty@rustcorp.com.au>Rusty Russell <rusty@rustcorp.com.au>
Cc: Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Using unsigned int resulted in silent truncation of the upper 32-bit on x86_64
resulting in an OOPS since the ring was being initialized wrong.

Please reconsider my previous patch to just use PAGE_ALIGN().  Open coding this
sort of stuff, no matter how simple it seems, is just asking for this sort of
trouble.

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 1a4ed49..5de09f9 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -89,7 +89,7 @@ struct vring {
  * };
  */
 static inline void vring_init(struct vring *vr, unsigned int num, void *p,
-			      unsigned int pagesize)
+			      unsigned long pagesize)
 {
 	vr->num = num;
 	vr->desc = p;
@@ -98,7 +98,7 @@ static inline void vring_init(struct vring *vr, unsigned int num, void *p,
 			    & ~(pagesize - 1));
 }
 
-static inline unsigned vring_size(unsigned int num, unsigned int pagesize)
+static inline unsigned vring_size(unsigned int num, unsigned long pagesize)
 {
 	return ((sizeof(struct vring_desc) * num + sizeof(__u16) * (2 + num)
 		 + pagesize - 1) & ~(pagesize - 1))
