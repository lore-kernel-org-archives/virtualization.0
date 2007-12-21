From: Dor Laor <dor.laor@gmail.com>
Subject: [kvm-devel] [Virtio-for-kvm] [PATCH 9/13] [Mostly resend] virtio
 additions
Date: Fri, 21 Dec 2007 17:25:40 +0200
Message-ID: <476BDAF4.2010304__912.575683514838$1198250896$gmane$org@qumranet.com>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
To: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rus>
List-Id: virtualization@lists.linuxfoundation.org

 From e761e0d22af833c9d0d48f191f38fc25f6a5f753 Mon Sep 17 00:00:00 2001
From: Anthony Liguori <aliguori@us.ibm.com>
Date: Fri, 21 Dec 2007 02:17:47 +0200
Subject: [PATCH] Fix vring_init/vring_size to take unsigned long

Using unsigned int resulted in silent truncation of the upper 32-bit on 
x86_64
resulting in an OOPS since the ring was being initialized wrong.

Please reconsider my previous patch to just use PAGE_ALIGN().  Open 
coding this
sort of stuff, no matter how simple it seems, is just asking for this 
sort of
trouble.

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>
---
 include/linux/virtio_ring.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 1a4ed49..5de09f9 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -89,7 +89,7 @@ struct vring {
  * };
  */
 static inline void vring_init(struct vring *vr, unsigned int num, void *p,
-                  unsigned int pagesize)
+                  unsigned long pagesize)
 {
     vr->num = num;
     vr->desc = p;
@@ -98,7 +98,7 @@ static inline void vring_init(struct vring *vr, 
unsigned int num, void *p,
                 & ~(pagesize - 1));
 }
 
-static inline unsigned vring_size(unsigned int num, unsigned int pagesize)
+static inline unsigned vring_size(unsigned int num, unsigned long pagesize)
 {
     return ((sizeof(struct vring_desc) * num + sizeof(__u16) * (2 + num)
          + pagesize - 1) & ~(pagesize - 1))
-- 
1.5.3.3
