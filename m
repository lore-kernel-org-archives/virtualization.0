From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 1/2] virtio-gpu/2d: add hardware spec include file
Date: Thu, 11 Sep 2014 17:09:32 +0200
Message-ID: <1410448173-12960-2-git-send-email-kraxel@redhat.com>
References: <1410448173-12960-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1410448173-12960-1-git-send-email-kraxel@redhat.com>
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
Cc: Dave Airlie <airlied@redhat.com>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
List-Id: virtualization@lists.linuxfoundation.org

This patch adds the header file with structs and defines for
the virtio based gpu device.  Covers 2d operations only.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/hw/virtio/virtgpu_hw.h | 158 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100644 include/hw/virtio/virtgpu_hw.h

diff --git a/include/hw/virtio/virtgpu_hw.h b/include/hw/virtio/virtgpu_hw.h
new file mode 100644
index 0000000..461f452
--- /dev/null
+++ b/include/hw/virtio/virtgpu_hw.h
@@ -0,0 +1,158 @@
+#ifndef VIRTGPU_HW_H
+#define VIRTGPU_HW_H
+
+enum virtgpu_ctrl_type {
+        VIRTGPU_UNDEFINED = 0,
+
+        /* 2d commands */
+        VIRTGPU_CMD_GET_DISPLAY_INFO = 0x0100,
+        VIRTGPU_CMD_RESOURCE_CREATE_2D,
+        VIRTGPU_CMD_RESOURCE_UNREF,
+        VIRTGPU_CMD_SET_SCANOUT,
+        VIRTGPU_CMD_RESOURCE_FLUSH,
+        VIRTGPU_CMD_TRANSFER_TO_HOST_2D,
+        VIRTGPU_CMD_RESOURCE_ATTACH_BACKING,
+        VIRTGPU_CMD_RESOURCE_INVAL_BACKING,
+
+        /* cursor commands */
+        VIRTGPU_CMD_UPDATE_CURSOR = 0x0300,
+        VIRTGPU_CMD_MOVE_CURSOR,
+
+        /* success responses */
+        VIRTGPU_RESP_OK_NODATA = 0x1100,
+        VIRTGPU_RESP_OK_DISPLAY_INFO,
+
+        /* error responses */
+        VIRTGPU_RESP_ERR_UNSPEC = 0x1200,
+};
+
+#define VIRTGPU_FLAG_FENCE (1 << 0)
+
+struct virtgpu_ctrl_hdr {
+        uint32_t type;
+        uint32_t flags;
+        uint64_t fence_id;
+        uint32_t ctx_id;
+        uint32_t padding;
+};
+
+/* data passed in the cursor vq */
+
+struct virtgpu_cursor_pos {
+        uint32_t scanout_id;
+        uint32_t x, y;
+};
+
+/* VIRTGPU_CMD_UPDATE_CURSOR, VIRTGPU_CMD_MOVE_CURSOR */
+struct virtgpu_update_cursor {
+        struct virtgpu_ctrl_hdr hdr;
+        struct virtgpu_cursor_pos pos;  /* update & move */
+        uint32_t resource_id;           /* update only */
+        uint32_t hot_x, hot_y;          /* update only */
+};
+
+/* data passed in the control vq, 2d related */
+
+/* VIRTGPU_CMD_RESOURCE_UNREF */
+struct virtgpu_resource_unref {
+        struct virtgpu_ctrl_hdr hdr;
+        uint32_t resource_id;
+};
+
+/* VIRTGPU_CMD_RESOURCE_CREATE_2D: create a simple 2d resource with a format */
+struct virtgpu_resource_create_2d {
+        struct virtgpu_ctrl_hdr hdr;
+        uint32_t resource_id;
+        uint32_t format;
+        uint32_t width;
+        uint32_t height;
+};
+
+/* VIRTGPU_CMD_SET_SCANOUT */
+struct virtgpu_set_scanout {
+        struct virtgpu_ctrl_hdr hdr;
+        uint32_t scanout_id;
+        uint32_t resource_id;
+        uint32_t width;
+        uint32_t height;
+        uint32_t x;
+        uint32_t y;
+};
+
+/* VIRTGPU_CMD_RESOURCE_FLUSH */
+struct virtgpu_resource_flush {
+        struct virtgpu_ctrl_hdr hdr;
+        uint32_t resource_id;
+        uint32_t width;
+        uint32_t height;
+        uint32_t x;
+        uint32_t y;
+};
+
+/* VIRTGPU_CMD_TRANSFER_TO_HOST_2D: simple transfer to_host */
+struct virtgpu_transfer_to_host_2d {
+        struct virtgpu_ctrl_hdr hdr;
+        uint32_t resource_id;
+        uint32_t offset;
+        uint32_t width;
+        uint32_t height;
+        uint32_t x;
+        uint32_t y;
+};
+
+struct virtgpu_mem_entry {
+        uint64_t addr;
+        uint32_t length;
+        uint32_t pad;
+};
+
+/* VIRTGPU_CMD_RESOURCE_ATTACH_BACKING */
+struct virtgpu_resource_attach_backing {
+        struct virtgpu_ctrl_hdr hdr;
+        uint32_t resource_id;
+        uint32_t nr_entries;
+};
+
+/* VIRTGPU_CMD_RESOURCE_INVAL_BACKING */
+struct virtgpu_resource_inval_backing {
+        struct virtgpu_ctrl_hdr hdr;
+        uint32_t resource_id;
+};
+
+/* VIRTGPU_RESP_OK_DISPLAY_INFO */
+#define VIRTGPU_MAX_SCANOUTS 16
+struct virtgpu_resp_display_info {
+        struct virtgpu_ctrl_hdr hdr;
+        struct virtgpu_display_one {
+                uint32_t enabled;
+                uint32_t width;
+                uint32_t height;
+                uint32_t x;
+                uint32_t y;
+                uint32_t flags;
+        } pmodes[VIRTGPU_MAX_SCANOUTS];
+};
+
+#define VIRTGPU_EVENT_DISPLAY (1 << 0)
+
+struct virtgpu_config {
+        uint32_t events_read;
+        uint32_t events_clear;
+        uint32_t num_scanouts;
+        uint32_t reserved;
+};
+
+/* simple formats for fbcon/X use */
+enum virtgpu_formats {
+        VIRGL_FORMAT_B8G8R8A8_UNORM          = 1,
+        VIRGL_FORMAT_B8G8R8X8_UNORM          = 2,
+        VIRGL_FORMAT_A8R8G8B8_UNORM          = 3,
+        VIRGL_FORMAT_X8R8G8B8_UNORM          = 4,
+
+        VIRGL_FORMAT_B5G5R5A1_UNORM          = 5,
+        VIRGL_FORMAT_B5G6R5_UNORM            = 7,
+
+        VIRGL_FORMAT_R8_UNORM                = 64,
+};
+
+#endif
-- 
1.8.3.1
