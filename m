From: Yuan Liu <liuy139@gmail.com>
Subject: [PATCH] virtio_mmio: Set dev.release() to avoid warning
Date: Wed, 23 Nov 2016 16:31:00 -0800
Message-ID: <1479947460-9379-1-git-send-email-liuy139@gmail.com>
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
To: mst@redhat.com, jasowang@redhat.com
Cc: Yuan Liu <liuyuan@google.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Yuan Liu <liuyuan@google.com>

Fix a warning thrown from virtio_mmio_remove():
Device 'virtio0' does not have a release() function

The fix is according to virtio_pci_probe() of
drivers/virtio/virtio_pci_common.c

Signed-off-by: Yuan Liu <liuyuan@google.com>
---
 drivers/virtio/virtio_mmio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 48bfea9..d47a2fc 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -489,6 +489,7 @@ static const struct virtio_config_ops virtio_mmio_config_ops = {
 };
 
 
+static void virtio_mmio_release_dev_empty(struct device *_d) {}
 
 /* Platform device */
 
@@ -511,6 +512,7 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 		return  -ENOMEM;
 
 	vm_dev->vdev.dev.parent = &pdev->dev;
+	vm_dev->vdev.dev.release = virtio_mmio_release_dev_empty;
 	vm_dev->vdev.config = &virtio_mmio_config_ops;
 	vm_dev->pdev = pdev;
 	INIT_LIST_HEAD(&vm_dev->virtqueues);
-- 
2.8.0.rc3.226.g39d4020
