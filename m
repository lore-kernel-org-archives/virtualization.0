From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio_pci: fix use after free on release
Date: Thu, 14 Jan 2016 16:04:11 +0200
Message-ID: <1452780236-27981-1-git-send-email-mst__9035.31245789981$1452780276$gmane$org@redhat.com>
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
Cc: Sasha Levin <sasha.levin@oracle.com>, Jerome Marchand <jmarchan@redhat.com>, stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

KASan detected a use-after-free error in virtio-pci remove code. In
virtio_pci_remove(), vp_dev is still used after being freed in
unregister_virtio_device() (in virtio_pci_release_dev() more
precisely).

To fix, keep a reference until cleanup is done.

Fixes: 63bd62a08ca4 ("virtio_pci: defer kfree until release callback")
Reported-by: Jerome Marchand <jmarchan@redhat.com>
Cc: stable@vger.kernel.org
Cc: Sasha Levin <sasha.levin@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 36205c2..f6bed86 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -545,6 +545,7 @@ err_enable_device:
 static void virtio_pci_remove(struct pci_dev *pci_dev)
 {
 	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
+	struct device *dev = get_device(&vp_dev->vdev.dev);
 
 	unregister_virtio_device(&vp_dev->vdev);
 
@@ -554,6 +555,7 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
 		virtio_pci_modern_remove(vp_dev);
 
 	pci_disable_device(pci_dev);
+	put_device(dev);
 }
 
 static struct pci_driver virtio_pci_driver = {
-- 
MST
