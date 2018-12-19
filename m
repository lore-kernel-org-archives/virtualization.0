From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 02/10] drm/virtio: fix pageflip flush
Date: Wed, 19 Dec 2018 13:27:00 +0100
Message-ID: <20181219122708.4586-3-kraxel__25796.6297482655$1545222356$gmane$org@redhat.com>
References: <20181219122708.4586-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181219122708.4586-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Sending the flush command only makes sense if we actually have
a framebuffer attached to the scanout (handle != 0).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index ead5c53d4e..548265b8e8 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -130,11 +130,12 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 				   plane->state->src_h >> 16,
 				   plane->state->src_x >> 16,
 				   plane->state->src_y >> 16);
-	virtio_gpu_cmd_resource_flush(vgdev, handle,
-				      plane->state->src_x >> 16,
-				      plane->state->src_y >> 16,
-				      plane->state->src_w >> 16,
-				      plane->state->src_h >> 16);
+	if (handle)
+		virtio_gpu_cmd_resource_flush(vgdev, handle,
+					      plane->state->src_x >> 16,
+					      plane->state->src_y >> 16,
+					      plane->state->src_w >> 16,
+					      plane->state->src_h >> 16);
 }
 
 static int virtio_gpu_cursor_prepare_fb(struct drm_plane *plane,
-- 
2.9.3
