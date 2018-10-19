From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 3/6] drm/virtio: use virtio_gpu_object->hw_res_handle in
	virtio_gpu_mode_dumb_create()
Date: Fri, 19 Oct 2018 08:18:44 +0200
Message-ID: <20181019061847.18958-4-kraxel__5414.1805893325$1539929862$gmane$org@redhat.com>
References: <20181019061847.18958-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181019061847.18958-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Drop pointless resid variable in virtio_gpu_mode_dumb_create(), just use
the hw_res_handle field in virtio_gpu_object directly.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_gem.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 33dbd5aed7..8d53451ec4 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -87,7 +87,6 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	struct virtio_gpu_object *obj;
 	int ret;
 	uint32_t pitch;
-	uint32_t resid;
 	uint32_t format;
 
 	if (args->bpp != 32)
@@ -104,13 +103,12 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 
 	format = virtio_gpu_translate_format(DRM_FORMAT_HOST_XRGB8888);
 	obj = gem_to_virtio_gpu_obj(gobj);
-	virtio_gpu_resource_id_get(vgdev, &resid);
-	virtio_gpu_cmd_create_resource(vgdev, obj, resid, format,
+	virtio_gpu_resource_id_get(vgdev, &obj->hw_res_handle);
+	virtio_gpu_cmd_create_resource(vgdev, obj, obj->hw_res_handle, format,
 				       args->width, args->height);
 
 	/* attach the object to the resource */
-	obj = gem_to_virtio_gpu_obj(gobj);
-	ret = virtio_gpu_object_attach(vgdev, obj, resid, NULL);
+	ret = virtio_gpu_object_attach(vgdev, obj, obj->hw_res_handle, NULL);
 	if (ret)
 		goto fail;
 
-- 
2.9.3
