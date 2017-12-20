From: weiping zhang <zwp10758@gmail.com>
Subject: [PATCH v4 2/4] virtio_pci: don't kfree device on register failure
Date: Wed, 20 Dec 2017 12:26:43 +0800
Message-ID: <dbd2c99ac7063a7905205c845c89b561537e1581.1513700444.git.zhangweiping@didichuxing.com>
References: <cover.1513700444.git.zhangweiping@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1513700444.git.zhangweiping@didichuxing.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: cohuck@redhat.com, mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

As mentioned at drivers/base/core.c:
/*
 * NOTE: _Never_ directly free @dev after calling this function, even
 * if it returned an error! Always use put_device() to give up the
 * reference initialized in this function instead.
 */
so we don't free vp_dev until vp_dev->vdev.dev.release be called.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 drivers/virtio/virtio_pci_common.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 1c4797e..48d4d1c 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -513,7 +513,7 @@ static void virtio_pci_release_dev(struct device *_d)
 static int virtio_pci_probe(struct pci_dev *pci_dev,
 			    const struct pci_device_id *id)
 {
-	struct virtio_pci_device *vp_dev;
+	struct virtio_pci_device *vp_dev, *reg_dev = NULL;
 	int rc;
 
 	/* allocate our structure and fill it out */
@@ -551,6 +551,7 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
 	pci_set_master(pci_dev);
 
 	rc = register_virtio_device(&vp_dev->vdev);
+	reg_dev = vp_dev;
 	if (rc)
 		goto err_register;
 
@@ -564,7 +565,10 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
 err_probe:
 	pci_disable_device(pci_dev);
 err_enable_device:
-	kfree(vp_dev);
+	if (reg_dev)
+		put_device(&vp_dev->vdev.dev);
+	else
+		kfree(vp_dev);
 	return rc;
 }
 
-- 
2.9.4
