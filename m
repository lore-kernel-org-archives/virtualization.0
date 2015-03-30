From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4/6] virtio_mmio: support non-legacy balloon devices
Date: Mon, 30 Mar 2015 19:37:23 +0200
Message-ID: <1427737006-23191-5-git-send-email-mst@redhat.com>
References: <1427737006-23191-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1427737006-23191-1-git-send-email-mst@redhat.com>
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
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

virtio_device_is_legacy_only is always false now,
drop the test from virtio mmio.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_mmio.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 6010d7e..7a5e60d 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -581,14 +581,6 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 	}
 	vm_dev->vdev.id.vendor = readl(vm_dev->base + VIRTIO_MMIO_VENDOR_ID);
 
-	/* Reject legacy-only IDs for version 2 devices */
-	if (vm_dev->version == 2 &&
-			virtio_device_is_legacy_only(vm_dev->vdev.id)) {
-		dev_err(&pdev->dev, "Version 2 not supported for devices %u!\n",
-				vm_dev->vdev.id.device);
-		return -ENODEV;
-	}
-
 	if (vm_dev->version == 1)
 		writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
 
-- 
MST
