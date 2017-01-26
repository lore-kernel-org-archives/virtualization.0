From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] virtio_pci: Use kcalloc() in vp_request_msix_vectors()
Date: Thu, 26 Jan 2017 22:46:00 +0100
Message-ID: <57a18132-3b9d-0e5b-5372-efe525f83100__46899.70321856$1485467845$gmane$org@users.sourceforge.net>
References: <61829748-a13d-42e4-8f6c-103ee5ca2c88@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <61829748-a13d-42e4-8f6c-103ee5ca2c88@users.sourceforge.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 26 Jan 2017 22:10:18 +0100

A multiplication for the size determination of a memory allocation
indicated that an array data structure should be processed.
Thus reuse the corresponding function "kcalloc".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/virtio/virtio_pci_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 186cbab327b8..559a2b706093 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -117,7 +117,7 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 	if (!vp_dev->msix_names)
 		goto error;
 	vp_dev->msix_affinity_masks
-		= kzalloc(nvectors * sizeof *vp_dev->msix_affinity_masks,
+		= kcalloc(nvectors, sizeof(*vp_dev->msix_affinity_masks),
 			  GFP_KERNEL);
 	if (!vp_dev->msix_affinity_masks)
 		goto error;
-- 
2.11.0
