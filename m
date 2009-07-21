From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 1/2] virtio: fix memory leak on device removal
Date: Tue, 21 Jul 2009 18:59:09 +0300
Message-ID: <20090721155909.GB3306__38015.7800428153$1248192319$gmane$org@redhat.com>
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

Free up msi vector tables.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 193c8f0..dab3c86 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -489,12 +489,15 @@ static void vp_del_vq(struct virtqueue *vq)
 /* the config->del_vqs() implementation */
 static void vp_del_vqs(struct virtio_device *vdev)
 {
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtqueue *vq, *n;
 
 	list_for_each_entry_safe(vq, n, &vdev->vqs, list)
 		vp_del_vq(vq);
 
 	vp_free_vectors(vdev);
+	kfree(vp_dev->msix_names);
+	kfree(vp_dev->msix_entries);
 }
 
 /* the config->find_vqs() implementation */
-- 
1.6.2.5
