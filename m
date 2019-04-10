From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 3/3] virtio-gpu api: VIRTIO_GPU_F_RESSOURCE_V2
Date: Wed, 10 Apr 2019 13:42:27 +0200
Message-ID: <20190410114227.25846-4-kraxel__2093.51205719344$1554896591$gmane$org@redhat.com>
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

Add new command VIRTIO_GPU_CMD_RESOURCE_CREATE_V2 to create resources.
It adds (a) support planar resources and (b) returns stride and size of
the resource planes.  The later will be needed in case we support
mapping host resources into the guest some day.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/uapi/linux/virtio_gpu.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
index 732bb16a39f8..00010315e500 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -58,6 +58,11 @@
  */
 #define VIRTIO_GPU_F_MEMORY              2
 
+/*
+ * VIRTIO_GPU_CMD_RESOURCE_CREATE_V2 command
+ */
+#define VIRTIO_GPU_F_RESSOURCE_V2        3
+
 enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_UNDEFINED = 0,
 
@@ -76,6 +81,7 @@ enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_CMD_MEMORY_CREATE,
 	VIRTIO_GPU_CMD_MEMORY_UNREF,
 	VIRTIO_GPU_CMD_RESOURCE_ATTACH_MEMORY,
+	VIRTIO_GPU_CMD_RESOURCE_CREATE_V2,
 
 	/* 3d commands */
 	VIRTIO_GPU_CMD_CTX_CREATE = 0x0200,
@@ -97,6 +103,7 @@ enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_RESP_OK_CAPSET_INFO,
 	VIRTIO_GPU_RESP_OK_CAPSET,
 	VIRTIO_GPU_RESP_OK_EDID,
+	VIRTIO_GPU_RESP_OK_RESOURCE_INFO,
 
 	/* error responses */
 	VIRTIO_GPU_RESP_ERR_UNSPEC = 0x1200,
@@ -308,6 +315,30 @@ struct virtio_gpu_cmd_resource_attach_memory {
 	__le64 offset[4];
 };
 
+/* VIRTIO_GPU_CMD_RESOURCE_CREATE_V2 */
+struct virtio_gpu_cmd_resource_create_v2 {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 resource_id;
+	__le32 format;
+	__le32 width;
+	__le32 height;
+	/* 3d only */
+	__le32 target;
+	__le32 bind;
+	__le32 depth;
+	__le32 array_size;
+	__le32 last_level;
+	__le32 nr_samples;
+	__le32 flags;
+};
+
+/* VIRTIO_GPU_RESP_OK_RESOURCE_INFO */
+struct virtio_gpu_resp_resource_info {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 stride[4];
+	__le32 size[4];
+};
+
 #define VIRTIO_GPU_CAPSET_VIRGL 1
 #define VIRTIO_GPU_CAPSET_VIRGL2 2
 
-- 
2.18.1
