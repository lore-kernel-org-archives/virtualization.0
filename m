From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 1/3] virtio-gpu api: comment feature flags
Date: Wed, 10 Apr 2019 13:42:25 +0200
Message-ID: <20190410114227.25846-2-kraxel__38409.5550210745$1554896581$gmane$org@redhat.com>
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

Add comments to the existing feature flags,
documenting which commands belong to them.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/uapi/linux/virtio_gpu.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/virtio_gpu.h b/include/uapi/linux/virtio_gpu.h
index 8e88eba1fa7a..0c85914d9369 100644
--- a/include/uapi/linux/virtio_gpu.h
+++ b/include/uapi/linux/virtio_gpu.h
@@ -40,8 +40,16 @@
 
 #include <linux/types.h>
 
-#define VIRTIO_GPU_F_VIRGL 0
-#define VIRTIO_GPU_F_EDID  1
+/*
+ * VIRTIO_GPU_CMD_CTX_*
+ * VIRTIO_GPU_CMD_*_3D
+ */
+#define VIRTIO_GPU_F_VIRGL               0
+
+/*
+ * VIRTIO_GPU_CMD_GET_EDID
+ */
+#define VIRTIO_GPU_F_EDID                1
 
 enum virtio_gpu_ctrl_type {
 	VIRTIO_GPU_UNDEFINED = 0,
-- 
2.18.1
