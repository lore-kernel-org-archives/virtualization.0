From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 2/2] virtio: fix double free_irq
Date: Tue, 21 Jul 2009 18:59:25 +0300
Message-ID: <20090721155925.GC3306__2098.73580975017$1248193512$gmane$org@redhat.com>
References: <cover.1248181714.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1248181714.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemon>
List-Id: virtualization@lists.linuxfoundation.org

Decrement used vectors counter when removing the vq so that
vp_free_vectors does not try to free the vector again.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index dab3c86..9dcc368 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -466,8 +466,10 @@ static void vp_del_vq(struct virtqueue *vq)
 
 	iowrite16(info->queue_index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
 
-	if (info->vector != VIRTIO_MSI_NO_VECTOR)
+	if (info->vector != VIRTIO_MSI_NO_VECTOR) {
 		free_irq(vp_dev->msix_entries[info->vector].vector, vq);
+		--vp_dev->msix_used_vectors;
+	}
 
 	if (vp_dev->msix_enabled) {
 		iowrite16(VIRTIO_MSI_NO_VECTOR,
-- 
1.6.2.5
