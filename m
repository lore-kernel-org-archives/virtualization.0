From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v7 9/9] vring: Use the DMA API on Xen
Date: Tue,  2 Feb 2016 21:46:40 -0800
Message-ID: <a5b072806984a0fceb4f4d33cbeb1cea7d881e8b.1454477782.git.luto__49099.8815549121$1454478514$gmane$org@kernel.org>
References: <cover.1454477782.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1454477782.git.luto@kernel.org>
In-Reply-To: <cover.1454477782.git.luto@kernel.org>
References: <cover.1454477782.git.luto@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Christian Borntraeger <borntraeger@de.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Andy Lutomirski <luto@kernel.org>, xen-devel@lists.xenproject.org, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/virtio/virtio_ring.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index e46d08107a50..5c802d47892c 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -25,6 +25,7 @@
 #include <linux/hrtimer.h>
 #include <linux/kmemleak.h>
 #include <linux/dma-mapping.h>
+#include <xen/xen.h>
 
 #ifdef DEBUG
 /* For development, we want to crash whenever the ring is screwed. */
@@ -136,6 +137,17 @@ struct vring_virtqueue {
 
 static bool vring_use_dma_api(struct virtio_device *vdev)
 {
+	/*
+	 * In theory, it's possible to have a buggy QEMU-supposed
+	 * emulated Q35 IOMMU and Xen enabled at the same time.  On
+	 * such a configuration, virtio has never worked and will
+	 * not work without an even larger kludge.  Instead, enable
+	 * the DMA API if we're a Xen guest, which at least allows
+	 * all of the sensible Xen configurations to work correctly.
+	 */
+	if (xen_domain())
+		return true;
+
 	return false;
 }
 
-- 
2.5.0
