From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/4] drm/virtio: switch virtio_gpu_wait_ioctl() to gem helper.
Date: Mon, 17 Jun 2019 13:14:04 +0200
Message-ID: <20190617111406.14765-3-kraxel__2994.30684406019$1560770093$gmane$org@redhat.com>
References: <20190617111406.14765-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190617111406.14765-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Use drm_gem_reservation_object_wait() in virtio_gpu_wait_ioctl().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index c0ba1ead740f..e38a6bb46cc7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -464,23 +464,13 @@ static int virtio_gpu_wait_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *file)
 {
 	struct drm_virtgpu_3d_wait *args = data;
-	struct drm_gem_object *gobj = NULL;
-	struct virtio_gpu_object *qobj = NULL;
-	int ret;
-	bool nowait = false;
-
-	gobj = drm_gem_object_lookup(file, args->handle);
-	if (gobj == NULL)
-		return -ENOENT;
-
-	qobj = gem_to_virtio_gpu_obj(gobj);
+	long timeout = 15 * HZ;
 
 	if (args->flags & VIRTGPU_WAIT_NOWAIT)
-		nowait = true;
-	ret = virtio_gpu_object_wait(qobj, nowait);
+		timeout = 0;
 
-	drm_gem_object_put_unlocked(gobj);
-	return ret;
+	return drm_gem_reservation_object_wait(file, args->handle,
+					       true, timeout);
 }
 
 static int virtio_gpu_get_caps_ioctl(struct drm_device *dev,
-- 
2.18.1
