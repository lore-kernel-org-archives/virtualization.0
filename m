From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/3] virtio-gpu api: VIRTIO_GPU_F_MEMORY
Date: Wed, 10 Apr 2019 13:42:26 +0200
Message-ID: <20190410114227.25846-3-kraxel__11274.9062058114$1554896602$gmane$org@redhat.com>
References: <20190410114227.25846-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190410114227.25846-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org, virtio@lists.oasis-open.org
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, Gurchetan Singh <gurchetansingh@chromium.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, David Airlie <airlied@redhat.com>, "open list:VIRTIO CORE,
	NET AND BLOCK DRIVERS" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Introduce the concept of memory regions to virtio-gpu.  Initially only
memory regions composed of guest pages are supported (pretty much like
current backing storage for resources).  I expect support for other
memory types will be added later on.

VIRTIO_GPU_CMD_MEMORY_CREATE:
    creates a new memory region.

VIRTIO_GPU_CMD_MEMORY_UNREF:
    destroys a memory region.

VIRTIO_GPU_CMD_RESOURCE_ATTACH_MEMORY:
    Use memory region as backing storage for the given resource.
    The existing VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING command
    can be used to detach.

Motivation: This separates storage management from resource management.
It allows memory pooling (vulkan support will most likely need this).
It makes things a bit more flexible in general, for example we can
represent gem objects as memory regions even if we don't know the format
yet (happens on dma-buf import for example).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/uapi/linux/virtio_gpu.h | 38 +++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
index 0c85914d9369..732bb16a39f8 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -51,6 +51,13 @@
  */
 #define VIRTIO_GPU_F_EDID                1
 
+/*
+ * VIRTIO_GPU_CMD_MEMORY_CREATE
+ * VIRTIO_GPU_CMD_MEMORY_UNREF
+ * VIRTIO_GPU_CMD_RESOURCE_ATTACH_MEMORY
+ */
+#define VIRTIO_GPU_F_MEMORY              2
+
 enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_UNDEFINED = 0,
 
@@ -66,6 +73,9 @@ enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_CMD_GET_CAPSET_INFO,
 	VIRTIO_GPU_CMD_GET_CAPSET,
 	VIRTIO_GPU_CMD_GET_EDID,
+	VIRTIO_GPU_CMD_MEMORY_CREATE,
+	VIRTIO_GPU_CMD_MEMORY_UNREF,
+	VIRTIO_GPU_CMD_RESOURCE_ATTACH_MEMORY,
 
 	/* 3d commands */
 	VIRTIO_GPU_CMD_CTX_CREATE = 0x0200,
@@ -95,6 +105,7 @@ enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID,
 	VIRTIO_GPU_RESP_ERR_INVALID_CONTEXT_ID,
 	VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER,
+	VIRTIO_GPU_RESP_ERR_INVALID_MEMORY_ID,
 };
 
 #define VIRTIO_GPU_FLAG_FENCE (1 << 0)
@@ -187,6 +198,7 @@ struct virtio_gpu_resource_attach_backing {
 	struct virtio_gpu_ctrl_hdr hdr;
 	__le32 resource_id;
 	__le32 nr_entries;
+	/* struct virtio_gpu_mem_entry entries follow here */
 };
 
 /* VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING */
@@ -270,6 +282,32 @@ struct virtio_gpu_cmd_submit {
 	__le32 padding;
 };
 
+/* VIRTIO_GPU_CMD_MEMORY_CREATE */
+struct virtio_gpu_cmd_memory_create {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le64 size;
+	__le32 memory_id;
+	__le32 nr_entries;
+	__le32 flags;
+	__le32 padding;
+	/* struct virtio_gpu_mem_entry entries follow here */
+};
+
+/* VIRTIO_GPU_CMD_MEMORY_UNREF */
+struct virtio_gpu_cmd_memory_unref {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 memory_id;
+	__le32 padding;
+};
+
+/* VIRTIO_GPU_CMD_RESOURCE_ATTACH_MEMORY */
+struct virtio_gpu_cmd_resource_attach_memory {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 resource_id;
+	__le32 memory_id;
+	__le64 offset[4];
+};
+
 #define VIRTIO_GPU_CAPSET_VIRGL 1
 #define VIRTIO_GPU_CAPSET_VIRGL2 2
 
-- 
2.18.1
