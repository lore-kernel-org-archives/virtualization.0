From: Sasha Levin <sasha.levin@oracle.com>
Subject: [PATCH 2/2] virtio: don't free memory until the underlying struct
	device has been released
Date: Fri,  2 Jan 2015 14:47:40 -0500
Message-ID: <1420228060-18721-2-git-send-email-sasha.levin@oracle.com>
References: <1420228060-18721-1-git-send-email-sasha.levin@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1420228060-18721-1-git-send-email-sasha.levin@oracle.com>
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

When releasing a virtio device, We can't free a struct virtio_device until the
underlying struct device has been released, which might not happen immediately
on device_unregister() even if that was the device's last reference.

Instead, free the memory only once we know the device is gone in the release
callback.

Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
---
 drivers/virtio/virtio_pci_common.c |    9 ++++-----
 drivers/virtio/virtio_pci_legacy.c |    1 -
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 59d3685..caa483d 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -423,11 +423,10 @@ int vp_set_vq_affinity(struct virtqueue *vq, int cpu)
 
 void virtio_pci_release_dev(struct device *_d)
 {
-	/*
-	 * No need for a release method as we allocate/free
-	 * all devices together with the pci devices.
-	 * Provide an empty one to avoid getting a warning from core.
-	 */
+	struct virtio_device *vdev = dev_to_virtio(_d);
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+
+	kfree(vp_dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 913ca23..15e6e6d 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -301,5 +301,4 @@ void virtio_pci_legacy_remove(struct pci_dev *pci_dev)
 	pci_iounmap(pci_dev, vp_dev->ioaddr);
 	pci_release_regions(pci_dev);
 	pci_disable_device(pci_dev);
-	kfree(vp_dev);
 }
-- 
1.7.10.4
