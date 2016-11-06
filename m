From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/7] virtio_pci: remove the call to vp_free_vectors in
	vp_request_msix_vectors
Date: Sun,  6 Nov 2016 15:09:38 -0800
Message-ID: <1478473783-12589-3-git-send-email-hch@lst.de>
References: <1478473783-12589-1-git-send-email-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1478473783-12589-1-git-send-email-hch@lst.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

vp_request_msix_vectors is only called by vp_try_to_find_vqs, which already
calls vp_free_vectors through vp_del_vqs in the failure case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/virtio/virtio_pci_common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index f5e2751..93700c5 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -197,7 +197,6 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 	}
 	return 0;
 error:
-	vp_free_vectors(vdev);
 	return err;
 }
 
-- 
2.1.4
