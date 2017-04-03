From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/2] drm: virtio: fix virtio_gpu_mode_dumb_create
Date: Mon,  3 Apr 2017 09:08:45 +0200
Message-ID: <20170403070845.10793-3-kraxel__31679.9417174936$1491203377$gmane$org@redhat.com>
References: <20170403070845.10793-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170403070845.10793-1-kraxel@redhat.com>
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
Cc: lvivier@redhat.com, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Lookup format using virtio_gpu_translate_format()
instead of hardcoding it.  Fixes xorg display on
bigendian guests (i.e. ppc64).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_gem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 336a57f..cc025d8 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -88,6 +88,7 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	int ret;
 	uint32_t pitch;
 	uint32_t resid;
+	uint32_t format;
 
 	pitch = args->width * ((args->bpp + 1) / 8);
 	args->size = pitch * args->height;
@@ -98,9 +99,10 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	if (ret)
 		goto fail;
 
+	format = virtio_gpu_translate_format(DRM_FORMAT_XRGB8888);
 	virtio_gpu_resource_id_get(vgdev, &resid);
-	virtio_gpu_cmd_create_resource(vgdev, resid,
-				       2, args->width, args->height);
+	virtio_gpu_cmd_create_resource(vgdev, resid, format,
+				       args->width, args->height);
 
 	/* attach the object to the resource */
 	obj = gem_to_virtio_gpu_obj(gobj);
-- 
2.9.3
