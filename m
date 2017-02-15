From: Gustavo Padovan <gustavo@padovan.org>
Subject: [PATCH] drm/virtio: call drm_plane_cleanup() at destroy phase
Date: Wed, 15 Feb 2017 16:00:08 -0200
Message-ID: <20170215180009.7091-1-gustavo__24898.5491497026$1487181621$gmane$org@padovan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, Gustavo Padovan <gustavo.padovan@collabora.co.uk>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

virtio was missing this call to clean up core plane usage.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 11288ff..1ff9c64 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -44,6 +44,7 @@ static const uint32_t virtio_gpu_cursor_formats[] = {
 
 static void virtio_gpu_plane_destroy(struct drm_plane *plane)
 {
+	drm_plane_cleanup(plane);
 	kfree(plane);
 }
 
-- 
2.9.3
