From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 2/6] drm/virtio: use virtio_gpu_object->hw_res_handle in
	virtio_gpufb_create()
Date: Fri, 19 Oct 2018 08:18:43 +0200
Message-ID: <20181019061847.18958-3-kraxel__32325.7301621654$1539929808$gmane$org@redhat.com>
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

Drop pointless resid variable in virtio_gpufb_create(), just use
the hw_res_handle field in virtio_gpu_object directly.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_fb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_fb.c b/drivers/gpu/drm/virtio/virtgpu_fb.c
index d39f4f3350..800960bdd9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_fb.c
+++ b/drivers/gpu/drm/virtio/virtgpu_fb.c
@@ -214,7 +214,7 @@ static int virtio_gpufb_create(struct drm_fb_helper *helper,
 	struct drm_framebuffer *fb;
 	struct drm_mode_fb_cmd2 mode_cmd = {};
 	struct virtio_gpu_object *obj;
-	uint32_t resid, format, size;
+	uint32_t format, size;
 	int ret;
 
 	mode_cmd.width = sizes->surface_width;
@@ -231,8 +231,8 @@ static int virtio_gpufb_create(struct drm_fb_helper *helper,
 	if (IS_ERR(obj))
 		return PTR_ERR(obj);
 
-	virtio_gpu_resource_id_get(vgdev, &resid);
-	virtio_gpu_cmd_create_resource(vgdev, obj, resid, format,
+	virtio_gpu_resource_id_get(vgdev, &obj->hw_res_handle);
+	virtio_gpu_cmd_create_resource(vgdev, obj, obj->hw_res_handle, format,
 				       mode_cmd.width, mode_cmd.height);
 
 	ret = virtio_gpu_object_kmap(obj);
@@ -242,7 +242,7 @@ static int virtio_gpufb_create(struct drm_fb_helper *helper,
 	}
 
 	/* attach the object to the resource */
-	ret = virtio_gpu_object_attach(vgdev, obj, resid, NULL);
+	ret = virtio_gpu_object_attach(vgdev, obj, obj->hw_res_handle, NULL);
 	if (ret)
 		goto err_obj_attach;
 
-- 
2.9.3
