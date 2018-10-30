From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 1/2] virtio-gpu: add VIRTIO_GPU_F_EDID feature
Date: Tue, 30 Oct 2018 07:32:05 +0100
Message-ID: <20181030063206.19528-2-kraxel__30451.6715965748$1540881038$gmane$org@redhat.com>
References: <20181030063206.19528-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181030063206.19528-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtio-dev@lists.oasis-open.org, dri-devel@lists.freedesktop.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO CORE,
	NET AND BLOCK DRIVERS" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

The feature allows the guest request an EDID blob (describing monitor
capabilities) for a given scanout (aka virtual monitor connector).

It brings a new command message, which has just a scanout field (beside
the standard virtio-gpu header) and a response message which carries the
EDID data.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Dave Airlie <airlied@redhat.com>
---
 include/uapi/linux/virtio_gpu.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
index f43c3c6171..8e88eba1fa 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -41,6 +41,7 @@
 #include <linux/types.h>
 
 #define VIRTIO_GPU_F_VIRGL 0
+#define VIRTIO_GPU_F_EDID  1
 
 enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_UNDEFINED = 0,
@@ -56,6 +57,7 @@ enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING,
 	VIRTIO_GPU_CMD_GET_CAPSET_INFO,
 	VIRTIO_GPU_CMD_GET_CAPSET,
+	VIRTIO_GPU_CMD_GET_EDID,
 
 	/* 3d commands */
 	VIRTIO_GPU_CMD_CTX_CREATE = 0x0200,
@@ -76,6 +78,7 @@ enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_RESP_OK_DISPLAY_INFO,
 	VIRTIO_GPU_RESP_OK_CAPSET_INFO,
 	VIRTIO_GPU_RESP_OK_CAPSET,
+	VIRTIO_GPU_RESP_OK_EDID,
 
 	/* error responses */
 	VIRTIO_GPU_RESP_ERR_UNSPEC = 0x1200,
@@ -291,6 +294,21 @@ struct virtio_gpu_resp_capset {
 	__u8 capset_data[];
 };
 
+/* VIRTIO_GPU_CMD_GET_EDID */
+struct virtio_gpu_cmd_get_edid {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 scanout;
+	__le32 padding;
+};
+
+/* VIRTIO_GPU_RESP_OK_EDID */
+struct virtio_gpu_resp_edid {
+	struct virtio_gpu_ctrl_hdr hdr;
+	__le32 size;
+	__le32 padding;
+	__u8 edid[1024];
+};
+
 #define VIRTIO_GPU_EVENT_DISPLAY (1 << 0)
 
 struct virtio_gpu_config {
-- 
2.9.3
