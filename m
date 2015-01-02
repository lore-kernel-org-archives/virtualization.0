From: Sasha Levin <sasha.levin@oracle.com>
Subject: [PATCH 1/2] virtio_pci: double free and invalid memory access of
	device vqs
Date: Fri,  2 Jan 2015 14:47:39 -0500
Message-ID: <1420228060-18721-1-git-send-email-sasha.levin@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: Sasha Levin <sasha.levin@oracle.com>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Device VQs were getting freed twice: once in every devices removal functions,
and then again in virtio_pci_legacy_remove().

Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 drivers/virtio/virtio_pci_legacy.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 6c76f0f..913ca23 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -298,7 +298,6 @@ void virtio_pci_legacy_remove(struct pci_dev *pci_dev)
 
 	unregister_virtio_device(&vp_dev->vdev);
 
-	vp_del_vqs(&vp_dev->vdev);
 	pci_iounmap(pci_dev, vp_dev->ioaddr);
 	pci_release_regions(pci_dev);
 	pci_disable_device(pci_dev);
-- 
1.7.10.4
