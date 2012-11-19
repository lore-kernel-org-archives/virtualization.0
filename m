From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 432/493] virtio: remove use of __devexit
Date: Mon, 19 Nov 2012 13:26:21 -0500
Message-ID: <1353349642-3677-432-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: gregkh@linuxfoundation.org
Cc: virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Rusty Russell <rusty@rustcorp.com.au> 
Cc: "Michael S. Tsirkin" <mst@redhat.com> 
Cc: virtualization@lists.linux-foundation.org 
---
 drivers/virtio/virtio_balloon.c | 2 +-
 drivers/virtio/virtio_mmio.c    | 2 +-
 drivers/virtio/virtio_pci.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index c61cce9..ec1e690 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -493,7 +493,7 @@ static void remove_common(struct virtio_balloon *vb)
 	vb->vdev->config->del_vqs(vb->vdev);
 }
 
-static void __devexit virtballoon_remove(struct virtio_device *vdev)
+static void virtballoon_remove(struct virtio_device *vdev)
 {
 	struct virtio_balloon *vb = vdev->priv;
 
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 6e0047b..6bcafdd 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -493,7 +493,7 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 	return register_virtio_device(&vm_dev->vdev);
 }
 
-static int __devexit virtio_mmio_remove(struct platform_device *pdev)
+static int virtio_mmio_remove(struct platform_device *pdev)
 {
 	struct virtio_mmio_device *vm_dev = platform_get_drvdata(pdev);
 
diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 325e847..941028e 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -751,7 +751,7 @@ out:
 	return err;
 }
 
-static void __devexit virtio_pci_remove(struct pci_dev *pci_dev)
+static void virtio_pci_remove(struct pci_dev *pci_dev)
 {
 	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
 
-- 
1.8.0
