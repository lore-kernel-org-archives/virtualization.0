From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 1/4] drm/virtio: simplify virtio_gpu_alloc_cmd
Date: Fri,  7 Feb 2020 08:46:35 +0100
Message-ID: <20200207074638.26386-2-kraxel@redhat.com>
References: <20200207074638.26386-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200207074638.26386-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, gurchetansingh@chromium.org, olvaffe@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

Just call virtio_gpu_alloc_cmd_resp with some fixed args
instead of duplicating most of the function body.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 41e475fbd67b..df499fb64ac7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -120,23 +120,6 @@ virtio_gpu_vbuf_ctrl_hdr(struct virtio_gpu_vbuffer *vbuf)
 	return (struct virtio_gpu_ctrl_hdr *)vbuf->buf;
 }
 
-static void *virtio_gpu_alloc_cmd(struct virtio_gpu_device *vgdev,
-				  struct virtio_gpu_vbuffer **vbuffer_p,
-				  int size)
-{
-	struct virtio_gpu_vbuffer *vbuf;
-
-	vbuf = virtio_gpu_get_vbuf(vgdev, size,
-				   sizeof(struct virtio_gpu_ctrl_hdr),
-				   NULL, NULL);
-	if (IS_ERR(vbuf)) {
-		*vbuffer_p = NULL;
-		return ERR_CAST(vbuf);
-	}
-	*vbuffer_p = vbuf;
-	return vbuf->buf;
-}
-
 static struct virtio_gpu_update_cursor*
 virtio_gpu_alloc_cursor(struct virtio_gpu_device *vgdev,
 			struct virtio_gpu_vbuffer **vbuffer_p)
@@ -172,6 +155,15 @@ static void *virtio_gpu_alloc_cmd_resp(struct virtio_gpu_device *vgdev,
 	return (struct virtio_gpu_command *)vbuf->buf;
 }
 
+static void *virtio_gpu_alloc_cmd(struct virtio_gpu_device *vgdev,
+				  struct virtio_gpu_vbuffer **vbuffer_p,
+				  int size)
+{
+	return virtio_gpu_alloc_cmd_resp(vgdev, NULL, vbuffer_p, size,
+					 sizeof(struct virtio_gpu_ctrl_hdr),
+					 NULL);
+}
+
 static void free_vbuf(struct virtio_gpu_device *vgdev,
 		      struct virtio_gpu_vbuffer *vbuf)
 {
-- 
2.18.1
