From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 1/2] virtio: add modern config accessors
Date: Mon, 2 Mar 2015 12:40:25 +0100
Message-ID: <1425296404-12903-1-git-send-email-mst@redhat.com>
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
To: qemu-devel@nongnu.org
Cc: Anthony Liguori <aliguori@amazon.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

virtio 1.0 defines config space as LE,
as opposed to pre-1.0 which was native endian.

Add API for transports to execute word/dword accesses in
little endian format - will be useful for mmio
and pci (byte access is also wrapped, for completeness).

For simplicity, we still keep config in host native
endian format, byteswap to LE on guest access.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio.h |  6 +++
 hw/virtio/virtio.c         | 93 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index df09993..7a6a9d1 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -227,6 +227,12 @@ uint32_t virtio_config_readl(VirtIODevice *vdev, uint32_t addr);
 void virtio_config_writeb(VirtIODevice *vdev, uint32_t addr, uint32_t data);
 void virtio_config_writew(VirtIODevice *vdev, uint32_t addr, uint32_t data);
 void virtio_config_writel(VirtIODevice *vdev, uint32_t addr, uint32_t data);
+uint32_t virtio_config_modern_readb(VirtIODevice *vdev, uint32_t addr);
+uint32_t virtio_config_modern_readw(VirtIODevice *vdev, uint32_t addr);
+uint32_t virtio_config_modern_readl(VirtIODevice *vdev, uint32_t addr);
+void virtio_config_modern_writeb(VirtIODevice *vdev, uint32_t addr, uint32_t data);
+void virtio_config_modern_writew(VirtIODevice *vdev, uint32_t addr, uint32_t data);
+void virtio_config_modern_writel(VirtIODevice *vdev, uint32_t addr, uint32_t data);
 void virtio_queue_set_addr(VirtIODevice *vdev, int n, hwaddr addr);
 hwaddr virtio_queue_get_addr(VirtIODevice *vdev, int n);
 void virtio_queue_set_num(VirtIODevice *vdev, int n, int num);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 75abc1f..b098f44 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -729,6 +729,99 @@ void virtio_config_writel(VirtIODevice *vdev, uint32_t addr, uint32_t data)
     }
 }
 
+uint32_t virtio_config_modern_readb(VirtIODevice *vdev, uint32_t addr)
+{
+    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    uint8_t val;
+
+    if (addr + sizeof(val) > vdev->config_len) {
+        return (uint32_t)-1;
+    }
+
+    k->get_config(vdev, vdev->config);
+
+    val = ldub_p(vdev->config + addr);
+    return val;
+}
+
+uint32_t virtio_config_modern_readw(VirtIODevice *vdev, uint32_t addr)
+{
+    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    uint16_t val;
+
+    if (addr + sizeof(val) > vdev->config_len) {
+        return (uint32_t)-1;
+    }
+
+    k->get_config(vdev, vdev->config);
+
+    val = lduw_le_p(vdev->config + addr);
+    return val;
+}
+
+uint32_t virtio_config_modern_readl(VirtIODevice *vdev, uint32_t addr)
+{
+    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    uint32_t val;
+
+    if (addr + sizeof(val) > vdev->config_len) {
+        return (uint32_t)-1;
+    }
+
+    k->get_config(vdev, vdev->config);
+
+    val = ldl_le_p(vdev->config + addr);
+    return val;
+}
+
+void virtio_config_modern_writeb(VirtIODevice *vdev, uint32_t addr, uint32_t data)
+{
+    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    uint8_t val = data;
+
+    if (addr + sizeof(val) > vdev->config_len) {
+        return;
+    }
+
+    stb_p(vdev->config + addr, val);
+
+    if (k->set_config) {
+        k->set_config(vdev, vdev->config);
+    }
+}
+
+void virtio_config_modern_writew(VirtIODevice *vdev, uint32_t addr, uint32_t data)
+{
+    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    uint16_t val = data;
+
+    if (addr + sizeof(val) > vdev->config_len) {
+        return;
+    }
+
+    stw_le_p(vdev->config + addr, val);
+
+    if (k->set_config) {
+        k->set_config(vdev, vdev->config);
+    }
+}
+
+void virtio_config_modern_writel(VirtIODevice *vdev, uint32_t addr, uint32_t data)
+{
+    VirtioDeviceClass *k = VIRTIO_DEVICE_GET_CLASS(vdev);
+    uint32_t val = data;
+
+    if (addr + sizeof(val) > vdev->config_len) {
+        return;
+    }
+
+    stl_le_p(vdev->config + addr, val);
+
+    if (k->set_config) {
+        k->set_config(vdev, vdev->config);
+    }
+}
+
 void virtio_queue_set_addr(VirtIODevice *vdev, int n, hwaddr addr)
 {
     vdev->vq[n].vring.desc = addr;
-- 
MST
