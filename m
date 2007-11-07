From: Anthony Liguori <aliguori@us.ibm.com>
Subject: [PATCH][VIRTIO] Fix vring_init() ring computations
Date: Tue,  6 Nov 2007 20:52:29 -0600
Message-ID: <11944039492411-git-send-email-aliguori@us.ibm.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756851AbXKGCwd@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rusycorp.com.au>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

This patch fixes a typo in vring_init().  This happens to work today in lguest
because the sizeof(struct vring_desc) is 16 and struct vring contains 3
pointers and an unsigned int so on 32-bit
sizeof(struct vring_desc) == sizeof(struct vring).  However, this is no longer
true on 64-bit where the bug is exposed.

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index ac69e7b..5b88d21 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -92,8 +92,8 @@ static inline void vring_init(struct vring *vr, unsigned int num, void *p)
 {
 	vr->num = num;
 	vr->desc = p;
-	vr->avail = p + num*sizeof(struct vring);
-	vr->used = p + (num+1)*(sizeof(struct vring) + sizeof(__u16));
+	vr->avail = p + num*sizeof(struct vring_desc);
+	vr->used = p + (num+1)*(sizeof(struct vring_desc) + sizeof(__u16));
 }
 
 static inline unsigned vring_size(unsigned int num)
