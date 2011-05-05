From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 2/3] virtio_ring: check used_event offset
Date: Thu, 5 May 2011 18:08:10 +0300
Message-ID: <09cf2579f7892eed2bf63daad3ee9b79cfd67b68.1304605817.git.mst__30620.2328567908$1304608287$gmane$org@redhat.com>
References: <cover.1304605816.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1304605816.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: Krishna Kumar <krkumar2@in.ibm.com>, Carsten Otte <cotte@de.ibm.com>, lguest@lists.ozlabs.org, Shirley Ma <xma@us.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org, habanero@linux.vnet.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, steved@us.ibm.com, Christian Borntraeger <borntraeger@de.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Nothing's wrong with vring_size as is, but it's nice
to check that the new field in the avail ring
won't overlow into the used ring.

Reported-by: Tom Lendacky <tahm@linux.vnet.ibm.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_ring.h |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 2a3b0ea..089cbf2 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -119,7 +119,13 @@ static inline void vring_init(struct vring *vr, unsigned int num, void *p,
 
 static inline unsigned vring_size(unsigned int num, unsigned long align)
 {
-	return ((sizeof(struct vring_desc) * num + sizeof(__u16) * (2 + num)
+#ifdef __KERNEL__
+	/* Older versions did not have used_event field at the end of the
+	 * avail ring. Used ring offset must be compatible with such devices. */
+	size_t s = sizeof(struct vring_desc) * num + sizeof(__u16) * (2 + num);
+	BUG_ON(ALIGN(s, align) != ALIGN(s + sizeof(__u16), align));
+#endif
+	return ((sizeof(struct vring_desc) * num + sizeof(__u16) * (3 + num)
 		 + align - 1) & ~(align - 1))
 		+ sizeof(__u16) * 3 + sizeof(struct vring_used_elem) * num;
 }
-- 
1.7.5.53.gc233e
