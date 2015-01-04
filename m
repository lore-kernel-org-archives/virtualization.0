From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio: make del_vqs idempotent
Date: Sun, 4 Jan 2015 17:25:18 +0200
Message-ID: <1420385102-6637-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Sasha Levin <sasha.levin@oracle.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Our code calls del_vqs multiple times, assuming
it's idempotent.

commit 3ec7a77bb3089bb01032fdbd958eb5c29da58b49
    virtio_pci: free up vq->priv
broke this assumption, by adding kfree there,
so multiple calls cause double free.

Fix it up.

Fixes: 3ec7a77bb3089bb01032fdbd958eb5c29da58b49
Reported-by: Sasha Levin <sasha.levin@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 08d0b04..557cbcb 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -282,6 +282,7 @@ void vp_del_vqs(struct virtio_device *vdev)
 
 	vp_free_vectors(vdev);
 	kfree(vp_dev->vqs);
+	vp_dev->vqs = NULL;
 }
 
 static int vp_try_to_find_vqs(struct virtio_device *vdev, unsigned nvqs,
-- 
MST
