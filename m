From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 2/2] virtio-pci: switch to modern accessors for 1.0
Date: Mon, 2 Mar 2015 12:40:28 +0100
Message-ID: <1425296404-12903-2-git-send-email-mst@redhat.com>
References: <1425296404-12903-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1425296404-12903-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: qemu-devel@nongnu.org
Cc: Anthony Liguori <aliguori@amazon.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

virtio 1.0 config space is in LE format for all
devices, use modern wrappers when accessed through
the 1.0 BAR.

Reported-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 4c9a0b8..49ea7fc 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1198,13 +1198,13 @@ static uint64_t virtio_pci_device_read(void *opaque, hwaddr addr,
 
     switch (size) {
     case 1:
-        val = virtio_config_readb(vdev, addr);
+        val = virtio_config_modern_readb(vdev, addr);
         break;
     case 2:
-        val = virtio_config_readw(vdev, addr);
+        val = virtio_config_modern_readw(vdev, addr);
         break;
     case 4:
-        val = virtio_config_readl(vdev, addr);
+        val = virtio_config_modern_readl(vdev, addr);
         break;
     }
     return val;
@@ -1216,13 +1216,13 @@ static void virtio_pci_device_write(void *opaque, hwaddr addr,
     VirtIODevice *vdev = opaque;
     switch (size) {
     case 1:
-        virtio_config_writeb(vdev, addr, val);
+        virtio_config_modern_writeb(vdev, addr, val);
         break;
     case 2:
-        virtio_config_writew(vdev, addr, val);
+        virtio_config_modern_writew(vdev, addr, val);
         break;
     case 4:
-        virtio_config_writel(vdev, addr, val);
+        virtio_config_modern_writel(vdev, addr, val);
         break;
     }
 }
-- 
MST
