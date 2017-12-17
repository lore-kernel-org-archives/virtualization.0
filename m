From: weiping zhang <zwp10758@gmail.com>
Subject: [PATCH v3 2/5] virtio_pci: don't kfree device on register failure
Date: Sun, 17 Dec 2017 21:46:16 +0800
Message-ID: <9308e1baef36c5f8c217aef0f074980984f7f913.1513517240.git.zhangweiping@didichuxing.com>
References: <cover.1513517240.git.zhangweiping@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1513517240.git.zhangweiping@didichuxing.com>
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
 drivers/virtio/virtio_pci_common.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 1c4797e..21a2ce0 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -564,7 +564,10 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
 err_probe:
 	pci_disable_device(pci_dev);
 err_enable_device:
-	kfree(vp_dev);
+	if (VIRTIO_CONFIG_S_ACKNOWLEDGE & virtio_get_status(&vp_dev->vdev))
+		put_device(&vp_dev->vdev.dev);
+	else
+		kfree(vp_dev);
 	return rc;
 }
 
-- 
2.9.4
