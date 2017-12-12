From: weiping zhang <zhangweiping@didichuxing.com>
Subject: [PATCH v2 1/3] virtio_pci: use put_device instead of kfree
Date: Tue, 12 Dec 2017 21:24:02 +0800
Message-ID: <e397f504c0a796481d8aaf0e558cc8425286012c.1513083885.git.zhangweiping@didichuxing.com>
References: <cover.1513083885.git.zhangweiping@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1513083885.git.zhangweiping@didichuxing.com>
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
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/virtio/virtio_pci_common.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 1c4797e..91d20f7 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -551,16 +551,17 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
 	pci_set_master(pci_dev);
 
 	rc = register_virtio_device(&vp_dev->vdev);
-	if (rc)
-		goto err_register;
+	if (rc) {
+		if (vp_dev->ioaddr)
+		     virtio_pci_legacy_remove(vp_dev);
+		else
+		     virtio_pci_modern_remove(vp_dev);
+		pci_disable_device(pci_dev);
+		put_device(&vp_dev->vdev.dev);
+	}
 
-	return 0;
+	return rc;
 
-err_register:
-	if (vp_dev->ioaddr)
-	     virtio_pci_legacy_remove(vp_dev);
-	else
-	     virtio_pci_modern_remove(vp_dev);
 err_probe:
 	pci_disable_device(pci_dev);
 err_enable_device:
-- 
2.9.4
